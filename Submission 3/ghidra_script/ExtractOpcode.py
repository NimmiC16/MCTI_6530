# ExtractOpcodes.py
# Extracts opcode mnemonics from all instructions in the current program
# and saves them in multiple formats for ML / analysis use.

from ghidra.program.model.listing import Instruction
from ghidra.util.task import TaskMonitor
from java.io import FileWriter, BufferedWriter
from java.util import ArrayList
import json
import os

program = currentProgram
listing = program.getListing()

# Ask user for output directory
output_dir = askDirectory("Select output directory", "Choose")

# Ask for base filename
base_name = askString("Sample name", "Enter base filename (no .exe)")

opcode_file = os.path.join(output_dir.getAbsolutePath(), base_name + ".opcode")
opcode_hex_file = os.path.join(output_dir.getAbsolutePath(), base_name + ".opcode_hex")
meta_file = os.path.join(output_dir.getAbsolutePath(), base_name + ".meta.json")

mnemonics = []
mnemonics_hex = []

instr_iter = listing.getInstructions(True)

count = 0
while instr_iter.hasNext():
    instr = instr_iter.next()
    mnem = instr.getMnemonicString()
    mnemonics.append(mnem)

    bytes_hex = instr.getBytes()
    hex_str = ''.join(['%02x' % (b & 0xff) for b in bytes_hex])
    mnemonics_hex.append(hex_str)

    count += 1

# Write opcode mnemonics
with open(opcode_file, "w") as f:
    for m in mnemonics:
        f.write(m + "\n")

# Write opcode hex
with open(opcode_hex_file, "w") as f:
    for h in mnemonics_hex:
        f.write(h + "\n")

# Metadata
meta = {
    "sample": base_name,
    "instruction_count": count,
    "language": str(program.getLanguage()),
    "compiler": str(program.getCompilerSpec()),
    "ghidra_version": getGhidraVersion()
}

with open(meta_file, "w") as f:
    json.dump(meta, f, indent=2)

print("[+] Opcode extraction complete")
print("[+] Instructions:", count)