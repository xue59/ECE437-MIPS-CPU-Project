`include "request_unit_if.vh"
`include "cpu_types_pkg.vh"

`timescale 1 ns / 1 ns

module request_unit_tb;

  parameter PERIOD = 10;
  logic CLK = 0, nRST;

  always #(PERIOD/2) CLK++;

  // interface delcaration
  request_unit_if ruif ();
  // test program setup
  test PROG ();

`ifndef MAPPED
  request_unit DUT(CLK, nRST, ruif);
`else
  request_unit DUT(
    .\CLK (CLK),
    .\nRST (nRST),
    .\ruif.pcEna (ruif.pcEna),
    .\ruif.dREN (ruif.dREN),
    .\ruif.dWEN (ruif.dWEN),
    .\ruif.ihit (ruif.ihit),
    .\ruif.dhit (ruif.dhit),
    .\ruif.clkREN (ruif.clkREN),
    .\ruif.clkWEN (ruif.clkWEN)
  );
`endif

endmodule

program test;

import cpu_types_pkg::*;

initial begin

  //Initialize
  request_unit_tb.nRST = 0;
  request_unit_tb.nRST = 1;
  request_unit_tb.ruif.dWEN = 0;
  request_unit_tb.ruif.dREN = 0;
  request_unit_tb.ruif.ihit = 0;
  request_unit_tb.ruif.dhit = 0;

  #(10);
  	request_unit_tb.ruif.ihit = 1;
  #(10);
  	request_unit_tb.ruif.ihit = 0;
  	request_unit_tb.ruif.dWEN = 1;
  	request_unit_tb.ruif.dhit = 1;
  #(10);
   	request_unit_tb.ruif.dhit = 0;
  #(10);
  	request_unit_tb.ruif.dWEN = 0;
  	request_unit_tb.ruif.dREN = 1;
  	request_unit_tb.ruif.dhit = 1;
  #(10);
   	request_unit_tb.ruif.dhit = 0;
  #(10);
  	request_unit_tb.request_unit_tb.ruif.dWEN = 1;
  	request_unit_tb.ruif.dREN = 1;
  	request_unit_tb.ruif.dhit = 1;
  #(10);
  	request_unit_tb.ruif.dhit = 0;
  	request_unit_tb.ruif.dWEN = 1;
  	request_unit_tb.ruif.dREN = 1;
  #(10);
  	request_unit_tb.ruif.dhit = 1;
  #(10);
  #(10);
  #(10);




end
endprogram
