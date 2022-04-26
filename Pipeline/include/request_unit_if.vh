`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// ram memory types
`include "cpu_types_pkg.vh"

interface request_unit_if;

  // import types
  import cpu_types_pkg::*;

  // arbitration
  logic pcEna, dREN, dWEN, ihit, dhit, clkREN, clkWEN;


  // icache ports to controller
  modport reqUnit (
    input   dREN, dWEN, ihit, dhit,  
    output  pcEna, clkREN, clkWEN
  );

  modport reqUnit_tb (
    input  pcEna, clkREN, clkWEN,
    output dREN, dWEN, ihit, dhit
  );  


endinterface

`endif //CACHES_IF_VH
