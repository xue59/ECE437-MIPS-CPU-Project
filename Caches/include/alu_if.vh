/*
  Eric Villasenor
  evillase@gmail.com

  register file interface
*/
`ifndef ALU_IF_VH
`define ALU_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface alu_if;
  // import types
  import cpu_types_pkg::*;

  logic     zero, negative, overflow;
  aluop_t   aluop;
  word_t    port_a, port_b, port_out;

  // register file ports
  modport rf (
    input   port_a, port_b, aluop,
    output  port_out, zero, negative, overflow
  );
  // register file tb
  modport tb (
    input   port_out, zero, negative, overflow,
    output  port_a, port_b, aluop
  );
endinterface

`endif //ALU_IF_VH
