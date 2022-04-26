`ifndef PREDICT_UNIT_IF_VH
`define PREDICT_UNIT_IF_VH

// ram memory types
`include "cpu_types_pkg.vh"

interface predict_unit_if;

  // import types
  import cpu_types_pkg::*;
  logic [1:0] prediction;
  logic flush, isnew;

  modport prdt (
	input flush, isnew,
	output prediction
  );

  modport tb (
	input prediction,
	output flush, isnew
  );


endinterface

`endif //PREDICTI_UNIT_IF_VH
