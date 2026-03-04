// ExtractOpcodeFast.java
// @category Submission
// @author Nimmi
// @menupath Tools.Opcode.ExtractOpcodeFast
// @keybinding

import java.io.*;
import ghidra.app.script.GhidraScript;
import ghidra.app.cmd.disassemble.DisassembleCommand;
import ghidra.program.model.address.*;
import ghidra.program.model.listing.*;
import ghidra.program.model.mem.*;

public class ExtractOpcodeFast extends GhidraScript {

    @Override
    public void run() throws Exception {

        if (getScriptArgs().length < 1) {
            printerr("Usage: ExtractOpcodeFast.java <output_folder>");
            return;
        }

        File outDir = new File(getScriptArgs()[0]);
        if (!outDir.exists() && !outDir.mkdirs()) {
            printerr("Could not create output dir: " + outDir.getAbsolutePath());
            return;
        }

        String progName = currentProgram.getName(); // usually includes .exe
        String base = progName;
        if (base.toLowerCase().endsWith(".exe")) {
            base = base.substring(0, base.length() - 4);
        }
        File outFile = new File(outDir, base + ".opcode");

        // Skip if already created and not empty
        if (outFile.exists() && outFile.length() > 0) {
            println("[SKIP] Already exists: " + outFile.getName());
            return;
        }

        // --------- Disassemble executable memory blocks (no analysis / no decompiler) ----------
        Listing listing = currentProgram.getListing();
        Memory mem = currentProgram.getMemory();

        for (MemoryBlock b : mem.getBlocks()) {
            if (monitor.isCancelled()) return;
            if (!b.isExecute()) continue;

            Address start = b.getStart();
            DisassembleCommand cmd = new DisassembleCommand(start, null, true);
            cmd.applyTo(currentProgram, monitor);
        }

        // --------- Write mnemonics ----------
        int count = 0;
        try (BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outFile), "UTF-8"))) {
            InstructionIterator it = listing.getInstructions(true);
            while (it.hasNext()) {
                if (monitor.isCancelled()) return;
                Instruction ins = it.next();
                bw.write(ins.getMnemonicString());
                bw.newLine();
                count++;
            }
        }

        // If nothing extracted, delete the empty file (prevents “blank .opcode”)
        if (count == 0) {
            outFile.delete();
            println("[EMPTY] No instructions -> deleted: " + outFile.getName());
        } else {
            println("[OK] Wrote " + count + " opcodes -> " + outFile.getAbsolutePath());
        }
    }
}