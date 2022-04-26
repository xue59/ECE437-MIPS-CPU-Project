/*
Stephen Bulley
sbulley@purdue.edu

Register File
*/

`include "cpu_types_pkg.vh"
`include "forward_unit_if.vh"



module forward_unit 
import cpu_types_pkg::*; 
(
  forward_unit_if.fu fuif

);

//rdat1 (rs)
always_comb begin
  if (fuif.rs == fuif.rw_mem && fuif.regwrite_mem == 1) begin
    fuif.replace_rs = fuif.mem_data;
    fuif.ow_rdat1 = 1;
  end else if (fuif.rs == fuif.rw_wb && fuif.regwrite_wb == 1) begin
    fuif.replace_rs = fuif.wb_data;
    fuif.ow_rdat1 = 1;
  end else begin
    fuif.replace_rs = '0;
    fuif.ow_rdat1 = 0;
  end
end


//rdat2 (rt)
always_comb begin
  if (fuif.rt == fuif.rw_mem && fuif.regwrite_mem == 1) begin
    fuif.replace_rt = fuif.mem_data;
    fuif.ow_rdat2 = 1;
  end else if (fuif.rt == fuif.rw_wb && fuif.regwrite_wb == 1) begin
    fuif.replace_rt = fuif.wb_data;
    fuif.ow_rdat2 = 1;
  end else begin
    fuif.replace_rt = '0;
    fuif.ow_rdat2 = 0;
  end
end


endmodule