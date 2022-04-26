`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface control_unit_if;
  // import types
  import cpu_types_pkg::*;

  word_t    instruction;
  logic PCSrc, MemtoReg, RegWEN, JAL, halt, dWEN, dREN, imemREN, LUI, BNE;
  logic [1:0] ALUSrc, RegDest, JumpSel;
  aluop_t aluop;
  regbits_t rs,rt,rd;
  logic [15:0] imm;
  word_t shamt;
  
  // control_unit ports
  modport cu (
    input   instruction,
    output  PCSrc, MemtoReg, RegWEN, JAL, halt, dWEN, dREN, imemREN, LUI, BNE,
    output  ALUSrc, RegDest, JumpSel, aluop, rs, rt, rd, imm, shamt
  );
  // control_unit tb
  modport tb (
    input  PCSrc, MemtoReg, RegWEN, JAL, halt, dWEN, dREN, imemREN, LUI, BNE,
    input  ALUSrc, RegDest, JumpSel, aluop, rs, rt, rd, imm, shamt,
    output instruction
  );
endinterface

`endif
