`include "mem_wb_if.vh"
`include "cpu_types_pkg.vh"

module mem_wb 
import cpu_types_pkg::*; 
(
	input logic CLK, nRST, 
	mem_wb_if.memwb wbif
);

	import cpu_types_pkg::*;

	always_ff @(posedge CLK or negedge nRST) begin : proc_
		if(~nRST) begin
			wbif.next_pc_out <= 0; 
                  wbif.jal_out <= 0; 
                  wbif.lui_out <= 0; 
                  wbif.memToReg_out <= 0; 
                  wbif.dmemload_out <= 0; 
                  wbif.imm_out <= 0; 
                  wbif.port_out_out <= 0;
                  wbif.imemREN_out <= 1; 
                  wbif.halt_out <= 0; 
                  wbif.rd_out <= 0; 
                  wbif.rt_out <= 0; 
                  wbif.RegDest_out <= 0; 
                  wbif.RegWrite_out  <= 0;
                  wbif.instruction_out <= 0;
		end else if (wbif.ihit | wbif.dhit)begin
		      wbif.next_pc_out <= wbif.next_pc_in;
                  wbif.jal_out <= wbif.jal_in; 
                  wbif.lui_out <= wbif.lui_in; 
                  wbif.memToReg_out <= wbif.memToReg_in;  
                  wbif.imm_out <= wbif.imm_in; 
                  wbif.port_out_out <= wbif.port_out_in;
                  wbif.imemREN_out <= wbif.imemREN_in; 
                  wbif.halt_out <= wbif.halt_in; 
                  wbif.rd_out <= wbif.rd_in; 
                  wbif.rt_out <= wbif.rt_in; 
                  wbif.RegDest_out <= wbif.RegDest_in; 
                  wbif.RegWrite_out  <= wbif.RegWrite_in;
                  wbif.dmemload_out <= wbif.dmemload_in;
                  wbif.instruction_out <= wbif.instruction_in;
            end
	end



endmodule // if_id
