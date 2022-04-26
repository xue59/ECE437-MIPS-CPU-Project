// mapped needs this

`include "cpu_types_pkg.vh"
`include "hazard_unit_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module hazard_unit_tb;

  parameter PERIOD = 10;

  // interface delcaration
  hazard_unit_if huif ();
// test program setup
  test PROG ();

`ifndef MAPPED
  hazard_unit DUT(huif);
`else
  hazard_unit DUT(
    .\huif.pcSrc (huif.pcSrc),
    .\huif.bne (huif.bne),
    .\huif.zero (huif.zero),
    .\huif.jumpSel (huif.jumpSel),
    .\huif.dhit (huif.dhit),
    .\huif.instruction (huif.instruction),
    .\huif.freeze (huif.freeze),
    .\huif.flush (huif.flush)
  );
`endif

endmodule

program test;

  import cpu_types_pkg::*;
  parameter PERIOD = 10;

  initial begin
  #(5)//NO JUMP OR BRANCH
  hazard_unit_tb.huif.jumpSel = 0;
  hazard_unit_tb.huif.instruction = '0;
  hazard_unit_tb.huif.dhit = 1;
  hazard_unit_tb.huif.bne = 0;
  hazard_unit_tb.huif.zero = 0;
  hazard_unit_tb.huif.pcSrc = 0;
  #(2)
  if(hazard_unit_tb.huif.flush == 0 && hazard_unit_tb.huif.freeze == 0) begin
    $display("Passed 1");
  end else begin
    $display("Failed 1");
  end
  #(5)//JUMP
  hazard_unit_tb.huif.jumpSel = 1;
  hazard_unit_tb.huif.instruction = '0;
  hazard_unit_tb.huif.dhit = 1;
  hazard_unit_tb.huif.bne = 0;
  hazard_unit_tb.huif.zero = 0;
  hazard_unit_tb.huif.pcSrc = 0;
  #(2)
  if(hazard_unit_tb.huif.flush == 1 && hazard_unit_tb.huif.freeze == 0) begin
    $display("Passed 2");
  end else begin
    $display("Failed 2");
  end
  #(5)//JUMP
  hazard_unit_tb.huif.jumpSel = 2;
  hazard_unit_tb.huif.instruction = '0;
  hazard_unit_tb.huif.dhit = 1;
  hazard_unit_tb.huif.bne = 0;
  hazard_unit_tb.huif.zero = 0;
  hazard_unit_tb.huif.pcSrc = 0;
  #(2)
  if(hazard_unit_tb.huif.flush == 1 && hazard_unit_tb.huif.freeze == 0) begin
    $display("Passed 3");
  end else begin
    $display("Failed 3");
  end
  #(5) //BRANCH NOT EQUAL
  hazard_unit_tb.huif.jumpSel = 3;
  hazard_unit_tb.huif.instruction = '0;
  hazard_unit_tb.huif.dhit = 1;
  hazard_unit_tb.huif.bne = 1;
  hazard_unit_tb.huif.zero = 0;
  hazard_unit_tb.huif.pcSrc = 1;
  #(2)
  if(hazard_unit_tb.huif.flush == 1 && hazard_unit_tb.huif.freeze == 0) begin
    $display("Passed 4");
  end else begin
    $display("Failed 4");
  end
  #(5)//BRANCH EQUAL
  hazard_unit_tb.huif.jumpSel = 3;
  hazard_unit_tb.huif.instruction = '0;
  hazard_unit_tb.huif.dhit = 1;
  hazard_unit_tb.huif.bne = 0;
  hazard_unit_tb.huif.zero = 1;
  hazard_unit_tb.huif.pcSrc = 1;
  #(2)
  if(hazard_unit_tb.huif.flush == 1 && hazard_unit_tb.huif.freeze == 0) begin
    $display("Passed 5");
  end else begin
    $display("Failed 5");
  end
  #(5)
  hazard_unit_tb.huif.jumpSel = 0;
  hazard_unit_tb.huif.instruction[31:26] = LW;
  hazard_unit_tb.huif.dhit = 0;
  hazard_unit_tb.huif.bne = 0;
  hazard_unit_tb.huif.zero = 0;
  hazard_unit_tb.huif.pcSrc = 0;
  #(2)
  if(hazard_unit_tb.huif.flush == 0 && hazard_unit_tb.huif.freeze == 1) begin
    $display("Passed 6");
  end else begin
    $display("Failed 6");
  end
  #(5)
  hazard_unit_tb.huif.jumpSel = 0;
  hazard_unit_tb.huif.instruction[31:26] = SW;
  hazard_unit_tb.huif.dhit = 0;
  hazard_unit_tb.huif.bne = 0;
  hazard_unit_tb.huif.zero = 0;
  hazard_unit_tb.huif.pcSrc = 0;
  #(2)
  if(hazard_unit_tb.huif.flush == 0 && hazard_unit_tb.huif.freeze == 1) begin
    $display("Passed 7");
  end else begin
    $display("Failed 7");
  end
  #(5)
  hazard_unit_tb.huif.jumpSel = 0;
  hazard_unit_tb.huif.instruction[31:26] = SW;
  hazard_unit_tb.huif.dhit = 1;
  hazard_unit_tb.huif.bne = 0;
  hazard_unit_tb.huif.zero = 0;
  hazard_unit_tb.huif.pcSrc = 0;
  #(2)
  if(hazard_unit_tb.huif.flush == 0 && hazard_unit_tb.huif.freeze == 0) begin
    $display("Passed 8");
  end else begin
    $display("Failed 8");
  end
  #(5)

  /*
  hazard_unit_tb.huif.
  hazard_unit_tb.huif.
  hazard_unit_tb.huif.
  hazard_unit_tb.huif.
  hazard_unit_tb.huif.
  */
  #(PERIOD)
  #(PERIOD);

  end
endprogram

