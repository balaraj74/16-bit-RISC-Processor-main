module mem (
    input wire clk,
    input wire [15:0] addr,
    input wire [15:0] wdata,
    input wire we,
    output reg [15:0] rdata
);
    reg [15:0] memory [0:65535]; // 64KB memory

    always @(posedge clk) begin
        if (we) begin
            memory[addr] <= wdata; // Write data to memory
        end
        rdata <= memory[addr]; // Read data from memory
    end
endmodule