/*
 Jun He
 mg240
  register file interface
*/
`ifndef ALU_IF_VH
`define ALU_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface alu_if;
  // import types
  import cpu_types_pkg::*;

  logic     negative, overflow, zero;
  aluop_t   aluop;
  word_t    porta, portb, porto;

  // alu file ports
  modport alu (
    input   porta, portb, aluop,
    output  negative, overflow, zero, porto
  );
  // alu file tb
  modport tb (
    input  negative, overflow, zero, porto,
    output   porta, portb, aluop
  );
endinterface

`endif //REGISTER_FILE_IF_VH
