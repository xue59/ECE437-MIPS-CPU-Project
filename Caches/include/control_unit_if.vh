`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// ram memory types
`include "cpu_types_pkg.vh"

interface control_unit_if;

  // import types
  import cpu_types_pkg::*;

  // arbitration
  word_t instruction, shamt;
  logic [25:0] imm26;
  aluop_t ALUOp;
  logic [1:0] aluSrc, RegDest, jumpSel;
  logic pcSrc, memToReg, RegWrite;
  logic jal, dREN, dWEN, imemREN, lui, bne, halt;
  logic [4:0] rs, rd, rt;
  logic [15:0] imm;

  //instruction is the 32 bit input
  //shamt: the shift amount
  //ALUOp: the operation to send to the ALU
  //aluSrc: 00 = rt, 01 = shamt, 10 = SignExtImm, 11 = ZeroExtImm
  //RegDest: 00 = rd, 01 = rt, 10 = reg[31]
  //jumpSel: 00 = nPC, 01 = jumpAddr, 10 = R[rs], 11 = branchAddr
  //pcSrc: 0 = regular pc update, 1 = jump address 
  
  // icache ports to controller
  modport conUnit (
    input   instruction,  
    output  ALUOp, aluSrc, pcSrc, memToReg, RegWrite, RegDest, jumpSel,
    jal, dREN, dWEN, imemREN, lui, bne, shamt, rs, rd, rt, imm, halt, imm26
  );

  modport conUnit_tb (
    input  ALUOp, aluSrc, pcSrc, memToReg, RegWrite, RegDest, jumpSel,
    jal, dREN, dWEN, imemREN, lui, bne, shamt, rs, rd, rt, imm, halt,imm26,
    output instruction
  );  


endinterface

`endif //CACHES_IF_VH