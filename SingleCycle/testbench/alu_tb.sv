/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

`include "alu_if.vh"
`timescale 1 ns / 1 ns
import cpu_types_pkg::*;

module alu_tb;
  aluop_t aluop;

  // interface
  alu_if math ();
  // test program
  test PROG ();
  // DUT
`ifndef MAPPED
  alu DUT(math);
`else
  alu DUT (
    .\math.aluop (math.aluop),
    .\math.porta (math.porta),
    .\math.portb (math.portb),
    .\math.porto (math.porto),
    .\math.negative (math.negative),
    .\math.zero (math.zero),
    .\math.overflow (math.overflow)
  );
`endif
endmodule

program test;
  integer i;
  initial begin
    // Test SLL
    alu_tb.math.aluop = ALU_SLL;
    alu_tb.math.porta = 32'h1;
    for (i = 0; i < 32; i++) begin
      alu_tb.math.portb = i;
      #(1ns)
      if(alu_tb.math.porto == alu_tb.math.porta << i) $display("PASSED: SLL Testcase %d",i);
      else $display("FAILED: SLL Testcase %d",i);
    end
    // Test SRL
    alu_tb.math.aluop = ALU_SRL;
    alu_tb.math.porta = '1;
    for (i = 0; i < 32; i++) begin
      alu_tb.math.portb = i;
      #(1ns)
      if(alu_tb.math.porto == alu_tb.math.porta >> i) $display("PASSED: SRL Testcase %d",i);
      else $display("FAILED: SRL Testcase %d",i);
    end
    // Test ADD
    alu_tb.math.aluop = ALU_ADD;
    for (i = 0; i < 32; i++) begin
      alu_tb.math.porta = $random;
      alu_tb.math.portb = $random;
      #(1ns)
      if(alu_tb.math.porto == $signed(alu_tb.math.porta) + $signed(alu_tb.math.portb)) 
        $display("PASSED: ADD Testcase %d",i);
      else $display("FAILED: ADD Testcase %d",i);
    end
    // Test SUB
    alu_tb.math.aluop = ALU_SUB;
    for (i = 0; i < 32; i++) begin
      alu_tb.math.porta = $random;
      alu_tb.math.portb = $random;
      #(1ns)
      if(alu_tb.math.porto == $signed(alu_tb.math.porta) - $signed(alu_tb.math.portb)) 
        $display("PASSED: SUB Testcase %d",i);
      else $display("FAILED: SUB Testcase %d",i);
    end
    // Test AND
    alu_tb.math.aluop = ALU_AND;
    for (i = 0; i < 32; i++) begin
      alu_tb.math.porta = $random;
      alu_tb.math.portb = $random;
      #(1ns)
      if(alu_tb.math.porto == alu_tb.math.porta & alu_tb.math.portb)
        $display("PASSED: AND Testcase %d",i);
      else $display("FAILED: AND Testcase %d",i);
    end
    // Test OR
    alu_tb.math.aluop = ALU_OR;
    for (i = 0; i < 32; i++) begin
      alu_tb.math.porta = $random;
      alu_tb.math.portb = $random;
      #(1ns)
      if(alu_tb.math.porto == alu_tb.math.porta | alu_tb.math.portb)
        $display("PASSED: OR Testcase %d",i);
      else $display("FAILED: OR Testcase %d",i);
    end
    // Test XOR
    alu_tb.math.aluop = ALU_XOR;
    for (i = 0; i < 32; i++) begin
      alu_tb.math.porta = $random;
      alu_tb.math.portb = $random;
      #(1ns)
      if(alu_tb.math.porto == alu_tb.math.porta ^ alu_tb.math.portb)
        $display("PASSED: XOR Testcase %d",i);
      else $display("FAILED: XOR Testcase %d",i);
    end
    // Test NOR
    alu_tb.math.aluop = ALU_NOR;
    for (i = 0; i < 32; i++) begin
      alu_tb.math.porta = $random;
      alu_tb.math.portb = $random;
      #(1ns)
      if(alu_tb.math.porto == ~(alu_tb.math.porta | alu_tb.math.portb))
        $display("PASSED: NOR Testcase %d",i);
      else $display("FAILED: NOR Testcase %d",i);
    end
    // Test SLT
    alu_tb.math.aluop = ALU_SLT;
    for (i = 0; i < 32; i++) begin
      alu_tb.math.porta = $random;
      alu_tb.math.portb = $random;
      #(1ns)
      if(alu_tb.math.porto == $signed(alu_tb.math.porta) < $signed(alu_tb.math.portb))
        $display("PASSED: SLT Testcase %d",i);
      else $display("FAILED: SLT Testcase %d",i);
    end
    // Test SLTU
    alu_tb.math.aluop = ALU_SLTU;
    for (i = 0; i < 32; i++) begin
      alu_tb.math.porta = $random;
      alu_tb.math.portb = $random;
      #(1ns)
      if(alu_tb.math.porto == alu_tb.math.porta < alu_tb.math.portb)
        $display("PASSED: SLTU Testcase %d",i);
      else $display("FAILED: SLTU Testcase %d",i);
    end
    // Test N Flag
    alu_tb.math.aluop = ALU_SUB;
    alu_tb.math.porta = 0;
    alu_tb.math.portb = 1;
    #(1ns)
    if(alu_tb.math.negative)
        $display("PASSED: N Testcase");
    else $display("FAILED: N Testcase");
    // Test Z Flag
    alu_tb.math.aluop = ALU_AND;
    alu_tb.math.porta = 32'b01010101_01010101_01010101_01010101;
    alu_tb.math.portb = 32'b10101010_10101010_10101010_10101010;
    #(1ns)
    if(alu_tb.math.zero)
        $display("PASSED: Z Testcase");
    else $display("FAILED: Z Testcase");
    // Test V Flag
    alu_tb.math.aluop = ALU_ADD;
    alu_tb.math.porta = 32'b01111111_11111111_11111111_11111111;
    alu_tb.math.portb = 1;
    #(1ns)
    if(alu_tb.math.overflow)
        $display("PASSED: V - ADD Testcase");
    else $display("FAILED: V - ADD Testcase");

    alu_tb.math.aluop = ALU_SUB;
    alu_tb.math.porta = 32'h4000_0000;
    alu_tb.math.portb = 32'h8000_0000;
    #(1ns)
    if(alu_tb.math.overflow)
        $display("PASSED: V - SUB Testcase");
    else $display("FAILED: V - SUB Testcase");
    $finish;
  end
endprogram
