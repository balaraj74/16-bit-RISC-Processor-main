// mem.v - simple synchronous memory model (word addressed)
// size: 256 words (16-bit each)
module mem(
    input clk,
    input [15:0] addr,
    input [15:0] wdata,
    input we,
    output reg [15:0] rdata
);
    reg [15:0] mem_array [0:255];

    initial begin
        // optionally load a hex file here:
        $readmemh("mem_init.hex", mem_array);
    end

    always @(posedge clk) begin
        if (we) begin
            mem_array[addr] <= wdata;
        end
        rdata <= mem_array[addr];
    end

    // for debug
    task dump_mem;
        input integer start, finish;
        integer i;
        begin
            for (i = start; i <= finish; i = i + 1)
                $display("MEM[%0d] = %0h", i, mem_array[i]);
        end
    endtask
endmodule

