`include "caches_if.vh"
`include "datapath_cache_if.vh"
`include "cpu_types_pkg.vh"

`timescale 1 ns / 1 ns

module icache_tb;

  parameter PERIOD = 10;
  logic CLK = 0, nRST;

  always #(PERIOD/2) CLK++;

  // interface delcaration
  caches_if cif ();
  datapath_cache_if dcif ();
  // test program setup
  test PROG ();

`ifndef MAPPED
  icache DUT(CLK, nRST, dcif, cif);

`else
  icache DUT(
    .\CLK(CLK),
    .\nRST(nRST),
    .\dcif.halt(dcif.halt),
    .\dcif.imemREN(dcif.imemREN),
    .\dcif.dmemREN(dcif.dmemREN),
    .\dcif.dmemWEN(dcif.dmemWEN),
    .\dcif.datomic(dcif.datomic),
    .\dcif.dmemstore(dcif.dmemstore),
    .\dcif.dmemaddr(dcif.dmemaddr),
    .\dcif.imemaddr(dcif.imemaddr),
    .\cif.dwait(cif.dwait),
    .\cif.dload(cif.dload),
    .\cif.ccwait(cif.ccwait),
    .\cif.ccinv(cif.ccinv),
    .\cif.ccsnoopaddr(cif.ccsnoopaddr),
    .\cif.iwait(cif.iwait),
    .\cif.iload(cif.iload)
  );
`endif

endmodule

program test;

import cpu_types_pkg::*;

initial begin

  int testNum;

  icache_tb.nRST = 1;
  icache_tb.dcif.imemaddr = '0;
  icache_tb.dcif.halt = 0;
  icache_tb.dcif.imemREN = 1;
  icache_tb.dcif.dmemREN = 0;
  icache_tb.dcif.dmemWEN = 0;
  icache_tb.dcif.datomic = 0;
  icache_tb.dcif.dmemstore = 0;
  icache_tb.dcif.dmemaddr = 0;
  icache_tb.dcif.imemaddr = 0;
  icache_tb.cif.dwait = 0;
  icache_tb.cif.dload = 0;
  icache_tb.cif.ccwait = 0;
  icache_tb.cif.ccinv = 0;
  icache_tb.cif.ccsnoopaddr = 0;
  icache_tb.cif.iwait = 1;
  icache_tb.cif.iload = 0;

  icache_tb.nRST = 0;
  #(5);
  icache_tb.nRST = 1;
  //Write to index 1, with tag all 1's
  icache_tb.dcif.imemaddr = {26'b11111111111111111111111111 ,6'b000100};
  #(5);
  icache_tb.cif.iload = 32'hABCDEF00;
  icache_tb.cif.iwait = 0;
  #(15);
  icache_tb.cif.iwait = 1;
  //Write to index 2, with tag all 1's
  icache_tb.dcif.imemaddr = {26'b11111111111111111111111111 ,6'b001000};
  #(5);
  icache_tb.cif.iload = 32'h12345678;
  icache_tb.cif.iwait = 0;
  #(15);
  icache_tb.cif.iwait = 1;
  //Write to index 3, with tag all 1's
  icache_tb.dcif.imemaddr = {26'b11111111111111111111111111 ,6'b001100};
  icache_tb.cif.iload = 32'h10101010;
  icache_tb.cif.iwait = 0;
  icache_tb.dcif.imemREN = 1;
  #(10);

  //fetch value from register 1 - TAG MATCH
  
  icache_tb.dcif.imemaddr = {26'b11111111111111111111111111 ,6'b000100};
  icache_tb.cif.iload = 32'h00000000;
  icache_tb.cif.iwait = 1;
  icache_tb.dcif.imemREN = 1;
  #(5);
  testNum = 1;
  checkCorrect(testNum, 1, 0, 32'hABCDEF00, 0);
  
  //fetch value from register 2 with TAG MISMATCH
 
  icache_tb.dcif.imemaddr = {26'b11111111111111111111111110 ,6'b001000};
  icache_tb.cif.iload = 32'hDEADBAAD;
  icache_tb.cif.iwait = 0;
  icache_tb.dcif.imemREN = 1;
  #(5);
   testNum = 2;
  checkCorrect(testNum, 1, 1, 32'hDEADBAAD, {26'b11111111111111111111111110 ,6'b001000});
  
  //IMEMREN = 0 SO NO READ EVEN WITH TAG MATCH
  
  icache_tb.dcif.imemaddr = {26'b11111111111111111111111111 ,6'b000100};
  icache_tb.cif.iload = 32'h00000000;
  icache_tb.cif.iwait = 1;
  icache_tb.dcif.imemREN = 0;
  #(5);
  testNum = 3;
  checkCorrect(testNum, 0, 0, 0, 0);


  #(30);
end  

  task checkCorrect;
    input logic [4:0] testcase;
    input logic ihit, iREN;
    input logic [31:0] imemload, iaddr; 
    logic correct;
    begin
      correct = 0;
      if (dcif.ihit == ihit) begin
        if (dcif.imemload == imemload) begin
          if (cif.iREN == iREN) begin
            if (cif.iaddr == iaddr) begin
	      $display("Passed %d", testcase);
	      correct = 1;
            end
          end
        end
      end 
    end
    if (correct == 0) $display("Failed %d", testcase);
    #(5);
  endtask





endprogram
