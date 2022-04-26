`include "cpu_types_pkg.vh"
`include "hazard_unit_if.vh"

module hazard_unit 
import cpu_types_pkg::*; 
(
  hazard_unit_if.hu huif

);

//flush

//flush = ieif.pcSrc_out & (ieif.bne_out? ~aluif.zero: aluif.zero);
always_comb begin
  if (huif.jumpSel == 3) begin
    huif.flush = huif.pcSrc && (huif.bne ? ~huif.zero : huif.zero);
  end else if (huif.jumpSel > 0) begin
    huif.flush = 1;
  end else begin
    huif.flush = 0;
  end
end

//freeze
always_comb begin
  huif.freeze = 0;
  if((huif.instruction[31:26] == LW || huif.instruction[31:26] == SW) & ~huif.dhit) begin
    if((huif.rs_d == huif.rw_m) && huif.regwrite_m) begin
      huif.freeze = 1;
    end else if((huif.rt_d == huif.rw_m) && huif.regwrite_m) begin
      huif.freeze = 1;
    end
  end
end


endmodule