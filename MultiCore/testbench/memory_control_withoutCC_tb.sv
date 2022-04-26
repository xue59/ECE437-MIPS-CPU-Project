// mapped needs this

`include "cpu_types_pkg.vh"
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module memory_control_tb;

  parameter PERIOD = 10;
  logic CLK = 0, nRST;

  always #(PERIOD/2) CLK++;

  // interface delcaration
  caches_if cif0();
  caches_if cif1();
  cache_control_if #(.CPUS(1)) ccif (cif0, cif1);
  cpu_ram_if ramif ();
// test program setup
  test PROG (CLK,nRST,ccif,ramif);

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

`ifndef MAPPED
  ram rDUT(CLK, nRST, ramif);
`else
  ram rDUT(
    .\CLK (CLK),
    .\nRST (nRST),
    .\ramif.ramaddr (ramif.ramaddr),
    .\ramif.ramstore (ramif.ramstore),
    .\ramif.ramREN (ramif.ramREN),
    .\ramif.ramWEN (ramif.ramWEN),
    .\ramif.ramstate (ramif.ramstate),
    .\ramif.ramload (ramif.ramload)
  );

`endif

endmodule

program test (input logic CLK, output logic nRST, cache_control_if.cc ccif_tb, cpu_ram_if.ram ramif_tb);

import cpu_types_pkg::*;


  //Ram inputs
  assign ramif_tb.ramaddr = ccif_tb.ramaddr;
  assign ramif_tb.ramstore = ccif_tb.ramstore;
  assign ramif_tb.ramREN = ccif_tb.ramREN;
  assign ramif_tb.ramWEN = ccif_tb.ramWEN;
  //Ram outputs
  assign ccif_tb.ramstate = ramif_tb.ramstate;
  assign ccif_tb.ramload = ramif_tb.ramload;

task automatic dump_memory();
    string filename = "memcpu.hex";
    int memfd;

    //cif0.tbCTRL = 1;
    cif0.daddr = 0;
    cif0.dWEN = 0;
    cif0.dREN = 0;

    memfd = $fopen(filename,"w");
    if (memfd)
      $display("Starting memory dump.");
    else
      begin $display("Failed to open %s.",filename); $finish; end

    for (int unsigned i = 0; memfd && i < 16384; i++)
    begin
      int chksum = 0;
      bit [7:0][7:0] values;
      string ihex;

      cif0.daddr = i << 2;
      cif0.dREN = 1;
      repeat (4) @(posedge CLK);
      if (cif0.dload === 0)
        continue;
      values = {8'h04,16'(i),8'h00,cif0.dload};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),cif0.dload,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for
    if (memfd)
    begin
      //cif0.tbCTRL = 0;
      cif0.dREN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask




initial begin

  //Initialize
  nRST = 0;
  cif0.dWEN = 0;
  cif0.dREN = 0;
  cif0.iREN = 0;
  cif0.dstore = '0;
  cif0.iaddr = '0;
  cif0.daddr = '0;

  #(memory_control_tb.PERIOD/2);
  nRST = 1;
  $display("DATA WRITE/READ SECTION");
  for (int i = 0 ; i < 16 ; i++) begin

    cif0.dstore = $urandom;
    #(memory_control_tb.PERIOD*4);
    cif0.dWEN = 1;
    #(memory_control_tb.PERIOD*4);
    cif0.dWEN = 0;
    #(memory_control_tb.PERIOD*4);
    cif0.dREN = 1;
    #(memory_control_tb.PERIOD*4);

    if(cif0.dload == cif0.dstore) begin
      $display("Passed: dstore value:%h   dload value: %h", cif0.dstore, cif0.dload);
    end else begin
      $display("Failed: dstore value:%h   dload value: %h", cif0.dstore, cif0.dload);
    end

    cif0.dREN = 0;
    cif0.daddr = cif0.daddr + 4;
  end
  nRST = 0;
  #(memory_control_tb.PERIOD*4);
  nRST = 1;
  #(memory_control_tb.PERIOD*4);

  cif0.dWEN = 0;
  cif0.dREN = 0;
  cif0.iREN = 0;
  cif0.dstore = '0;
  cif0.iaddr = '0;
  cif0.daddr = '0;


  $display("INSTRUCTION WRITE/READ SECTION");
  for (int i = 0 ; i < 16 ; i++) begin

    cif0.dstore = $urandom;
    #(memory_control_tb.PERIOD*4);
    cif0.dWEN = 1;
    #(memory_control_tb.PERIOD*4);
    cif0.dWEN = 0;
    #(memory_control_tb.PERIOD*4);
    cif0.iREN = 1;
    #(memory_control_tb.PERIOD*4);

    if(cif0.iload == cif0.dstore) begin
      $display("Passed: dstore value:%h   iload value: %h", cif0.dstore, cif0.iload);
    end else begin
      $display("Failed: dstore value:%h   iload value: %h", cif0.dstore, cif0.iload);
    end

    cif0.iREN = 0;
    cif0.iaddr = cif0.iaddr + 4;
    cif0.daddr = cif0.iaddr;
  end

  nRST = 0;
  #(memory_control_tb.PERIOD*4);
  nRST = 1;
  #(memory_control_tb.PERIOD*4);

  cif0.dWEN = 0;
  cif0.dREN = 0;
  cif0.iREN = 0;
  cif0.dstore = '0;
  cif0.iaddr = '0;
  cif0.daddr = '0;

  $display("ENABLE SIGNAL TESTS");
  #(memory_control_tb.PERIOD*4);
  #(memory_control_tb.PERIOD*4);
  #(memory_control_tb.PERIOD*4);

  cif0.dREN = 0;
  cif0.dWEN = 0;
  cif0.iREN = 0;

  #(memory_control_tb.PERIOD*4);
  if(cif0.iwait == 1 && cif0.dwait == 1) begin
    $display("Passed all 0's");
  end else begin
    $display("Failed all 0's");
  end

  #(memory_control_tb.PERIOD*4);

  cif0.dREN = 0;
  cif0.dWEN = 1;
  cif0.iREN = 0;

  #(memory_control_tb.PERIOD*4);
  if(cif0.iwait == 1 && cif0.dwait == 0) begin
    $display("Passed dwait = 0");
  end else begin
    $display("Failed dwait = 0");
  end

  #(memory_control_tb.PERIOD*4);

  cif0.dREN = 0;
  cif0.dWEN = 0;
  cif0.iREN = 1;

  #(memory_control_tb.PERIOD*4);
  if(cif0.iwait == 0 && cif0.dwait == 1) begin
    $display("Passed iwait = 0");
  end else begin
    $display("Failed iwait = 0");
  end

  #(memory_control_tb.PERIOD*4);

  cif0.dREN = 1;
  cif0.dWEN = 1;
  cif0.iREN = 1;

  #(memory_control_tb.PERIOD*4);
  if(cif0.iwait == 1 && cif0.dwait == 0) begin
    $display("Passed all 1's");
  end else begin
    $display("Failed all 1's");
  end
  #(memory_control_tb.PERIOD*4);
  #(memory_control_tb.PERIOD*4);


  dump_memory();

  #(memory_control_tb.PERIOD*4);



end
endprogram