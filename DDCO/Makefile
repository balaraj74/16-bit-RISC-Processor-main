# Makefile for DDCO project

# Variables
VERILOG_SOURCES = src/cpu.v src/mem.v sim/tb.v
SIMULATOR = iverilog
SIMULATION = vvp
DUMP_FILE = cpu.vcd

# Targets
all: compile simulate

compile:
	$(SIMULATOR) -o sim.out $(VERILOG_SOURCES)

simulate: compile
	$(SIMULATION) sim.out
	@echo "Simulation finished. Output dumped to $(DUMP_FILE)"

clean:
	rm -f sim.out $(DUMP_FILE)

.PHONY: all compile simulate clean