/*
Stephen Bulley
sbulley@purdue.edu

Register File
*/

`include "cpu_types_pkg.vh"
`include "alu_if.vh"

module alu
import cpu_types_pkg::*;
(
  alu_if.rf io

//input   port_a, port_b, aluop,
//output  port_out, zero, negative, overflow
);

always_comb
  begin
     if(io.aluop == ALU_SLL)begin
	io.port_out = io.port_a << io.port_b;
	io.overflow = 0;
     end else if(io.aluop == ALU_SRL)begin
	io.port_out = io.port_a >> io.port_b;
	io.overflow = 0;
     end else if(io.aluop == ALU_ADD)begin
	io.port_out = $signed(io.port_a) + $signed(io.port_b);	
	if ((~io.port_a[31] & ~io.port_b[31] & io.port_out[31]) | (io.port_a[31] & io.port_b[31] & ~io.port_out[31])) io.overflow = 1;
	else io.overflow = 0; 
     end else if(io.aluop == ALU_SUB)begin
	io.port_out = $signed(io.port_a) - $signed(io.port_b);
	if ((~io.port_a[31] & io.port_b[31] & io.port_out[31]) | (io.port_a[31] & ~io.port_b[31] & ~io.port_out[31])) io.overflow = 1;
	else io.overflow = 0;  
     end else if(io.aluop == ALU_AND)begin
	io.port_out = io.port_a & io.port_b;
	io.overflow = 0;
     end else if(io.aluop == ALU_OR)begin
	io.port_out = io.port_a | io.port_b;
	io.overflow = 0;
     end else if(io.aluop == ALU_XOR)begin
	io.port_out = io.port_a ^ io.port_b;
	io.overflow = 0;
     end else if(io.aluop == ALU_NOR)begin
	io.port_out = ~(io.port_a | io.port_b);
	io.overflow = 0;
     end else if(io.aluop == ALU_SLT)begin
	io.port_out = $signed(io.port_a) < $signed(io.port_b);
	io.overflow = 0;
     end else if(io.aluop == ALU_SLTU)begin
	io.port_out = io.port_a < io.port_b;
	io.overflow = 0;
     end else begin
	io.port_out = 0;
	io.overflow = 0;
     end     
  end

   assign io.zero = (io.port_out ? 0 : 1);
   assign io.negative = io.port_out[31];
   
   

   
endmodule

