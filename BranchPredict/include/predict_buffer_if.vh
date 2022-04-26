`ifndef PREDICT_BUFFER_IF_VH
`define PREDICT_BUFFER_IF_VH

// ram memory types
`include "cpu_types_pkg.vh"

interface predict_buffer_if;

  // import types
  import cpu_types_pkg::*;
  word_t ProgramCounter, npc_x, npc_f;
  word_t BranchAddr, BranchAddr_in;
  logic hit, isbranch;

  modport buff (
	input npc_x, npc_f, BranchAddr_in,isbranch,
	output BranchAddr, hit
  );

  modport tb (
	input BranchAddr, hit,
	output npc_x, npc_f, BranchAddr_in,isbranch
  );


endinterface

`endif //PREDICTI_BUFFER_IF_VH
