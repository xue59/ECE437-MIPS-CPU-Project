`include "id_ex_if.vh"
`include "cpu_types_pkg.vh"

module id_ex 
import cpu_types_pkg::*; 
(
	input logic CLK, nRST, 
	id_ex_if.idex ieif
);

	import cpu_types_pkg::*;

	always_ff @(posedge CLK or negedge nRST) begin : proc_
		if(~nRST) begin
			 ieif.rdat1_out <= 0;
			 ieif.rdat2_out <= 0; 
			 ieif.next_pc_out <= 0; 
			 ieif.ALUOp_out <= ALU_SLL; 
			 ieif.aluSrc_out <= 0; 
			 ieif.pcSrc_out <= 0; 
			 ieif.memToReg_out <= 0; 
			 ieif.RegWrite_out <= 0; 
			 ieif.RegDest_out <= 0; 
			 ieif.jumpSel_out <= 0;
    		 ieif.jal_out <= 0; 
    		 ieif.dREN_out <= 0; 
    		 ieif.dWEN_out <= 0; 
    		 ieif.imemREN_out <= 1; 
    		 ieif.lui_out <= 0; 
    		 ieif.bne_out <= 0; 
    		 ieif.shamt_out <= 0; 
    		 ieif.rd_out <= 0; 
    		 ieif.rt_out <= 0; 
    		 ieif.rs_out <= 0;
    		 ieif.imm_out <= 0; 
    		 ieif.halt_out <= 0;
    		 ieif.imm26_out <= 0;
    		 ieif.instruction_out <= 0;
		end else if ((ieif.flush && ieif.ihit) || ieif.freeze) begin
			 ieif.rdat1_out <= 0;
			 ieif.rdat2_out <= 0; 
			 ieif.next_pc_out <= 0; 
			 ieif.ALUOp_out <= ALU_SLL; 
			 ieif.aluSrc_out <= 0; 
			 ieif.pcSrc_out <= 0; 
			 ieif.memToReg_out <= 0; 
			 ieif.RegWrite_out <= 0; 
			 ieif.RegDest_out <= 0; 
			 ieif.jumpSel_out <= 0;
    		 ieif.jal_out <= 0; 
    		 ieif.dREN_out <= 0; 
    		 ieif.dWEN_out <= 0; 
    		 ieif.imemREN_out <= 1; 
    		 ieif.lui_out <= 0; 
    		 ieif.bne_out <= 0; 
    		 ieif.shamt_out <= 0; 
    		 ieif.rd_out <= 0; 
    		 ieif.rt_out <= 0; 
    		 ieif.rs_out <= 0;
    		 ieif.imm_out <= 0; 
    		 ieif.halt_out <= 0;
    		 ieif.imm26_out <= 0;
    		 ieif.instruction_out <= 0;
		end else if (ieif.ihit)begin
			 ieif.rdat1_out <= ieif.rdat1_in;
			 ieif.rdat2_out <= ieif.rdat2_in; 
			 ieif.next_pc_out <= ieif.next_pc_in; 
			 ieif.ALUOp_out <= ieif.ALUOp_in; 
			 ieif.aluSrc_out <= ieif.aluSrc_in; 
			 ieif.pcSrc_out <= ieif.pcSrc_in; 
			 ieif.memToReg_out <= ieif.memToReg_in; 
			 ieif.RegWrite_out <= ieif.RegWrite_in; 
			 ieif.RegDest_out <= ieif.RegDest_in; 
			 ieif.jumpSel_out <= ieif.jumpSel_in;
    		 ieif.jal_out <= ieif.jal_in; 
    		 ieif.dREN_out <= ieif.dREN_in; 
    		 ieif.dWEN_out <= ieif.dWEN_in; 
    		 ieif.imemREN_out <= ieif.imemREN_in; 
    		 ieif.lui_out <= ieif.lui_in; 
    		 ieif.bne_out <= ieif.bne_in; 
    		 ieif.shamt_out <= ieif.shamt_in; 
    		 ieif.rd_out <= ieif.rd_in; 
    		 ieif.rt_out <= ieif.rt_in; 
    		 ieif.rs_out <= ieif.rs_in;
    		 ieif.imm_out <= ieif.imm_in; 
    		 ieif.halt_out <= ieif.halt_in;
    		 ieif.imm26_out <= ieif.imm26_in;
    		 ieif.instruction_out <= ieif.instruction_in;
		end
	end





endmodule // if_id
