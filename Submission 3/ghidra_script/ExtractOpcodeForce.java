import java.io.*;
import java.util.*;

import ghidra.app.script.GhidraScript;
import ghidra.program.model.listing.*;
import ghidra.program.model.address.*;

public class ExtractOpcodeForce extends GhidraScript {

    @Override
    public void run() throws Exception {

        if (currentProgram == null) {
            printerr("No program loaded.");
            return;
        }

        // Arg0 = output folder
        String outDirPath = (getScriptArgs().length > 0) ? getScriptArgs()[0] : null;
        if (outDirPath == null || outDirPath.trim().isEmpty()) {
            printerr("Usage: -postScript ExtractOpcodeForce.java <OUTPUT_DIR>");
            return;
        }

        File outDir = new File(outDirPath);
        if (!outDir.exists()) outDir.mkdirs();

        // Name output file to match the imported program name (your EXE base name)
        String baseName = currentProgram.getName();
        File outFile = new File(outDir, baseName + ".opcode");

        // If already exists and non-empty, skip (so you don't recreate)
        if (outFile.exists() && outFile.length() > 0) {
            println("[SKIP] " + outFile.getAbsolutePath() + " already exists (" + outFile.length() + " bytes)");
            return;
        }

        Listing listing = currentProgram.getListing();
        InstructionIterator it = listing.getInstructions(true);

        // Write mnemonics (one per line)
        long count = 0;
        try (BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outFile), "UTF-8"))) {
            while (it.hasNext() && !monitor.isCancelled()) {
                Instruction ins = it.next();
                String mnem = ins.getMnemonicString();
                if (mnem != null && !mnem.isEmpty()) {
                    bw.write(mnem);
                    bw.newLine();
                    count++;
                }
            }
        }

        // If nothing got written, delete the empty file (so you can re-try later)
        if (count == 0) {
            outFile.delete();
            printerr("[EMPTY] No instructions found, deleted empty: " + outFile.getAbsolutePath());
        } else {
            println("[OK] Wrote " + count + " mnemonics to: " + outFile.getAbsolutePath());
        }
    }
}