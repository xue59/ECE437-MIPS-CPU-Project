// mapped needs this

`include "cpu_types_pkg.vh"
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

typedef enum logic[3:0] {
  IDLE, ARB, IF, WB1, WB2, SNOOP, LD1, LD2, RAM_CACHE1, RAM_CACHE2
  } state_t;

module memory_control_tb;

  parameter PERIOD = 10;
  logic CLK = 0, nRST;

  state_t expectedState;

  always #(PERIOD/2) CLK++;

  // interface delcaration
  caches_if cif0();
  caches_if cif1();
  cache_control_if #(.CPUS(2)) ccif (cif0, cif1);
// test program setup
  test PROG (CLK,nRST,ccif);

`ifndef MAPPED
  memory_control DUT(CLK, nRST, ccif);
`else
  memory_control DUT(
    .\CLK (CLK),
    .\nRST (nRST),
    .\ccif.iREN (ccif.iREN),
    .\ccif.dREN (ccif.dREN),
    .\ccif.dWEN (ccif.dWEN),
    .\ccif.dstore (ccif.dstore),
    .\ccif.iaddr (ccif.iaddr),
    .\ccif.daddr (ccif.daddr),
    .\ccif.ramload (ccif.ramload),
    .\ccif.ramstate (ccif.ramstate),
    .\ccif.iwait (ccif.iwait),
    .\ccif.dwait (ccif.dwait),
    .\ccif.iload (ccif.iload),
    .\ccif.dload (ccif.dload),
    .\ccif.ramstore (ccif.ramstore),
    .\ccif.ramaddr (ccif.ramaddr),
    .\ccif.ramWEN (ccif.ramWEN),
    .\ccif.ramREN (ccif.ramREN)
  );
`endif

endmodule

program test (input logic CLK, output logic nRST, cache_control_if ccif);

import cpu_types_pkg::*;


initial begin

  //Initialize
  nRST = 0;
  memory_control_tb.expectedState = IDLE;

  ccif.ramload = 0;
  ccif.ramstate = ACCESS;

  cif0.dWEN = 0;
  cif0.dREN = 0;
  cif0.iREN = 0;
  cif0.dstore = '0;
  cif0.iaddr = 32'hDEADBEEF;
  cif0.daddr = '0;
  cif0.ccwrite = 0;
  cif0.cctrans = 0;

  cif1.dWEN = 0;
  cif1.dREN = 0;
  cif1.iREN = 0;
  cif1.dstore = '0;
  cif1.iaddr = '0;
  cif1.daddr = '0;
  cif1.ccwrite = 0;
  cif1.cctrans = 0;


  #(memory_control_tb.PERIOD/2);
  nRST = 1;
  $display("IF SECTION");
  #(5);
  cif0.iREN = 1;
  #(10);
  memory_control_tb.expectedState = IF;

  cif0.iREN = 0;
  ccif.ramstate = FREE; 
  cif0.cctrans = 0;
  #(10);
  memory_control_tb.expectedState = IDLE;
  #(10);

  $display("WRITE BACK SECTION");
  memory_control_tb.expectedState = IDLE;
  #(10);
  cif0.dWEN = 1;
  #(10);
  memory_control_tb.expectedState = WB1;
  cif0.dWEN = 0;
  ccif.ramstate = FREE; 
  #(10);
  memory_control_tb.expectedState = WB2;
  ccif.ramstate = FREE; 
  #(10);
  memory_control_tb.expectedState = IDLE;
  #(10);

  $display("RAM/CACHE SECTION");
  #(10);
  cif0.cctrans = 1;
  #(10);
  memory_control_tb.expectedState = ARB;
  cif0.dREN = 1;
  #(10);
  memory_control_tb.expectedState = SNOOP;
  cif1.ccwrite = 1;
  cif1.cctrans = 1;
  #(10);
  memory_control_tb.expectedState = RAM_CACHE1;
  cif0.dREN = 0;
  cif0.cctrans = 0;
  cif1.ccwrite = 0;
  cif0.cctrans = 0;
  ccif.ramstate = FREE; 
  #(10);
  memory_control_tb.expectedState = RAM_CACHE2;
  ccif.ramstate = FREE; 
  #(10);
  memory_control_tb.expectedState = IDLE;
  #(10);

  $display("LOAD SECTION SECTION");
  #(10);
  cif0.cctrans = 1;
  #(10);
  memory_control_tb.expectedState = ARB;
  cif0.dREN = 1;
  #(10);
  memory_control_tb.expectedState = SNOOP;
  cif1.ccwrite = 0;
  cif1.cctrans = 0;
  #(10);
  memory_control_tb.expectedState = LD1;
  cif0.dREN = 0;
  cif0.cctrans = 0;
  ccif.ramstate = FREE; 
  #(10);
  memory_control_tb.expectedState = LD2;
  ccif.ramstate = FREE; 
  #(10);
  memory_control_tb.expectedState = IDLE;
  #(10);


  $display("LOAD SECTION SECTION");
  #(10);
  cif0.cctrans = 1;
  cif0.ccwrite = 1;
  #(10);
  memory_control_tb.expectedState = ARB;
  cif0.dREN = 1;
  #(10);
  memory_control_tb.expectedState = SNOOP;
  cif1.ccwrite = 0;
  cif1.cctrans = 0;
  #(10);
  memory_control_tb.expectedState = LD1;
  cif0.dREN = 0;
  cif0.cctrans = 0;
  ccif.ramstate = FREE; 
  #(10);
  memory_control_tb.expectedState = LD2;
  ccif.ramstate = FREE; 
  #(10);
  memory_control_tb.expectedState = IDLE;
  #(10);



end
endprogram