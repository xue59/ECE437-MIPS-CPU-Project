`ifndef PROGRAM_COUNTER_IF_VH
`define PROGRAM_COUNTER_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface program_counter_if;
  // import types
  import cpu_types_pkg::*;

  word_t npc, PC, new_pc;
  logic PCEN;

  // control_unit ports
  modport pc (
	input PCEN, new_pc,
	output PC, npc
  );
  // control_unit tb
  modport tb (
	input PC, npc,
	output PCEN, new_pc
  );
endinterface

`endif
