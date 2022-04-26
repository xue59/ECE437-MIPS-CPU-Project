/*
Stephen Bulley
sbulley@purdue.edu

Register File
*/

`include "cpu_types_pkg.vh"
`include "register_file_if.vh"



module register_file 
import cpu_types_pkg::*; 
(
  input logic CLK,
  input logic nRst,
  register_file_if.rf io

);

  word_t myReg [31:0];

  assign io.rdat1 = myReg[io.rsel1];
  assign io.rdat2 = myReg[io.rsel2];


always_ff @ (negedge CLK, negedge nRst)
  begin

  if(nRst == 0)begin
    myReg <= '{default:'0};
  end else begin
    if ((io.WEN == 1'b1) && (io.wsel != 5'b00000)) begin
      myReg[io.wsel] <= io.wdat;
  end
end
end



endmodule

