`ifndef EX_MEM_IF_VH
`define EX_MEM_IF_VH

// ram memory types
`include "cpu_types_pkg.vh"

interface ex_mem_if;

  // import types
  import cpu_types_pkg::*;

  // arbitration
  logic ihit, dhit;
  word_t rdat2_in, next_pc_in;
  logic memToReg_in, RegWrite_in;
  logic [1:0] RegDest_in;
  logic jal_in, dREN_in, dWEN_in, imemREN_in, lui_in;
  logic [4:0] rd_in, rt_in;
  logic [15:0] imm_in;
  logic halt_in;
  word_t port_out_in, instruction_in, instruction_out;
  logic freeze;

  word_t rdat2_out, next_pc_out;
  logic memToReg_out, RegWrite_out;
  logic [1:0] RegDest_out;
  logic jal_out, dREN_out, dWEN_out, imemREN_out, lui_out;
  logic [4:0] rd_out, rt_out;
  logic [15:0] imm_out;
  logic halt_out;
  word_t port_out_out;


  // icache ports to controller
  modport exmem (
    input  ihit, dhit, rdat2_in, next_pc_in, 
           memToReg_in, RegWrite_in, RegDest_in, 
           jal_in, dREN_in, dWEN_in, imemREN_in, lui_in, 
           rd_in, rt_in, imm_in, halt_in, port_out_in, instruction_in, freeze,
    output rdat2_out, next_pc_out, 
           memToReg_out, RegWrite_out, RegDest_out, 
           jal_out, dREN_out, dWEN_out, imemREN_out, lui_out, 
           rd_out, rt_out, imm_out, halt_out, port_out_out,  instruction_out
  );

  modport tb (
    output ihit, dhit, rdat2_in, next_pc_in, 
           memToReg_in, RegWrite_in, RegDest_in, 
           jal_in, dREN_in, dWEN_in, imemREN_in, lui_in, 
           rd_in, rt_in, imm_in, halt_in, port_out_in, instruction_in,freeze,
    
    input  rdat2_out, next_pc_out, 
           memToReg_out, RegWrite_out, RegDest_out, 
           jal_out, dREN_out, dWEN_out, imemREN_out, lui_out, 
           rd_out, rt_out, imm_out, halt_out, port_out_out, instruction_out
  );  


endinterface

`endif //CACHES_IF_VH