`include "cache_control_if.vh"
`include "cpu_ram_if.vh"
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

`timescale 1 ns / 1 ns

module memory_control_tb;
  parameter PERIOD = 10;
  logic CLK = 0, nRST;
  caches_if cif0();
  caches_if cif1();
  // clock
  always #(PERIOD/2) CLK++;
  // interface
  cache_control_if #(.CPUS(1)) ccif (cif0, cif1);
  cpu_ram_if ramif();
//test program
test PROG ();
  // DUT
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
  ram JUN (CLK, nRST, ramif);
`else
 ram JUN(
	.\CLK (CLK),
	.\nRST (nRST),
	.\ramif.ramstore (ramif.ramstore),
	.\ramif.ramaddr (ramif.ramaddr),
	.\ramif.ramWEN (ramif.ramWEN),
	.\ramif.ramREN (ramif.ramREN),
	.\ramif.ramload (ramif.ramload),
	.\ramif.ramstate (ramif.ramstate)
  );
`endif
//Connect everything
  assign ramif.ramstore = ccif.ramstore;
  assign ramif.ramaddr = ccif.ramaddr;
  assign ramif.ramREN = ccif.ramREN;
  assign ramif.ramWEN = ccif.ramWEN;
  assign ccif.ramload = ramif.ramload;
  assign ccif.ramstate = ramif.ramstate;	
endmodule



program test;
integer ind;
integer pcc;
  initial begin
	//nRST

	memory_control_tb.nRST = 0;
	#(memory_control_tb.PERIOD)
	#(memory_control_tb.PERIOD)
	memory_control_tb.nRST = 1;
	#(memory_control_tb.PERIOD)
	#(memory_control_tb.PERIOD)

	//Instr test
	//init
	memory_control_tb.cif0.iaddr = '0;
	memory_control_tb.cif0.dstore = '0;
	memory_control_tb.cif0.daddr = '0;
	
	pcc = 0;
	memory_control_tb.cif0.iREN = 1;
	memory_control_tb.cif0.dREN = 0;
	memory_control_tb.cif0.dWEN = 0;
	for(ind = 1; ind <= 10; ind++) begin
		memory_control_tb.cif0.iaddr = memory_control_tb.cif0.iaddr + 4;
		#(memory_control_tb.PERIOD)
		if (memory_control_tb.ccif.ramload == memory_control_tb.cif0.iload) pcc++;
	end
	$display("PASSED CASE (iR): %d/10", pcc);

	//Data load
	//init
	memory_control_tb.cif0.daddr = 32'h000000F0;

	pcc = 0;
	memory_control_tb.cif0.iREN = 0;
	memory_control_tb.cif0.dREN = 1;
	memory_control_tb.cif0.dWEN = 0;
	for(ind = 1; ind <= 10; ind++) begin
		#(memory_control_tb.PERIOD)
		if (memory_control_tb.ccif.ramload == memory_control_tb.cif0.dload) pcc++;
		memory_control_tb.cif0.daddr = memory_control_tb.cif0.daddr + 4;
	end
	$display("PASSED CASE (dR): %d/10", pcc);

	//Data & Instr loading crash
	memory_control_tb.cif0.daddr = 32'h000000F0;

	pcc = 0;
	memory_control_tb.cif0.iREN = 1;
	memory_control_tb.cif0.dREN = 1;
	memory_control_tb.cif0.dWEN = 0;
	for(ind = 1; ind <= 10; ind++) begin
		#(memory_control_tb.PERIOD)
		if (memory_control_tb.ccif.ramload == memory_control_tb.cif0.dload) pcc++;
		memory_control_tb.cif0.daddr = memory_control_tb.cif0.daddr + 4;
	end
	$display("PASSED CASE (i/d crash): %d/10", pcc);
	//Data write
	memory_control_tb.cif0.iREN = 0;
	memory_control_tb.cif0.dREN = 0;
	memory_control_tb.cif0.dWEN = 1;
	pcc = 0;
	memory_control_tb.cif0.iaddr = '0;
	memory_control_tb.cif0.dstore = 32'hABCDEF00;
	memory_control_tb.cif0.daddr = 32'h00000080;

	for(ind = 1; ind <= 10; ind++) begin
		#(memory_control_tb.PERIOD)
		#(memory_control_tb.PERIOD)
		#(memory_control_tb.PERIOD)
		#(memory_control_tb.PERIOD)
		if (memory_control_tb.ccif.ramstore == memory_control_tb.cif0.dstore) pcc++;
		memory_control_tb.cif0.daddr = memory_control_tb.cif0.daddr + 4;
		memory_control_tb.cif0.dstore++;
	end
	$display("PASSED CASE (i/d crash): %d/10", pcc);
	//dump test
	dump_memory();
	$finish;


  end

 task automatic dump_memory();
    string filename = "memcpu.hex";
    int memfd;

    memory_control_tb.cif0.daddr = 0;
    memory_control_tb.cif0.dWEN = 0;
    memory_control_tb.cif0.dREN = 0;

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

      memory_control_tb.cif0.daddr = i << 2;
      memory_control_tb.cif0.dREN = 1;
      repeat (4) @(posedge memory_control_tb.CLK);
      if (memory_control_tb.cif0.dload === 0)
        continue;
      values = {8'h04,16'(i),8'h00,memory_control_tb.cif0.dload};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),memory_control_tb.cif0.dload,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for
    if (memfd)
    begin
      memory_control_tb.cif0.dREN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask
endprogram
