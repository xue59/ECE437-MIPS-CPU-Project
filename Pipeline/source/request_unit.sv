`include "request_unit_if.vh"
`include "cpu_types_pkg.vh"

module request_unit 
import cpu_types_pkg::*; 
(
	input logic CLK, nRST,
	request_unit_if.reqUnit ruif
);

	import cpu_types_pkg::*;

	always_ff @(posedge CLK, negedge nRST ) begin 
		if(~nRST) begin
			 ruif.clkREN <= 0;
			 ruif.clkWEN <= 0;
		end else if (ruif.dhit) begin
			 ruif.clkREN <= 0;
			 ruif.clkWEN <= 0;
		end else if (ruif.ihit) begin
			 ruif.clkREN <= ruif.dREN;
			 ruif.clkWEN <= ruif.dWEN;
		end
	end

assign ruif.pcEna = ruif.ihit;
endmodule
