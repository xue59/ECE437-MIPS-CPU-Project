`include "cpu_types_pkg.vh"
`include "request_unit_if.vh"

module request_unit(
  input logic CLK, nRST,
  request_unit_if.ru ruif
);

import cpu_types_pkg::*;

always_ff @ (posedge CLK, negedge nRST) begin
	if (nRST == 0) begin
		ruif.dmemREN <= 0;
		ruif.dmemWEN <= 0;
	end else if(ruif.dhit == 1) begin
		ruif.dmemREN <= 0;
		ruif.dmemWEN <= 0;
	end else if(ruif.ihit == 1) begin
		ruif.dmemREN <= ruif.dREN;
		ruif.dmemWEN <= ruif.dWEN;
	end
end

assign ruif.PCEN = ruif.ihit;

endmodule
