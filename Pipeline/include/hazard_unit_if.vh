`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH

// types
`include "cpu_types_pkg.vh"

interface hazard_unit_if;
  // import types
  import cpu_types_pkg::*;
  logic freeze, flush, pcSrc, bne, zero, dhit, regwrite_m;
  logic [1:0] jumpSel;
  word_t instruction;
  regbits_t rs_d, rt_d, rw_m;

  // system ports
  modport hu (
    input pcSrc, bne, zero, jumpSel,dhit,instruction, rs_d, rt_d, rw_m, regwrite_m,
    output freeze, flush
  );
  // testbench program
  modport tb (
    output pcSrc, bne, zero, jumpSel,dhit,instruction, rs_d, rt_d, rw_m, regwrite_m,
    input freeze, flush
  );
endinterface

`endif
