`ifndef IF_ID_IF_VH
`define IF_ID_IF_VH

// ram memory types
`include "cpu_types_pkg.vh"

interface if_id_if;

  // import types
  import cpu_types_pkg::*;

  // arbitration
  word_t instruction_in, next_pc_in, instruction_out, next_pc_out;
  logic ihit, flush, freeze;


  // icache ports to controller
  modport ifid (
    input   instruction_in, next_pc_in, ihit, flush, freeze, 
    output  instruction_out, next_pc_out
  );

  modport tb (
    output   instruction_in, next_pc_in, ihit, flush, freeze, 
    input  instruction_out, next_pc_out
  );  


endinterface

`endif //CACHES_IF_VH