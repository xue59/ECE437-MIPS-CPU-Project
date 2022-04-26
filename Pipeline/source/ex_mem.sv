`include "ex_mem_if.vh"
`include "cpu_types_pkg.vh"

module ex_mem 
import cpu_types_pkg::*; 
(
	input logic CLK, nRST, 
	ex_mem_if.exmem emif
);

	import cpu_types_pkg::*;

	always_ff @(posedge CLK, negedge nRST) begin
		if(~nRST) begin
		      emif.rdat2_out <= 0; 
		      emif.next_pc_out <= 0; 
                  emif.memToReg_out <= 0; 
                  emif.RegDest_out <= 0; 
                  emif.jal_out <= 0; 
                  emif.imemREN_out <= 1; 
                  emif.lui_out <= 0; 
                  emif.rd_out <= 0; 
                  emif.rt_out <= 0; 
                  emif.imm_out <= 0; 
                  emif.halt_out <= 0; 
                  emif.port_out_out <= 0; 
                  emif.instruction_out <= 0;
                  emif.dREN_out <= 0;
                  emif.dWEN_out <= 0;
                  emif.RegWrite_out <= 0; 
            end else if(emif.dhit) begin
                  emif.rdat2_out <= 0; 
                  emif.next_pc_out <= 0; 
                  emif.memToReg_out <= 0; 
                  emif.RegDest_out <= 0; 
                  emif.jal_out <= 0; 
                  emif.imemREN_out <= 1; 
                  emif.lui_out <= 0; 
                  emif.rd_out <= 0; 
                  emif.rt_out <= 0; 
                  emif.imm_out <= 0; 
                  emif.halt_out <= 0; 
                  emif.port_out_out <= 0; 
                  emif.instruction_out <= 0;
                  emif.dREN_out <= 0;
                  emif.dWEN_out <= 0;
                  emif.RegWrite_out <= 0; 
		end else if (emif.ihit) begin
		      emif.rdat2_out <= emif.rdat2_in; 
		      emif.next_pc_out <= emif.next_pc_in; 
                  emif.memToReg_out <= emif.memToReg_in; 
                  emif.RegDest_out <= emif.RegDest_in; 
                  emif.jal_out <= emif.jal_in; 
                  emif.imemREN_out <= emif.imemREN_in; 
                  emif.lui_out <= emif.lui_in; 
                  emif.rd_out <= emif.rd_in; 
                  emif.rt_out <= emif.rt_in; 
                  emif.imm_out <= emif.imm_in; 
                  emif.halt_out <= emif.halt_in; 
                  emif.port_out_out <= emif.port_out_in; 
                  emif.instruction_out <= emif.instruction_in;
                  emif.dREN_out <= emif.dREN_in;
                  emif.dWEN_out <= emif.dWEN_in;
                  emif.RegWrite_out <= emif.RegWrite_in; 
		end
	end
endmodule // if_id
