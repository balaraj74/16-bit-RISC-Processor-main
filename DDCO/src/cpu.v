module cpu (
    input wire clk,
    input wire rst,
    output reg halted,
    output reg [15:0] mem_addr,
    input wire [15:0] mem_rdata,
    output reg [15:0] mem_wdata,
    output reg mem_we
);
    // Internal registers
    reg [15:0] regfile [0:15]; // 16 registers
    reg [15:0] pc; // Program counter

    // CPU states
    localparam STATE_FETCH = 2'b00;
    localparam STATE_EXECUTE = 2'b01;
    localparam STATE_WRITEBACK = 2'b10;

    reg [1:0] state;

    // Main CPU process
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            halted <= 0;
            pc <= 0;
            state <= STATE_FETCH;
            // Initialize registers
            integer i;
            for (i = 0; i < 16; i = i + 1) begin
                regfile[i] <= 0;
            end
        end else begin
            case (state)
                STATE_FETCH: begin
                    mem_addr <= pc;
                    state <= STATE_EXECUTE;
                end
                STATE_EXECUTE: begin
                    // Execute instruction (placeholder for actual instruction decoding)
                    // For example, incrementing the program counter
                    pc <= pc + 1;
                    state <= STATE_WRITEBACK;
                end
                STATE_WRITEBACK: begin
                    // Write back to memory (placeholder)
                    mem_wdata <= regfile[0]; // Example: write register 0 to memory
                    mem_we <= 1; // Enable write
                    state <= STATE_FETCH;
                end
            endcase
        end
    end

    // Halt condition (placeholder)
    always @(posedge clk) begin
        if (pc >= 16'hFFFF) begin
            halted <= 1;
        end
    end
endmodule