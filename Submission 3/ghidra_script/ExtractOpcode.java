// ExtractOpcode.java
// Exports instruction mnemonics for the entire program to <outDir>\<programName>.opcode
// Headless usage: -postScript ExtractOpcode "<outDir>"

import java.io.*;
import java.nio.charset.StandardCharsets;

import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.listing.Instruction;
import ghidra.program.model.listing.Listing;

public class ExtractOpcode extends GhidraScript {

    @Override
    public void run() throws Exception {
        if (currentProgram == null) {
            println("No currentProgram. Exiting.");
            return;
        }

        String outDir = null;
        if (getScriptArgs() != null && getScriptArgs().length > 0) {
            outDir = getScriptArgs()[0];
        }

        if (outDir == null || outDir.trim().isEmpty()) {
            printerr("ERROR: Output directory not provided. Usage: -postScript ExtractOpcode \"C:\\path\\OpCode\"");
            return;
        }

        File outFolder = new File(outDir);
        if (!outFolder.exists() && !outFolder.mkdirs()) {
            printerr("ERROR: Could not create output directory: " + outFolder.getAbsolutePath());
            return;
        }

        // Program name without extension (so your output matches your EXE base name)
        String baseName = currentProgram.getName();
        int dot = baseName.lastIndexOf('.');
        if (dot > 0) baseName = baseName.substring(0, dot);

        File outFile = new File(outFolder, baseName + ".opcode");

        // Skip overwriting a non-empty existing opcode file
        if (outFile.exists() && outFile.length() > 0) {
            println("Skipping (already exists, non-empty): " + outFile.getAbsolutePath());
            return;
        }

        Listing listing = currentProgram.getListing();
        long count = 0;

        // Iterate ALL instructions in the program (not functions, not decompiler)
        try (BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream(outFile, false), StandardCharsets.UTF_8))) {

            for (Instruction ins : listing.getInstructions(true)) {
                Address a = ins.getAddress();
                String mnem = ins.getMnemonicString();
                if (mnem != null && !mnem.isEmpty()) {
                    // If you want just opcode mnemonic:
                    bw.write(mnem);

                    // If you want address + mnemonic instead, use:
                    // bw.write(a.toString() + " " + mnem);

                    bw.newLine();
                    count++;
                }

                if (monitor.isCancelled()) {
                    println("Cancelled by user.");
                    break;
                }
            }

            // Never leave it empty — helps you detect “no instructions were created”
            if (count == 0) {
                bw.write("NO_INSTRUCTIONS_FOUND");
                bw.newLine();
            }
        }

        println("Wrote " + count + " instructions to: " + outFile.getAbsolutePath());
    }
}