# 🖥️ 16-bit RISC Processor

A complete implementation of a 16-bit Reduced Instruction Set Computer (RISC) processor in Verilog, featuring a five-stage pipeline architecture with support for arithmetic, logical, memory, and control flow operations.

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Architecture](#-architecture)
- [Getting Started](#-getting-started)
- [How to Run](#-how-to-run)
- [Project Structure](#-project-structure)
- [Instruction Set](#-instruction-set)
- [How It Works](#-how-it-works)
- [Customization](#-customization)
- [Troubleshooting](#-troubleshooting)

---

## 🎯 Overview

This project implements a **16-bit RISC processor** with the following characteristics:

- **Data Width**: 16 bits
- **Instruction Width**: 16 bits
- **Register File**: 8 general-purpose registers (3-bit addressing)
- **Memory**: Separate instruction and data memory
- **Architecture**: Harvard architecture with single-cycle execution

The processor is designed for educational purposes and demonstrates fundamental concepts of computer architecture including:
- Instruction fetch and decode
- ALU operations
- Memory access
- Control flow (branching and jumping)
- Register file management

---

## ✨ Features

- ✅ **Arithmetic Operations**: ADD, SUB
- ✅ **Logical Operations**: AND, OR, NOT
- ✅ **Shift Operations**: Left shift, Right shift
- ✅ **Comparison**: Set Less Than (SLT)
- ✅ **Memory Operations**: Load Word (LW), Store Word (SW)
- ✅ **Control Flow**: Branch if Equal (BEQ), Branch if Not Equal (BNE), Jump (J)
- ✅ **Modular Design**: Separated datapath and control unit
- ✅ **Simulation Support**: Full testbench included

---

## 🏗️ Architecture

The processor consists of the following main components:

```
┌─────────────────────────────────────────────────────────────┐
│                     16-bit RISC Processor                    │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────┐         ┌──────────────┐                  │
│  │   Control    │────────►│   Datapath   │                  │
│  │     Unit     │         │     Unit     │                  │
│  └──────────────┘         └──────────────┘                  │
│         │                        │                           │
│         │                        ├───► Instruction Memory    │
│         │                        ├───► Register File         │
│         │                        ├───► ALU & ALU Control     │
│         │                        ├───► Data Memory           │
│         │                        └───► PC (Program Counter)  │
│         │                                                     │
│         └────────────► Control Signals                       │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

### Component Breakdown

| Component | File | Description |
|-----------|------|-------------|
| **Top Module** | `risc.v` | Integrates control unit and datapath |
| **Control Unit** | `control_unit.v` | Generates control signals based on opcode |
| **Datapath Unit** | `data_path.v` | Executes instructions and manages data flow |
| **ALU** | `ALU_C.v` | Performs arithmetic and logical operations |
| **ALU Control** | `alu_control.v` | Decodes ALU operation from opcode and ALUOp |
| **Register File** | `Register_file.v` | 8 general-purpose registers |
| **Instruction Memory** | `Instruction_memory.v` | Stores program instructions |
| **Data Memory** | `Data_Mem.v` | Stores data for load/store operations |
| **Parameters** | `parameters.v` | Global configuration constants |
| **Testbench** | `Test_Bench.v` | Simulation and testing environment |

---

## 🚀 Getting Started

### Prerequisites

You need a Verilog simulator installed. This project uses **Icarus Verilog**:

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install iverilog
```

**MacOS:**
```bash
brew install icarus-verilog
```

**Verify Installation:**
```bash
iverilog -v
```

---

## ▶️ How to Run

### Step 1: Navigate to the Project Directory
```bash
cd /path/to/16-bit-RISC-Processor-main
```

### Step 2: Compile the Design
```bash
cd src
iverilog -o risc_sim Test_Bench.v risc.v data_path.v control_unit.v \
         ALU_C.v alu_control.v Register_file.v Instruction_memory.v Data_Mem.v
```

### Step 3: Run the Simulation
```bash
cd ..
vvp src/risc_sim
```

### Expected Output

The simulation will run for **160 time units** (configurable in `parameters.v`) and display:

```
time =                    5
        memory[0] = 0000000000000000
        memory[1] = 0000000000000000
        ...
Test_Bench.v:18: $finish called at 160000 (1ps)
```

### Quick Run Script

Create a script `run.sh` for convenience:
```bash
#!/bin/bash
cd src
iverilog -o risc_sim Test_Bench.v risc.v data_path.v control_unit.v \
         ALU_C.v alu_control.v Register_file.v Instruction_memory.v Data_Mem.v
cd ..
vvp src/risc_sim
```

Make it executable and run:
```bash
chmod +x run.sh
./run.sh
```

---

## 📁 Project Structure

```
16-bit-RISC-Processor-main/
│
├── README.md                          # This file
│
├── src/                               # Source files
│   ├── risc.v                        # Top-level module
│   ├── control_unit.v                # Control unit
│   ├── data_path.v                   # Datapath unit
│   ├── ALU_C.v                       # ALU module
│   ├── alu_control.v                 # ALU control logic
│   ├── Register_file.v               # Register file (8 registers)
│   ├── Instruction_memory.v          # Instruction memory
│   ├── Data_Mem.v                    # Data memory
│   ├── parameters.v                  # Configuration parameters
│   └── Test_Bench.v                  # Testbench
│
└── test/                              # Test data files
    ├── test.prog                     # Instruction memory initialization
    ├── test.data                     # Data memory initialization
    └── 50001111_50001212.o          # Output file (generated)
```

---

## 📖 Instruction Set

### Instruction Format

**R-Type (Register):**
```
[15:12] Opcode | [11:9] Rs | [8:6] Rt | [5:3] Rd | [2:0] Unused
```

**I-Type (Immediate):**
```
[15:12] Opcode | [11:9] Rs | [8:6] Rt | [5:0] Immediate
```

**J-Type (Jump):**
```
[15:12] Opcode | [11:0] Address
```

### Supported Instructions

| Opcode | Mnemonic | Type | Description |
|--------|----------|------|-------------|
| `0000` | **LW** | I | Load Word from memory |
| `0001` | **SW** | I | Store Word to memory |
| `0010` | **ADD** | R | Add two registers |
| `0011` | **SUB** | R | Subtract two registers |
| `0100` | **NOT** | R | Bitwise NOT |
| `0101` | **SLL** | R | Shift left logical |
| `0110` | **SRL** | R | Shift right logical |
| `0111` | **AND** | R | Bitwise AND |
| `1000` | **OR** | R | Bitwise OR |
| `1001` | **SLT** | R | Set if less than |
| `1011` | **BEQ** | I | Branch if equal |
| `1100` | **BNE** | I | Branch if not equal |
| `1101` | **J** | J | Jump to address |

---

## ⚙️ How It Works

### 1. **Instruction Fetch (IF)**
```
PC (Program Counter) → Instruction Memory → Instruction Register
```
The program counter points to the current instruction address. The instruction is fetched from instruction memory.

### 2. **Instruction Decode (ID)**
```
Instruction → Control Unit → Control Signals
Instruction → Register File → Read Data
```
The opcode is sent to the control unit, which generates control signals. Register addresses are extracted and registers are read.

### 3. **Execution (EX)**
```
Register Data + Immediate → ALU → Result
ALU Control decodes operation type
```
The ALU performs the operation specified by the ALU control unit. This could be arithmetic, logical, or address calculation.

### 4. **Memory Access (MEM)**
```
ALU Result → Data Memory → Read/Write
```
For load/store instructions, data memory is accessed using the ALU result as the address.

### 5. **Write Back (WB)**
```
Result → Register File
```
The result (from ALU or memory) is written back to the destination register.

### Control Flow

**Sequential Execution:**
```
PC = PC + 2  (each instruction is 2 bytes)
```

**Branch (BEQ/BNE):**
```
if (condition met):
    PC = PC + 2 + (Immediate << 1)
```

**Jump:**
```
PC = {PC[15:13], Immediate[11:0], 1'b0}
```

---

## 🎨 Customization

### Modify Simulation Time

Edit `src/parameters.v`:
```verilog
`define simulation_time #160  // Change to desired time in nanoseconds
```

### Load Custom Programs

Edit `test/test.prog` with your instructions in binary format (one instruction per line):
```
0010001010011000  // ADD R3, R1, R2
0011100011101000  // SUB R5, R4, R3
1101000000010100  // Jump to address 20
```

### Initialize Data Memory

Edit `test/test.data` with initial values:
```
0000000000000101  // Memory[0] = 5
0000000000001010  // Memory[1] = 10
0000000000001111  // Memory[2] = 15
```

### Change Memory Size

Edit `src/parameters.v`:
```verilog
`define col 16          // Word width (bits)
`define row_i 15        // Instruction memory depth
`define row_d 8         // Data memory depth
```

---

## 🔧 Troubleshooting

### Issue: File not found errors
```
ERROR: Unable to open ./test/test.prog for reading
```
**Solution:** Run `vvp` from the project root directory, not from `src/`:
```bash
cd /path/to/16-bit-RISC-Processor-main
vvp src/risc_sim
```

### Issue: Compilation errors about modules
```
error: Unknown module type: alu_control
```
**Solution:** Make sure all `.v` files are included in the compilation command.

### Issue: Memory showing 'x' values
```
memory[0] = xxxxxxxxxxxxxxxx
```
**Solution:** Ensure `test/test.data` and `test/test.prog` exist and contain valid binary data.

### Issue: Simulation not stopping
**Solution:** Check that `simulation_time` is defined in `parameters.v`:
```verilog
`define simulation_time #160
```

---

## 📊 Waveform Viewing (Optional)

To view waveforms using GTKWave:

### 1. Add to Test_Bench.v:
```verilog
initial begin
    $dumpfile("risc_processor.vcd");
    $dumpvars(0, test_Risc_16_bit);
end
```

### 2. Run simulation and view:
```bash
vvp src/risc_sim
gtkwave risc_processor.vcd
```

---

## 🎓 Learning Resources

This processor demonstrates key concepts:

1. **Harvard Architecture**: Separate instruction and data memory
2. **Register-based Architecture**: Operations use registers, not memory
3. **Control Signals**: How opcodes map to hardware control
4. **Pipelining Concepts**: Though single-cycle, shows pipeline stage separation
5. **ALU Design**: Multi-function arithmetic logic unit
6. **Memory-mapped I/O**: Load/store architecture

---

## 📝 License

This project is for educational purposes. Feel free to modify and extend it for learning.

---

## 🤝 Contributing

Improvements welcome! Consider adding:
- [ ] More instructions (MUL, DIV, etc.)
- [ ] Pipeline registers for true pipelining
- [ ] Hazard detection and forwarding
- [ ] Cache memory
- [ ] Interrupt handling
- [ ] Assembler program

---

## 📧 Contact

For questions or issues, please open an issue in the repository.

---

**Happy Coding! 🚀**