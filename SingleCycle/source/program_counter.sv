//Program is modified from the demo in class
`include "cpu_types_pkg.vh"
`include "program_counter_if.vh"

module program_counter(
  input CLK, nRST,
  program_counter_if.pc pcif
);

import cpu_types_pkg::*;

always_ff @(posedge CLK, negedge nRST) begin

	if(nRST == 0) 
	begin
		pcif.PC <= '0; 
	end	
	else 
	begin
		if(pcif.PCEN)
		begin
			pcif.PC <= pcif.new_pc;
		end	
	end
end

assign pcif.npc = pcif.PC + 4;

endmodule
