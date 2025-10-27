`include "parameters.v"

module Data_Memory(
 input clk,
 
 input [15:0]   mem_access_addr,
 

 input [15:0]   mem_write_data,
 input     mem_write_en,
 input mem_read,

 output [15:0]   mem_read_data
);

reg [`col - 1:0] memory [`row_d - 1:0];
wire [2:0] ram_addr=mem_access_addr[2:0];
initial
 begin
  $readmemb("./test/test.data", memory);
 end

always @(posedge clk) begin
  $display("time = %d", $time); 
  $display("\tmemory[0] = %b", memory[0]);   
  $display("\tmemory[1] = %b", memory[1]);
  $display("\tmemory[2] = %b", memory[2]);
  $display("\tmemory[3] = %b", memory[3]);
  $display("\tmemory[4] = %b", memory[4]);
  $display("\tmemory[5] = %b", memory[5]);
  $display("\tmemory[6] = %b", memory[6]);
  $display("\tmemory[7] = %b", memory[7]);
 end
 
 always @(posedge clk) begin
  if (mem_write_en)
   memory[ram_addr] <= mem_write_data;
 end
 assign mem_read_data = (mem_read==1'b1) ? memory[ram_addr]: 16'd0; 

endmodule
