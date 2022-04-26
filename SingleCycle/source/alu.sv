//Program is modified from the demo in class
`include "cpu_types_pkg.vh"
`include "alu_if.vh"

module alu(
  alu_if.alu math
);

import cpu_types_pkg::*;

always_comb begin
	math.porto = '0;
	math.overflow = 0;
	casez(math.aluop)
	ALU_SLL: begin
		math.porto = math.porta << math.portb;
	end
	ALU_SRL: begin
		math.porto = math.porta >> math.portb;
	end
	ALU_ADD: begin
		math.porto = $signed(math.porta) + $signed(math.portb);
		math.overflow = (math.porta[31] == math.portb[31]) && (math.porta[31] != math.porto[31]);
	end
	ALU_SUB: begin
		math.porto = $signed(math.porta) - $signed(math.portb);
		math.overflow = (math.porta[31] != math.portb[31]) && (math.porta[31] != math.porto[31]);
	end
	ALU_AND: begin
		math.porto = math.porta & math.portb;
	end
	ALU_OR: begin
		math.porto = math.porta | math.portb;
	end
	ALU_XOR: begin
		math.porto = math.porta ^ math.portb;
	end
	ALU_NOR: begin
		math.porto = ~(math.porta | math.portb);
	end
	ALU_SLT: begin
		math.porto = $signed(math.porta) < $signed(math.portb);
	end
	ALU_SLTU: begin
		math.porto = math.porta < math.portb;
	end
	endcase
end

assign math.zero = math.porto == '0;
assign math.negative = math.porto[31];

endmodule
