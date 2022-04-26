`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"

module control_unit 
import cpu_types_pkg::*; 
(
	control_unit_if.conUnit conif
);

	import cpu_types_pkg::*;

	always_comb begin
		conif.imm26 = conif.instruction[25:0];
		conif.rs = conif.instruction[25:21];//reg s
		conif.rt = conif.instruction[20:16];//reg t
		conif.rd = conif.instruction[15:11];//reg d
		conif.pcSrc = 0;					//use program counter
		conif.shamt = {'0, conif.instruction[10:6]};//shift amount
		conif.lui = 0;						//always zero unless lui instruction
		conif.bne = 0;						//don't bne
		conif.imm = conif.instruction[15:0];//immediate value -- 0 because r type
		conif.jumpSel = '0;					//don't enable jump
		conif.jal = '0;						//don't jump and link
		conif.memToReg = 0;					//use alu result
		conif.dREN	= 0;					//don't read from mem
		conif.dWEN	= 0;					//don't write to mem
		conif.imemREN = 1;					//always read next instruction unless halt
		conif.RegDest = 2'b01;				//rt
		conif.RegWrite = 1;					//write to register
		conif.ALUOp = ALU_SLL;				//Add
		conif.aluSrc = '0;					//rt
		conif.halt = 0;
		casez(conif.instruction[31:26]) 
			
			RTYPE: begin
				conif.RegDest = '0;					//rd
				casez(conif.instruction[5:0])
					ADDU: begin
						conif.ALUOp = ALU_ADD;				//Add
					end
					ADD: begin
						conif.ALUOp = ALU_ADD;
					end
					AND: begin
						conif.ALUOp = ALU_AND;
					end
					JR: begin
						conif.RegWrite = 0;
						conif.jumpSel = 2'b10;				//use rs for pc
					end
					NOR: begin
						conif.ALUOp = ALU_NOR;
					end
					OR: begin
						conif.ALUOp = ALU_OR;
					end
					SLT: begin
						conif.ALUOp = ALU_SLT;
					end
					SLTU: begin
						conif.ALUOp = ALU_SLTU;
					end
					SLL: begin
						conif.ALUOp = ALU_SLL;
						conif.aluSrc = 2'b01;				//use shamt
					end
					SRL: begin
						conif.ALUOp = ALU_SRL;
						conif.aluSrc = 2'b01;				//use shamt
					end
					SUBU: begin;
						conif.ALUOp = ALU_SUB;
					end
					SUB: begin
						conif.ALUOp = ALU_SUB;
					end
					XOR: begin
						conif.ALUOp = ALU_XOR;
					end
				endcase
			end
		
			ADDIU: begin
				conif.ALUOp = ALU_ADD;
				conif.aluSrc = 2'b10;						//signExtImm					
			end
			ADDI: begin
				conif.ALUOp = ALU_ADD;
				conif.aluSrc = 2'b10;						//signExtImm					
			end
			ANDI: begin
				conif.ALUOp = ALU_AND;
				conif.aluSrc = 2'b11;						//zeroExtImm				
			end
	//******************************************************************
			BEQ: begin //branch if rs and rt are equal 
				conif.ALUOp = ALU_SUB;
				conif.RegWrite = 0;
				conif.pcSrc = 1;					//this is a jump
				conif.jumpSel = 2'b11;				//use branch for pc
			end
			BNE: begin
				conif.ALUOp = ALU_SUB;
				conif.RegWrite = 0;
				conif.pcSrc = 1;					//this is a jump
				conif.jumpSel = 2'b11;				//use rs for pc
				conif.bne = 1;
			end
	//*******************************************************************
			LUI: begin
				conif.lui = 1;
			end		
			LW: begin
				conif.ALUOp = ALU_ADD;
				conif.aluSrc = 2'b10;						//signed
				conif.memToReg = 1;
				conif.dREN = 1;
			end
			ORI: begin
				conif.ALUOp = ALU_OR;
				conif.aluSrc = 2'b11;						//zeroExtImm
			end
			SLTI: begin
				conif.ALUOp = ALU_SLT;
				conif.aluSrc = 2'b10;						//zeroExtImm
			end
			SLTIU: begin
				conif.ALUOp = ALU_SLTU;
				conif.aluSrc = 2'b10;						//zeroExtImm
			end
			SW: begin
				conif.ALUOp = ALU_ADD;
				conif.aluSrc = 2'b10;//signed
				conif.dWEN = 1;
				conif.RegWrite = 0;
			end

			XORI: begin
				conif.ALUOp = ALU_XOR;
				conif.aluSrc = 2'b11;	
			end
			HALT: begin
				conif.halt = 1;
				conif.RegWrite = 0;
			end
			J: begin
				conif.pcSrc = 1;
				conif.jumpSel = 2'b01;
				conif.RegDest = 2'b10;
				conif.RegWrite = 0;
			end
			JAL: begin
				conif.jal = 1;
				conif.RegWrite = 1;
				conif.RegDest = 2'b10;
				conif.jumpSel = 2'b01;
			end
			
		endcase

	end

endmodule