// cpu.v - simple single-cycle 16-bit RISC CPU
module cpu(
    input clk,
    input rst,
    output reg halted,
    // memory interface (word addressed, synchronous read via mem module)
    output reg [15:0] mem_addr,
    input  [15:0] mem_rdata,
    output reg [15:0] mem_wdata,
    output reg mem_we
);
    reg [15:0] pc;
    reg [15:0] inst;

    // register file: 16 x 16-bit
    reg [15:0] regfile [0:15];

    // instruction fields
    wire [3:0] opcode = inst[15:12];
    wire [3:0] rd     = inst[11:8];
    wire [3:0] rs     = inst[7:4];
    wire [3:0] rt     = inst[3:0];
    wire [7:0] imm8   = inst[7:0];
    wire [3:0] off4   = inst[3:0];
    wire [3:0] base4  = inst[7:4];
    wire [3:0] rs_br  = inst[11:8];
    wire [3:0] rt_br  = inst[7:4];

    // sign-extend helpers
    function [15:0] sign_ext4;
        input [3:0] x; begin
            sign_ext4 = {{12{x[3]}}, x};
        end
    endfunction

    function [15:0] sign_ext8;
        input [7:0] x; begin
            sign_ext8 = {{8{x[7]}}, x};
        end
    endfunction

    // ALU result
    reg [15:0] alu_out;

    // synchronous fetch on rising edge (simple single-cycle)
    always @(posedge clk) begin
        if (rst) begin
            pc <= 16'd0;
            halted <= 0;
            mem_we <= 0;
            mem_addr <= 16'd0;
            mem_wdata <= 16'd0;
            // zero registers
            regfile[0] <= 16'd0;
            regfile[1] <= 16'd0;
            regfile[2] <= 16'd0;
            regfile[3] <= 16'd0;
            regfile[4] <= 16'd0;
            regfile[5] <= 16'd0;
            regfile[6] <= 16'd0;
            regfile[7] <= 16'd0;
            regfile[8] <= 16'd0;
            regfile[9] <= 16'd0;
            regfile[10] <= 16'd0;
            regfile[11] <= 16'd0;
            regfile[12] <= 16'd0;
            regfile[13] <= 16'd0;
            regfile[14] <= 16'd0;
            regfile[15] <= 16'd0;
        end else if (!halted) begin
            // Fetch instruction (memory word)
            mem_addr <= pc;
            mem_we <= 0;
            inst <= mem_rdata;

            // decode & execute immediately (single cycle)
            case (opcode)
                4'h0: begin // ADD rd = rs + rt
                    alu_out = regfile[rs] + regfile[rt];
                    regfile[rd] <= alu_out;
                    pc <= pc + 1;
                end
                4'h1: begin // SUB
                    alu_out = regfile[rs] - regfile[rt];
                    regfile[rd] <= alu_out;
                    pc <= pc + 1;
                end
                4'h2: begin // AND
                    regfile[rd] <= regfile[rs] & regfile[rt];
                    pc <= pc + 1;
                end
                4'h3: begin // OR
                    regfile[rd] <= regfile[rs] | regfile[rt];
                    pc <= pc + 1;
                end
                4'h4: begin // XOR
                    regfile[rd] <= regfile[rs] ^ regfile[rt];
                    pc <= pc + 1;
                end
                4'h5: begin // SLT (unsigned)
                    regfile[rd] <= (regfile[rs] < regfile[rt]) ? 16'd1 : 16'd0;
                    pc <= pc + 1;
                end
                4'h6: begin // ADDI rd = rd + sign_ext(imm8)
                    regfile[rd] <= regfile[rd] + sign_ext8(imm8);
                    pc <= pc + 1;
                end
                4'h7: begin // LOADI rd = imm8 (zero-extend)
                    regfile[rd] <= {8'd0, imm8};
                    pc <= pc + 1;
                end
                4'h8: begin // LD rd, base+off4
                    mem_addr <= regfile[base4] + sign_ext4(off4);
                    mem_we <= 0;
                    // read mem_rdata next cycle - but for simplicity we assume mem_rdata is valid this cycle
                    regfile[rd] <= mem_rdata;
                    pc <= pc + 1;
                end
                4'h9: begin // ST rd -> [base+off4]
                    mem_addr <= regfile[base4] + sign_ext4(off4);
                    mem_wdata <= regfile[rd];
                    mem_we <= 1;
                    pc <= pc + 1;
                end
                4'hA: begin // BEQ
                    if (regfile[rs_br] == regfile[rt_br])
                        pc <= pc + sign_ext4(off4);
                    else
                        pc <= pc + 1;
                    mem_we <= 0;
                end
                4'hB: begin // BNE
                    if (regfile[rs_br] != regfile[rt_br])
                        pc <= pc + sign_ext4(off4);
                    else
                        pc <= pc + 1;
                    mem_we <= 0;
                end
                4'hC: begin // JUMP (absolute imm8)
                    pc <= {8'd0, imm8};
                    mem_we <= 0;
                end
                4'hD: begin // HALT
                    halted <= 1;
                    mem_we <= 0;
                end
                default: begin
                    pc <= pc + 1;
                    mem_we <= 0;
                end
            endcase
        end
    end
endmodule

