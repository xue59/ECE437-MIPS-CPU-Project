/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"
// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 1;

//iwait, dwait, iload, dload, ramstore, ramaddr, ramWEN, ramREN
assign ccif.iwait = ~(ccif.iREN && ~ccif.dWEN && ~ccif.dREN && ccif.ramstate == ACCESS);
assign ccif.dwait = ~((ccif.dWEN || ccif.dREN) && ccif.ramstate == ACCESS);
assign ccif.iload = (ccif.iREN == 1)? ccif.ramload :'0;
assign ccif.dload = ccif.ramload;

assign ccif.ramstore = ccif.dstore;
assign ccif.ramWEN = ccif.dWEN;
assign ccif.ramaddr = (ccif.dREN == 1 || ccif.dWEN == 1)? ccif.daddr : ccif.iaddr;
assign ccif.ramREN = (ccif.dREN | ccif.iREN) & ~ccif.dWEN;

endmodule
