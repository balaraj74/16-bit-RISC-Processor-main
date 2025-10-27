`timescale 1ns / 1ps

module alu_control(
    input [1:0] ALUOp,
    input [3:0] Opcode,
    output reg [2:0] ALU_Cnt
);

always @(*) begin
    case(ALUOp)
        2'b00: ALU_Cnt = 3'b000; // Add for load/store
        2'b01: ALU_Cnt = 3'b001; // Subtract for branch
        2'b10: begin // R-type operations
            case(Opcode)
                4'b0010: ALU_Cnt = 3'b000; // ADD
                4'b0011: ALU_Cnt = 3'b001; // SUB
                4'b0100: ALU_Cnt = 3'b010; // NOT
                4'b0101: ALU_Cnt = 3'b011; // Shift left
                4'b0110: ALU_Cnt = 3'b100; // Shift right
                4'b0111: ALU_Cnt = 3'b101; // AND
                4'b1000: ALU_Cnt = 3'b110; // OR
                4'b1001: ALU_Cnt = 3'b111; // SLT (set less than)
                default: ALU_Cnt = 3'b000;
            endcase
        end
        default: ALU_Cnt = 3'b000;
    endcase
end

endmodule
