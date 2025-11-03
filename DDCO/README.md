# DDCO Project

## Overview
The DDCO project is a digital design project that implements a simple CPU and memory system using Verilog. The project includes a testbench for simulating the behavior of the CPU and memory modules.

## Project Structure
```
DDCO
├── src
│   ├── cpu.v        # Verilog code for the CPU module
│   └── mem.v        # Verilog code for the memory module
├── sim
│   └── tb.v         # Testbench for the CPU and memory modules
├── Makefile         # Build instructions for compiling and simulating
├── .gitignore       # Files and directories to be ignored by Git
└── README.md        # Documentation for the project
```

## Setup Instructions
1. Clone the repository:
   ```
   git clone https://github.com/yourusername/DDCO.git
   ```
2. Navigate to the project directory:
   ```
   cd DDCO
   ```

## Usage Guidelines
- To compile the Verilog files and run the simulation, use the provided Makefile. Run the following command:
  ```
  make
  ```
- To clean up generated files, run:
  ```
  make clean
  ```

## Contributing
Contributions are welcome! Please feel free to submit a pull request or open an issue for any suggestions or improvements.