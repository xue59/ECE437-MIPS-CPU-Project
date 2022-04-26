`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH

// types
`include "cpu_types_pkg.vh"

interface hazard_unit_if;
  // import types
  import cpu_types_pkg::*;
  logic freeze, flush, pcSrc, bne, zero, dhit,ihit, isnew;
  logic [1:0] jumpSel, prediction;
  word_t instruction;

  // system ports
  modport hu (
    input pcSrc, bne, zero, jumpSel,dhit,ihit,instruction,isnew,prediction,
    output freeze, flush
  );
  // testbench program
  modport tb (
    output pcSrc, bne, zero, jumpSel,dhit,ihit,instruction,isnew,prediction,
    input freeze, flush
  );
endinterface

`endif
