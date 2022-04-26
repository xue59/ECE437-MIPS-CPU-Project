`ifndef ID_EX_IF_VH
`define ID_EX_IF_VH

// ram memory types
`include "cpu_types_pkg.vh"

interface id_ex_if;

  // import types
  import cpu_types_pkg::*;

  // arbitration

  word_t rdat1_in, rdat2_in, next_pc_in, shamt_in;
  aluop_t ALUOp_in;
  logic ihit, flush;
  logic [1:0] aluSrc_in, RegDest_in, jumpSel_in;
  logic pcSrc_in, memToReg_in, RegWrite_in;
  logic jal_in, dREN_in, dWEN_in, imemREN_in, lui_in, bne_in, halt_in;
  logic [4:0] rd_in, rt_in, rs_in;
  logic [15:0] imm_in;
  word_t instruction_in, instruction_out;
  logic freeze;


  word_t rdat1_out, rdat2_out, next_pc_out, shamt_out;
  aluop_t ALUOp_out;
  logic [1:0] aluSrc_out, RegDest_out, jumpSel_out;
  logic pcSrc_out, memToReg_out, RegWrite_out;
  logic jal_out, dREN_out, dWEN_out, imemREN_out, lui_out, bne_out, halt_out;
  logic [4:0] rd_out, rt_out, rs_out;
  logic [15:0] imm_out;
  logic [25:0] imm26_in, imm26_out;

  // icache ports to controller
  modport idex (
    input  ihit, flush, rdat1_in, rdat2_in, next_pc_in, ALUOp_in, 
          aluSrc_in, pcSrc_in, memToReg_in, RegWrite_in, RegDest_in, 
          jumpSel_in, jal_in, dREN_in, dWEN_in, imemREN_in, lui_in, 
          bne_in, shamt_in, rd_in, rt_in, rs_in,  imm_in, halt_in, imm26_in, instruction_in, freeze,
    
    output  rdat1_out, rdat2_out, next_pc_out, ALUOp_out, aluSrc_out,
            pcSrc_out, memToReg_out, RegWrite_out, RegDest_out, jumpSel_out,
            jal_out, dREN_out, dWEN_out, imemREN_out, lui_out, bne_out, 
            shamt_out, rd_out, rt_out, rs_out, imm_out, halt_out, imm26_out, instruction_out
  );

  modport tb (
    output  ihit, flush, rdat1_in, rdat2_in, next_pc_in, ALUOp_in, aluSrc_in, 
            pcSrc_in, memToReg_in, RegWrite_in, RegDest_in, jumpSel_in,
            jal_in, dREN_in, dWEN_in, imemREN_in, lui_in, bne_in, shamt_in, 
            rd_in, rt_in, rs_in, imm_in, halt_in, imm26_in, instruction_in, freeze,
    
    input  rdat1_out, rdat2_out, next_pc_out, ALUOp_out, aluSrc_out, 
            pcSrc_out, memToReg_out, RegWrite_out, RegDest_out, jumpSel_out,
            jal_out, dREN_out, dWEN_out, imemREN_out, lui_out, bne_out, 
            shamt_out, rd_out, rt_out, rs_out, imm_out, halt_out, imm26_out, instruction_out
  );  


endinterface

`endif //CACHES_IF_VH