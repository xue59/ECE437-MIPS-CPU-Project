// mapped needs this
`include "alu_if.vh"
`include "cpu_types_pkg.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module alu_tb;

  // interface delcaration
  alu_if io ();
  // test program setup
  test PROG ( );

`ifndef MAPPED
  alu DUT(io);
`else
  alu DUT(
    .\io.port_a (io.port_a),
    .\io.port_b (io.port_b),
    .\io.aluop (io.aluop),
    .\io.overflow (io.overflow),
    .\io.negative (io.negative),
    .\io.zero (io.zero),
    .\io.port_out (io.port_out)
  );
`endif

endmodule

program test;

  import cpu_types_pkg::*;
  parameter PERIOD = 10;

  initial begin
  alu_tb.io.port_a = 32'h3; //shift left
  alu_tb.io.port_b = 32'h8;
  alu_tb.io.aluop = ALU_SLL;

  #(PERIOD)
  alu_tb.io.port_a = 32'h10; //shift right
  alu_tb.io.port_b = 32'h4;
  alu_tb.io.aluop = ALU_SRL;

  #(PERIOD)
  alu_tb.io.port_a = 32'h4; //add
  alu_tb.io.port_b = 32'h6;
  alu_tb.io.aluop = ALU_ADD;

  #(PERIOD)
  alu_tb.io.port_a = 32'h10; //subtract
  alu_tb.io.port_b = 32'h1;
  alu_tb.io.aluop = ALU_SUB;

  #(PERIOD)
  alu_tb.io.port_a = 32'hB; //and
  alu_tb.io.port_b = 32'h5;
  alu_tb.io.aluop = ALU_AND;

  #(PERIOD)
  alu_tb.io.port_a = 32'h10; //or
  alu_tb.io.port_b = 32'h4;
  alu_tb.io.aluop = ALU_OR;

  #(PERIOD)
  alu_tb.io.port_a = 32'hA; //xor
  alu_tb.io.port_b = 32'h5;
  alu_tb.io.aluop = ALU_XOR;

  #(PERIOD)
  alu_tb.io.port_a = 32'hA;
  alu_tb.io.port_b = 32'h4;
  alu_tb.io.aluop = ALU_NOR;

  #(PERIOD)
  alu_tb.io.port_a = 32'h10;
  alu_tb.io.port_b = 32'h4;
  alu_tb.io.aluop = ALU_SLT;

  #(PERIOD)
  alu_tb.io.port_a = 32'h4;
  alu_tb.io.port_b = 32'h10;
  alu_tb.io.aluop = ALU_SLTU;

  #(PERIOD)
  alu_tb.io.port_a = 32'b01111111111111111111111111111111;
  alu_tb.io.port_b = 5;
  alu_tb.io.aluop = ALU_ADD;

  #(PERIOD)

  alu_tb.io.port_a = 32'h7FFFFFFF;
  alu_tb.io.port_b = 32'hFFFFFFFF;
  alu_tb.io.aluop = ALU_SUB;

  #(PERIOD)
  #(PERIOD);

  end
endprogram
