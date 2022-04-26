`include "caches_if.vh"
`include "datapath_cache_if.vh"
`include "cpu_types_pkg.vh"

`timescale 1 ns / 1 ns

module dcache_tb;

  parameter PERIOD = 10;
  logic CLK = 0, nRST;

  always #(PERIOD/2) CLK++;

  // interface delcaration
  caches_if cif ();
  datapath_cache_if dcif ();
  // test program setup
  test PROG ();

`ifndef MAPPED
  dcache DUT(CLK, nRST, dcif, cif);

`else
  dcache DUT(
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

  dcache_tb.nRST = 1;
  dcache_tb.dcif.imemaddr = '0;
  dcache_tb.dcif.halt = 0;
  dcache_tb.dcif.imemREN = 1;
  dcache_tb.dcif.dmemREN = 0;
  dcache_tb.dcif.dmemWEN = 0;
  dcache_tb.dcif.datomic = 0;
  dcache_tb.dcif.dmemstore = 0;
  dcache_tb.dcif.dmemaddr = 0;
  dcache_tb.dcif.imemaddr = 0;
  dcache_tb.cif.dwait = 1;
  dcache_tb.cif.dload = 0;
  dcache_tb.cif.ccwait = 0;
  dcache_tb.cif.ccinv = 0;
  dcache_tb.cif.ccsnoopaddr = 0;
  dcache_tb.cif.iwait = 1;
  dcache_tb.cif.iload = 0;

  dcache_tb.nRST = 0;
  #(5);
  dcache_tb.nRST = 1;
  
  //load from 0x50 --- MISS
  dcache_tb.dcif.dmemREN = 1;
  dcache_tb.dcif.dmemaddr = {30'h50, 2'b00};
  dcache_tb.cif.dwait = 0;
  dcache_tb.cif.dload = 32'hABCDEF00;
  #(20);
  dcache_tb.cif.dwait = 0;
  dcache_tb.cif.dload = 32'h12345678;
  #(20);
  //load from 0x51 --- HIT
  dcache_tb.dcif.dmemREN = 1;
  dcache_tb.dcif.dmemaddr = {30'h51, 2'b00};
  #(20);
  //store into 0x50 --- HIT, DIRTY
  dcache_tb.cif.dwait = 1;
  dcache_tb.dcif.dmemREN = 0;
  dcache_tb.dcif.dmemWEN = 1;
  dcache_tb.dcif.dmemaddr = {30'h50, 2'b00};
  dcache_tb.dcif.dmemstore = 32'h69696969;
  #(20);
  //load from 0x50 --- HIT
  dcache_tb.dcif.dmemREN = 1;
  dcache_tb.dcif.dmemWEN = 0;
  dcache_tb.dcif.dmemaddr = {30'h50, 2'b00};
  #(20);
  //load from 0x51 --- HIT
  dcache_tb.dcif.dmemREN = 1;
  dcache_tb.dcif.dmemWEN = 0;
  dcache_tb.dcif.dmemaddr = {30'h51, 2'b00};
  #(20);
   //store to 0x51 --- HIT, DIRTY 
  dcache_tb.dcif.dmemREN = 0;
  dcache_tb.dcif.dmemWEN = 1;
  dcache_tb.dcif.dmemaddr = {30'h51, 2'b00};
  dcache_tb.dcif.dmemstore = 32'h96969696;
  #(20);
  //load from 0x251 --- MISS
  dcache_tb.dcif.dmemREN = 1;
  dcache_tb.dcif.dmemWEN = 0;
  dcache_tb.dcif.dmemaddr = {30'h251, 2'b00};
  dcache_tb.cif.dwait = 0;
  dcache_tb.cif.dload = 32'hbad1bad1;
  #(20);
  dcache_tb.cif.dwait = 0;
  dcache_tb.cif.dload = 32'hdad1dad1;
  #(20);
  //save to 0x250 --- HIT, DIRTY
  dcache_tb.cif.dwait = 1;
  dcache_tb.dcif.dmemREN = 0;
  dcache_tb.dcif.dmemWEN = 1;
  dcache_tb.dcif.dmemaddr = {30'h250, 2'b00};
  dcache_tb.dcif.dmemstore = 32'hDADDADAD;
  #(10);
  //load from 0x3FFFF50 --- MISS
  dcache_tb.dcif.dmemREN = 1;
  dcache_tb.dcif.dmemWEN = 0;
  dcache_tb.dcif.dmemaddr = {30'h3FFFF50, 2'b00};
  dcache_tb.cif.dwait = 0;
  #(20);
  dcache_tb.cif.dwait = 1;
  #(20);
  dcache_tb.cif.dwait = 0;
  dcache_tb.cif.dload = 32'h55555555;
  #(20);
  dcache_tb.cif.dwait = 0;
  dcache_tb.cif.dload = 32'hdeadbed1;
  #(10);
  // HALT
  dcache_tb.cif.dwait = 1;
  dcache_tb.dcif.halt = 1;
  dcache_tb.cif.dwait = 0;

  //dcache_tb.dcif.dmemaddr = {30'h51, 2'b00};
  //#(5);
  //if (dcache_tb.dcif.dhit == 1) $display("Pass initial hit"); else $display("Fail initial hit");
  #(300);
end





endprogram