`timescale 1ns/1ps
module tb;
    reg clk;
    reg rst;
    wire halted;
    wire [15:0] mem_addr;
    wire [15:0] mem_wdata;
    wire mem_we;
    wire [15:0] mem_rdata;

    // instantiate CPU
    cpu DUT(
        .clk(clk),
        .rst(rst),
        .halted(halted),
        .mem_addr(mem_addr),
        .mem_rdata(mem_rdata),
        .mem_wdata(mem_wdata),
        .mem_we(mem_we)
    );

    // instantiate mem
    mem MEM(
        .clk(clk),
        .addr(mem_addr),
        .wdata(mem_wdata),
        .we(mem_we),
        .rdata(mem_rdata)
    );

    initial begin
        $dumpfile("cpu.vcd");
        $dumpvars(0, tb);
        clk = 0;
        rst = 1;
        #20;
        rst = 0;

        // run until HALT or timeout
        repeat (1000) begin
            #10;
            if (halted) begin
                $display("CPU halted at time %0t", $time);
                // dump registers for inspection by calling internal regfile (only for simulation)
                $display("Register file dump:");
                $display("R0=%h R1=%h R2=%h R3=%h", DUT.regfile[0], DUT.regfile[1], DUT.regfile[2], DUT.regfile[3]);
                $display("R4=%h R5=%h R6=%h R7=%h", DUT.regfile[4], DUT.regfile[5], DUT.regfile[6], DUT.regfile[7]);
                $display("R8=%h R9=%h R10=%h R11=%h", DUT.regfile[8], DUT.regfile[9], DUT.regfile[10], DUT.regfile[11]);
                $display("R12=%h R13=%h R14=%h R15=%h", DUT.regfile[12], DUT.regfile[13], DUT.regfile[14], DUT.regfile[15]);
                #10;
                $finish;
            end
        end
        $display("Timeout - finishing");
        $finish;
    end

    // clock
    always #5 clk = ~clk;
endmodule`