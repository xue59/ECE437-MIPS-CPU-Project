`include "if_id_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*; 
module if_id 
(
	input logic CLK, nRST, 
	if_id_if.ifid iiif
);

	import cpu_types_pkg::*;

	always_ff @(posedge CLK or negedge nRST) begin : proc_
		if(~nRST) begin
			 iiif.instruction_out <= 0;
			 iiif.next_pc_out <= 0;
		end else if (iiif.flush && iiif.ihit)begin
			 iiif.instruction_out <= 0;
			 iiif.next_pc_out <= 0;
		end else if (iiif.ihit && ~iiif.freeze)begin
			iiif.instruction_out <= iiif.instruction_in;
			iiif.next_pc_out <= iiif.next_pc_in;
		end
	end





endmodule // if_id
