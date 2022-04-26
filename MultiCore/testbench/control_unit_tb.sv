`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"

`timescale 1 ns / 1 ns

module control_unit_tb;

  parameter PERIOD = 10;
  logic CLK = 0, nRST;

  always #(PERIOD/2) CLK++;

  // interface delcaration
  control_unit_if cuif ();
  // test program setup
  test PROG ();

`ifndef MAPPED
  control_unit DUT(cuif);
`else
  control_unit DUT(
    .\cuif.instruction (cuif.instruction),
    .\cuif.shamt (cuif.shamt),
    .\cuif.ALUOp (cuif.ALUOp),
    .\cuif.insType (cuif.insType),
    .\cuif.RegDest (cuif.RegDest),
    .\cuif.jumpSel (cuif.jumpSel),
    .\cuif.pcSrc (cuif.pcSrc),
    .\cuif.memToReg (cuif.memToReg),
    .\cuif.RegWrite (cuif.RegWrite),
    .\cuif.jal (cuif.jal),
    .\cuif.dREN (cuif.dREN),
    .\cuif.dWEN (cuif.dWEN),
    .\cuif.imemREN (cuif.imemREN),
    .\cuif.lui (cuif.lui),
    .\cuif.bne (cuif.bne),
    .\cuif.halt (cuif.halt),
    .\cuif.rs (cuif.rs),
    .\cuif.rd (cuif.rd),
    .\cuif.rt (cuif.rt),
    .\cuif.imm (cuif.imm)
  );
`endif

endmodule

program test;

import cpu_types_pkg::*;

initial begin

  //Initialize
  #(5);
  control_unit_tb.nRST = 0;
  #(10);
  control_unit_tb.nRST = 1;
                                
  control_unit_tb.cuif.instruction = {RTYPE, 5'b00001, 5'b00010,5'b00011,5'b00000, ADD};
  #(5);
  if (control_unit_tb.cuif.ALUOp == ALU_ADD) begin
    if (control_unit_tb.cuif.RegDest == '0) begin
      $display("Passed ALU_ADD case!");
    end
  end
  #(5);
  control_unit_tb.cuif.instruction = {RTYPE, 5'b00001, 5'b00010,5'b00011,5'b00000, JR};
  #(5);
  if (control_unit_tb.cuif.RegWrite == 0) begin
    if (control_unit_tb.cuif.jumpSel == 2'b10) begin
      $display("Passed JR case!");
    end
  end
  #(5);
  control_unit_tb.cuif.instruction = {RTYPE, 5'b00001, 5'b00010,5'b00011,5'b00000, XOR};
  #(5);
  if (control_unit_tb.cuif.ALUOp == ALU_XOR) begin
    if (control_unit_tb.cuif.RegDest == '0) begin
      $display("Passed ALU_XOR case!");
    end
  end
  #(5);
  control_unit_tb.cuif.instruction = {ADDI, 5'b00001, 5'b00010,16'h0001};
  #(5);
  if (control_unit_tb.cuif.ALUOp == ALU_ADD) begin
    if (control_unit_tb.cuif.RegDest == 1) begin
      if(control_unit_tb.cuif.insType == 2'b10) begin
        $display("Passed ADDI case!");
      end
    end
  end
  #(5);


end
endprogram