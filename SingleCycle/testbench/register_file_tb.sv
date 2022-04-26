/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();
  // test program
  test PROG ();
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

program test;
	integer ind;
	initial begin
	//Input Signal Init.
	register_file_tb.rfif.WEN = 0;
	register_file_tb.rfif.wdat = 0;
	register_file_tb.rfif.wsel = '0;
	register_file_tb.rfif.rsel1 = '0;
	register_file_tb.rfif.rsel2 = '0;
	//Async. Reset
	register_file_tb.nRST = 0;
	#(register_file_tb.PERIOD);
	#(register_file_tb.PERIOD);
	#(register_file_tb.PERIOD);
	#(register_file_tb.PERIOD);
	register_file_tb.nRST = 1;
	#(register_file_tb.PERIOD);
	//Reg. #0
	register_file_tb.rfif.WEN = 1;
	register_file_tb.rfif.wdat = 32'b01001011_10100101_11110000_01101100;
	register_file_tb.rfif.wsel = '0;
	register_file_tb.rfif.rsel1 = '0;
	register_file_tb.rfif.rsel2 = '0;
	#(register_file_tb.PERIOD);
	if (register_file_tb.rfif.rdat1 == '0 && register_file_tb.rfif.rdat2 == '0) 
	     $display("PASSED: Reg0");
	else $error("FAILED: Reg0");
	//Normal Read & Write
	#(register_file_tb.PERIOD);
	register_file_tb.rfif.WEN = 0;
	for (ind = 1; ind < 32; ind++) begin
		#(register_file_tb.PERIOD);
		register_file_tb.rfif.WEN = 1;
		register_file_tb.rfif.wdat = $random;
		register_file_tb.rfif.wsel = register_file_tb.rfif.wsel + 1;
		register_file_tb.rfif.rsel1 = register_file_tb.rfif.rsel1 + 1;
		register_file_tb.rfif.rsel2 = register_file_tb.rfif.rsel2 + 1;
		#(register_file_tb.PERIOD);
		if (register_file_tb.rfif.rdat1 == register_file_tb.rfif.wdat && register_file_tb.rfif.rdat2 == register_file_tb.rfif.wdat) 
	     		$display("PASSED: Testcase %d", ind);
		else $error("FAILED: Testcase %d", ind);
	end
    $finish;
  end

endprogram
