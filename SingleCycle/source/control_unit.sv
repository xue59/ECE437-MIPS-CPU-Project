//Program is modified from the demo in class
`include "cpu_types_pkg.vh"
`include "control_unit_if.vh"

module control_unit(
  control_unit_if.cu cuif
);

import cpu_types_pkg::*;
opcode_t opcode;
assign opcode = opcode_t'(cuif.instruction[31:26]);
funct_t func;
assign func = funct_t'(cuif.instruction[5:0]);
always_comb begin
	cuif.PCSrc = 0; 
	cuif.MemtoReg = 0; 
	cuif.RegWEN = 0; 
	cuif.JAL = 0; 
	cuif.halt = 0;//5
	cuif.dWEN = 0; 
	cuif.dREN = 0; 
	cuif.imemREN = 1; 
	cuif.LUI = 0; 
	cuif.BNE = 0;//10
	cuif.ALUSrc = 0; 
	cuif.RegDest = 0; 
	cuif.JumpSel = 0; 
	cuif.aluop = ALU_SLL; 
	cuif.rs = 0; //15
	cuif.rt = 0; 
	cuif.rd = 0; 
	cuif.imm = 0; 
	cuif.shamt = 0; //19 clear

	/*
		|    Var    |    00    |    01    |    10    |    11    |
		---------------------------------------------------------
		|  ALUSrc   |    rt    |  signed  |   zero   |   shamt  |
		---------------------------------------------------------
		|  RegDst   |    rd    |    rt    |    31    |    --    |
		---------------------------------------------------------
		|  JumpSel  |    no    |  J/JAL   |    JR    |  Branch  |
	*/

	if (cuif.instruction[31:26] == RTYPE) begin
		cuif.rs = cuif.instruction[25:21];
		cuif.rt = cuif.instruction[20:16];
		cuif.rd = cuif.instruction[15:11];
		cuif.shamt = {'0, cuif.instruction[10:6]};
		cuif.RegDest = 0;
		case(cuif.instruction[5:0])
			SLL: begin
				cuif.aluop = ALU_SLL;
				cuif.ALUSrc = 2'b11;
				cuif.RegWEN = 1;
			end
			SRL: begin
				cuif.aluop = ALU_SRL;
				cuif.ALUSrc = 2'b11;
				cuif.RegWEN = 1;
			end
			JR: begin
				cuif.JumpSel = 2'b10;
			end
			ADD: begin
				cuif.aluop = ALU_ADD;
				cuif.RegWEN = 1;
			end
			ADDU: begin
				cuif.aluop = ALU_ADD;
				cuif.RegWEN = 1;
			end
			SUB: begin
				cuif.aluop = ALU_SUB;
				cuif.RegWEN = 1;
			end
			SUBU: begin
				cuif.aluop = ALU_SUB;
				cuif.RegWEN = 1;
			end
			AND: begin
				cuif.aluop = ALU_AND;
				cuif.RegWEN = 1;
			end
			OR: begin
				cuif.aluop = ALU_OR;
				cuif.RegWEN = 1;
			end
			XOR: begin
				cuif.aluop = ALU_XOR;
				cuif.RegWEN = 1;
			end
			NOR: begin
				cuif.aluop = ALU_NOR;
				cuif.RegWEN = 1;
			end
			SLT: begin 
				cuif.aluop = ALU_SLT;
				cuif.RegWEN = 1;
			end
			SLTU: begin
				cuif.aluop = ALU_SLTU;
				cuif.RegWEN = 1;
			end
		endcase
	end else if (cuif.instruction[31:26] == J) begin
		cuif.JumpSel = 1;	
	end else if (cuif.instruction[31:26] == JAL) begin
		cuif.JAL = 1;
		cuif.RegDest = 2;
		cuif.JumpSel = 1;
		cuif.RegWEN = 1;
	end else begin //itype
		cuif.RegDest = 1;
		cuif.rs = cuif.instruction[25:21];
		cuif.rt = cuif.instruction[20:16];
		cuif.imm = cuif.instruction[15:0];
		case(cuif.instruction[31:26])
			BEQ: begin
				cuif.aluop = ALU_SUB;
				cuif.PCSrc = 1;
				cuif.JumpSel = 3;
			end
			BNE: begin
				cuif.aluop = ALU_SUB;
				cuif.BNE = 1;
				cuif.PCSrc = 1;
				cuif.JumpSel = 3;
			end
			ADDI: begin
				cuif.aluop = ALU_ADD;
				cuif.ALUSrc = 1; //signed
				cuif.RegWEN = 1;
			end
			ADDIU: begin
				cuif.aluop = ALU_ADD;
				cuif.ALUSrc = 1; //signed
				cuif.RegWEN = 1;
			end
			SLTI: begin
				cuif.aluop = ALU_SLT;
				cuif.ALUSrc = 1; //signed
				cuif.RegWEN = 1;
			end
			SLTIU: begin
				cuif.aluop = ALU_SLT;
				cuif.ALUSrc = 1; //signed
				cuif.RegWEN = 1;
			end
			ANDI: begin
				cuif.aluop = ALU_AND;
				cuif.ALUSrc = 2; //zero
				cuif.RegWEN = 1;
			end
			ORI: begin
				cuif.aluop = ALU_OR;
				cuif.ALUSrc = 2; //zero
				cuif.RegWEN = 1;
			end
			XORI: begin
				cuif.aluop = ALU_XOR;
				cuif.ALUSrc = 2; //zero
				cuif.RegWEN = 1;
			end
			LUI: begin
				cuif.LUI = 1;
				cuif.RegWEN = 1;
			end
			LW: begin
				cuif.RegWEN = 1;
				cuif.MemtoReg = 1;
				cuif.aluop = ALU_ADD;
				cuif.ALUSrc = 1;//signed
				cuif.dREN = 1;
			end
			SW: begin
				cuif.dWEN = 1;
				cuif.aluop = ALU_ADD;
				cuif.ALUSrc = 1;//signed
			end
			HALT: begin
				cuif.halt = 1;
				//ocuif.imemREN = 0;
			end
		endcase
	end
end

endmodule
