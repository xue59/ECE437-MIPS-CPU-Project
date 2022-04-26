/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
`include "control_unit_if.vh"
`include "request_unit_if.vh"
`include "register_file_if.vh"
`include "alu_if.vh"
`include "program_counter_if.vh"

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
  request_unit_if ruif();
  register_file_if rfif();
  alu_if aluif();
  program_counter_if pcif();
  
  //DUT
  control_unit CTRLU(cuif);
  request_unit REQU(CLK, nRST, ruif);
  register_file REGF(CLK, nRST, rfif);
  alu ALU(aluif);
  program_counter PC(CLK, nRST, pcif);

  //Signed, Zero, Jump, Branch
  word_t SignedExt, ZeroExt, JumpAddr, BranchAddr;
  assign SignedExt = (cuif.imm[15] == 1)? {16'hffff, cuif.imm}:{16'h0000, cuif.imm};
  assign ZeroExt = {16'h0000, cuif.imm};
  assign JumpAddr = {pcif.npc[31:28],dpif.imemload[25:0],2'b00};
  assign BranchAddr = ((cuif.BNE? (~aluif.zero):aluif.zero) && cuif.PCSrc)? (pcif.npc + {ZeroExt[29:0],2'b00}):pcif.npc;
  //setup REG FILE
  assign rfif.WEN = cuif.RegWEN & ( dpif.ihit | dpif.dhit);
  assign rfif.wsel = (cuif.RegDest == 2'b00)? cuif.rd:((cuif.RegDest == 2'b01)? cuif.rt:5'b11111);
  assign rfif.rsel1 = cuif.rs; 
  assign rfif.rsel2 = cuif.rt;
  assign rfif.wdat = cuif.LUI? {cuif.imm,16'b0}:(cuif.JAL? pcif.npc:(cuif.MemtoReg? dpif.dmemload:aluif.porto));
  //setup ALU
  assign aluif.porta = rfif.rdat1;
  assign aluif.portb = (cuif.ALUSrc == 2'b00)? rfif.rdat2:((cuif.ALUSrc == 2'b01)? SignedExt:((cuif.ALUSrc == 2'b10)?ZeroExt:cuif.shamt));
  assign aluif.aluop = cuif.aluop;
  //setup REQ UNIT
  assign ruif.dWEN = cuif.dWEN;
  assign ruif.dREN = cuif.dREN;
  assign ruif.dhit = dpif.dhit;
  assign ruif.ihit = dpif.ihit;
  //setup PC
  assign pcif.PCEN = ruif.PCEN;
  assign pcif.new_pc = (cuif.JumpSel == 2'b00)? pcif.npc:((cuif.JumpSel == 2'b01)? JumpAddr:((cuif.JumpSel == 2'b10)? rfif.rdat1: BranchAddr));
  //setup CTRL UNIT
  assign cuif.instruction = dpif.imemload;
  //setup datapath outputs
  always_ff @(negedge nRST, posedge CLK) begin
	if(~nRST) dpif.halt <= 0;
	else dpif.halt <= cuif.halt;
  end
  assign dpif.imemREN = cuif.imemREN;
  assign dpif.imemaddr = pcif.PC;
  assign dpif.dmemREN = ruif.dmemREN;
  assign dpif.dmemWEN = ruif.dmemWEN;
  assign dpif.dmemstore = rfif.rdat2;
  assign dpif.dmemaddr = aluif.porto;

endmodule
