`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface request_unit_if;
  // import types
  import cpu_types_pkg::*;

  logic dWEN,dREN, dhit, ihit, dmemREN, dmemWEN, PCEN;

  // control_unit ports
  modport ru (
	input dWEN,dREN, dhit, ihit,
	output dmemREN, dmemWEN, PCEN
  );
  // control_unit tb
  modport tb (
	input dmemREN, dmemWEN,PCEN,
	output dREN, dWEN, dhit, ihit
  );
endinterface

`endif
