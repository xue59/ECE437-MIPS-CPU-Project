// mapped needs this
`include "request_unit_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module request_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  request_unit_if ruif ();
  // test program
  test PROG ();
  // DUT
`ifndef MAPPED
  request_unit DUT(CLK, nRST, ruif);
`else
  request_unit DUT(
    .\ruif.dWEN (ruif.dWEN),
    .\ruif.dREN (ruif.dREN),
    .\ruif.dhit (ruif.dhit),
    .\ruif.ihit (ruif.ihit),
    .\ruif.dmemREN (ruif.dmemREN),
    .\ruif.dmemWEN (ruif.dmemWEN),
    .\ruif.PCEN (ruif.PCEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

program test;
parameter DELAY = 10;
integer i,j,k,l;
initial begin
	request_unit_tb.nRST = 0;
	request_unit_tb.ruif.dWEN = 0;
	request_unit_tb.ruif.dREN = 0;
	request_unit_tb.ruif.dhit = 0;
	request_unit_tb.ruif.ihit = 0;
	
	#(DELAY);
	#(DELAY);
	request_unit_tb.nRST = 1;
	#(DELAY);
	#(DELAY);
	for(i = 0; i < 2; i++) begin
	for(j = 0; j < 2; j++) begin
	for(k = 0; k < 2; k++) begin
	for(l = 0; l < 2; l++) begin
		request_unit_tb.ruif.dWEN = i;
		request_unit_tb.ruif.dREN = j;
		request_unit_tb.ruif.dhit = k;
		request_unit_tb.ruif.ihit = l;
		#(DELAY / 2);
	end
	end
	end
	end
$finish;
end

endprogram
