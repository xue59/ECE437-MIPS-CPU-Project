`ifndef MEM_WB_IF_VH
`define MEM_WB_IF_VH

// ram memory types
`include "cpu_types_pkg.vh"

interface mem_wb_if;

  // import types
  import cpu_types_pkg::*;

  // arbitration
  logic ihit, dhit;
  word_t next_pc_in;
  logic memToReg_in, RegWrite_in;
  logic [1:0] RegDest_in;
  logic jal_in, imemREN_in, lui_in;
  logic [4:0] rd_in, rt_in;
  logic [15:0] imm_in;
  logic halt_in;
  word_t port_out_in, dmemload_in;
  word_t instruction_in, instruction_out;

  word_t next_pc_out;
  logic memToReg_out, RegWrite_out;
  logic [1:0] RegDest_out;
  logic jal_out,  imemREN_out, lui_out;
  logic [4:0] rd_out, rt_out;
  logic [15:0] imm_out;
  logic halt_out, dhit_out;
  word_t port_out_out, dmemload_out;

  word_t next_pc_i;
  logic  memToReg_i;
  logic  RegWrite_i;
  logic  [1:0] RegDest_i;
  logic  jal_i;
  logic  imemREN_i;
  logic  lui_i;
  logic  [4:0] rd_i;
  logic  [4:0] rt_i;
  logic  [15:0] imm_i;
  logic  halt_i;
  word_t  port_out_i;
  word_t  dmemload_i;
  word_t  instruction_i;




  // icache ports to controller
  modport memwb (
    input  ihit, dhit, next_pc_in, jal_in, lui_in, memToReg_in, dmemload_in, imm_in, port_out_in,
            imemREN_in, halt_in, rd_in, rt_in, RegDest_in, RegWrite_in, instruction_in,
   
    output next_pc_out, jal_out, lui_out, memToReg_out, dmemload_out, imm_out, port_out_out,instruction_out,
            imemREN_out, halt_out, rd_out, rt_out, RegDest_out, RegWrite_out, dhit_out
  );

  modport tb (
    output  ihit, dhit, next_pc_in, jal_in, lui_in, memToReg_in, dmemload_in, imm_in, port_out_in,
            imemREN_in, halt_in, rd_in, rt_in, RegDest_in, RegWrite_in, instruction_in,
   
    input next_pc_out, jal_out, lui_out, memToReg_out, dmemload_out, imm_out, port_out_out,instruction_out,
            imemREN_out, halt_out, rd_out, rt_out, RegDest_out, RegWrite_out, dhit_out
  );


endinterface

`endif //CACHES_IF_VH