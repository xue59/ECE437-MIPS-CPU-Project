/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
`include "control_unit_if.vh"
`include "register_file_if.vh"
`include "alu_if.vh"
`include "if_id_if.vh"
`include "id_ex_if.vh"
`include "ex_mem_if.vh"
`include "mem_wb_if.vh"
`include "forward_unit_if.vh"
`include "hazard_unit_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;

  // pc init
  parameter PC_INIT = 0;

  //interfaces
  control_unit_if cuif();
  register_file_if rfif();
  alu_if aluif();
  if_id_if iiif();
  id_ex_if ieif();
  ex_mem_if emif();
  mem_wb_if mwif();
  forward_unit_if fuif();
  hazard_unit_if huif();
  
  //DUT
  control_unit CTRLU(cuif);
  register_file REGF(CLK, nRST, rfif);
  alu ALU(aluif);
  if_id IFID(CLK,nRST,iiif);
  id_ex IDEX(CLK,nRST,ieif);
  ex_mem EXMEM(CLK,nRST,emif);
  mem_wb MEMWB(CLK,nRST,mwif);
  forward_unit FWD(fuif);
  hazard_unit HZD(huif);

  word_t PC, new_pc, next_pc, BranchAddr, JumpAddr;
  logic [13:0] Signed;
  word_t rdat1, rdat2;
  opcode_t opF; assign opF = opcode_t'(iiif.instruction_in[31:26]);
  funct_t funcF; assign funcF = funct_t'(iiif.instruction_in[5:0]);

  opcode_t opD; assign opD = opcode_t'(ieif.instruction_in[31:26]);
  funct_t funcD; assign funcD = funct_t'(ieif.instruction_in[5:0]);

  opcode_t opX; assign opX = opcode_t'(emif.instruction_in[31:26]);
  funct_t funcX; assign funcX = funct_t'(emif.instruction_in[5:0]);

  opcode_t opM; assign opM = opcode_t'(mwif.instruction_in[31:26]);
  funct_t funcM; assign funcM = funct_t'(mwif.instruction_in[5:0]);

  opcode_t opW; assign opW = opcode_t'(mwif.instruction_out[31:26]);
  funct_t funcW; assign funcW = funct_t'(mwif.instruction_out[5:0]);
  //Program Counter
  always_ff @(posedge CLK, negedge nRST) begin
    if(nRST == 0) PC <= '0;
    else if(dpif.ihit && ~huif.freeze) PC <= new_pc; 
    //else if (dpif.ihit && ~huif.freeze)
  end
  assign next_pc = PC + 4;

  //setup IFID
  assign iiif.instruction_in = dpif.imemload;
  assign iiif.next_pc_in = next_pc;
  assign iiif.ihit = dpif.ihit;
  assign iiif.flush = huif.flush;
  //setup IDEX
  assign ieif.rdat1_in = rfif.rdat1;
  assign ieif.rdat2_in = rfif.rdat2;
  assign ieif.next_pc_in = iiif.next_pc_out;
  assign ieif.ALUOp_in = cuif.ALUOp;
  assign ieif.shamt_in = cuif.shamt;
  assign ieif.ihit = dpif.ihit;
  assign ieif.flush = huif.flush;
  assign ieif.aluSrc_in = cuif.aluSrc;
  assign ieif.RegDest_in = cuif.RegDest;
  assign ieif.jumpSel_in = cuif.jumpSel;
  assign ieif.pcSrc_in = cuif.pcSrc;
  assign ieif.memToReg_in = cuif.memToReg;
  assign ieif.RegWrite_in = cuif.RegWrite;
  assign ieif.jal_in = cuif.jal;
  assign ieif.dREN_in = cuif.dREN;
  assign ieif.dWEN_in = cuif.dWEN;
  assign ieif.imemREN_in = cuif.imemREN;
  assign ieif.lui_in = cuif.lui;
  assign ieif.bne_in = cuif.bne;
  assign ieif.halt_in = cuif.halt;
  assign ieif.rd_in = cuif.rd;
  assign ieif.rt_in = cuif.rt;
  assign ieif.rs_in = cuif.rs;
  assign ieif.imm_in = cuif.imm;
  assign ieif.imm26_in = cuif.imm26;
  //setup EXMEM
  assign emif.ihit = dpif.ihit;
  assign emif.dhit = dpif.dhit;
  assign emif.rdat2_in = rdat2;
  assign emif.next_pc_in = ieif.next_pc_out;
  assign emif.memToReg_in = ieif.memToReg_out;
  assign emif.RegWrite_in = ieif.RegWrite_out;
  assign emif.RegDest_in = ieif.RegDest_out;
  assign emif.jal_in = ieif.jal_out;
  assign emif.dREN_in = ieif.dREN_out;
  assign emif.dWEN_in = ieif.dWEN_out;
  assign emif.imemREN_in = ieif.imemREN_out;
  assign emif.lui_in = ieif.lui_out;
  assign emif.rd_in = ieif.rd_out;
  assign emif.rt_in = ieif.rt_out;
  assign emif.imm_in = ieif.imm_out;
  assign emif.halt_in = ieif.halt_out;
  assign emif.port_out_in = aluif.port_out;
  //setup MEMWB
  assign mwif.ihit = dpif.ihit;
  assign mwif.dhit = dpif.dhit;
  assign mwif.next_pc_in = emif.next_pc_out;
  assign mwif.memToReg_in = emif.memToReg_out;
  assign mwif.RegWrite_in = emif.RegWrite_out;
  assign mwif.RegDest_in = emif.RegDest_out;
  assign mwif.jal_in = emif.jal_out;
  assign mwif.imemREN_in = emif.imemREN_out;
  assign mwif.lui_in = emif.lui_out;
  assign mwif.rd_in = emif.rd_out;
  assign mwif.rt_in = emif.rt_out;
  assign mwif.imm_in = emif.imm_out;
  assign mwif.halt_in = emif.halt_out;
  assign mwif.port_out_in = emif.port_out_out;
  assign mwif.dmemload_in = dpif.dmemload;
  assign mwif.instruction_in = emif.instruction_out;

  //setup FORWARD
  assign fuif.rs = ieif.rs_out;
  assign fuif.rt = ieif.rt_out;
  assign fuif.regwrite_mem = emif.RegWrite_out;
  assign fuif.regwrite_wb = mwif.RegWrite_out;
  always_comb begin
    if(mwif.RegDest_in == 0) fuif.rw_mem = mwif.rd_in;//....
    else if (mwif.RegDest_in == 1) fuif.rw_mem = mwif.rt_in;//..
    else fuif.rw_mem = 5'b11111;
  end
  always_comb begin
    if(mwif.RegDest_out == 0) fuif.rw_wb = mwif.rd_out;
    else if (mwif.RegDest_out == 1) fuif.rw_wb = mwif.rt_out;
    else fuif.rw_wb = 5'b11111;
  end
  always_comb begin
    if(mwif.lui_in) //..
      fuif.mem_data = {mwif.imm_in, 16'b0};//..
     else if(mwif.memToReg_in) //.. 
      fuif.mem_data = mwif.dmemload_in; //..
     else if(mwif.jal_in) //..
      fuif.mem_data = mwif.next_pc_in;//..
     else 
      fuif.mem_data = mwif.port_out_in;//..
  end
  assign fuif.wb_data = rfif.wdat;
  
  //setup HAZARD
  assign huif.pcSrc = ieif.pcSrc_out;
  assign huif.bne = ieif.bne_out;
  assign huif.zero = aluif.zero;
  assign huif.dhit = dpif.dhit;
  assign huif.instruction = ieif.instruction_out;
  assign huif.jumpSel = ieif.jumpSel_out;
  assign huif.rs_d = cuif.rs;
  assign huif.rt_d = cuif.rt;
  assign huif.rw_m = fuif.rw_mem;
  assign huif.regwrite_m = emif.RegWrite_out;

  //Freeze
  assign iiif.freeze = huif.freeze;
  //assign emif.freeze = huif.freeze;
  assign ieif.freeze = huif.freeze;
  
  //instr
  assign ieif.instruction_in = iiif.instruction_out;
  assign emif.instruction_in = ieif.instruction_out;

  //setup PC
  //assign flush = ieif.pcSrc_out & (ieif.bne_out? ~aluif.zero: aluif.zero);
  assign Signed = ieif.imm_out[15]? 14'b1111_1111_1111_11:14'b0;
  assign BranchAddr = huif.flush? (ieif.next_pc_out + {Signed,ieif.imm_out,2'b00}):next_pc;
  assign JumpAddr = {ieif.next_pc_out[31:28], ieif.imm26_out, 2'b00};
  always_comb begin
	   if (ieif.jumpSel_out == 0) new_pc = next_pc;
 	   else if (ieif.jumpSel_out == 1) new_pc = JumpAddr;
	   else if (ieif.jumpSel_out == 2) new_pc = ieif.rdat1_out;
	   else new_pc = BranchAddr;
  end
  //setup CTRL UNIT
  assign cuif.instruction = iiif.instruction_out;
  //setup REG FILE
  assign rfif.WEN = mwif.RegWrite_out;
  assign rfif.rsel1 = cuif.rs;
  assign rfif.rsel2 = cuif.rt;
  always_comb begin
	   if(mwif.lui_out) 
      rfif.wdat = {mwif.imm_out, 16'b0};
     else if(mwif.jal_out) 
      rfif.wdat = mwif.next_pc_out;
	   else if(mwif.memToReg_out) 
      rfif.wdat = mwif.dmemload_out;
	   else 
      rfif.wdat = mwif.port_out_out;
  end
  always_comb begin
	   if(mwif.RegDest_out == 0) rfif.wsel = mwif.rd_out;
	   else if(mwif.RegDest_out == 1) rfif.wsel = mwif.rt_out;
	   else rfif.wsel = 5'b11111;
  end
  //setup ALU
  assign rdat1 = fuif.ow_rdat1? fuif.replace_rs:ieif.rdat1_out;
  assign rdat2 = fuif.ow_rdat2? fuif.replace_rt:ieif.rdat2_out;
  assign aluif.port_a = rdat1;
  assign aluif.aluop = ieif.ALUOp_out;
  always_comb begin
	   if(ieif.aluSrc_out == 2'b00) 
		    aluif.port_b = rdat2;
	   else if(ieif.aluSrc_out == 2'b01) 
		    aluif.port_b = ieif.shamt_out;
	   else if (ieif.aluSrc_out == 2'b10 && ieif.imm_out[15] == 1) 
		    aluif.port_b = {16'hFFFF, ieif.imm_out};
	   else 
		    aluif.port_b = {16'h0000,ieif.imm_out};
  end

  //setup CACHES (DATAPATH outputs)
  always_ff @(negedge nRST, posedge CLK) begin
  	if(~nRST) dpif.halt <= 0;
	else if(mwif.halt_in) 
    dpif.halt <= mwif.halt_in;
  end
  //assign dpif.halt = mwif.halt_out;
  assign dpif.imemREN = 1;
  assign dpif.dmemWEN = emif.dWEN_out;
  assign dpif.dmemREN = emif.dREN_out;
  assign dpif.dmemstore = emif.rdat2_out; 
  assign dpif.dmemaddr = emif.port_out_out;
  //assign dpif.dmemaddr = aluif.port_out; ////// GET RID OF THIS
  assign dpif.imemaddr = PC;
endmodule
