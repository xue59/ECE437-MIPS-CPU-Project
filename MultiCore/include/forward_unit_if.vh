`ifndef FORWARD_UNIT_IF_VH
`define FORWARD_UNIT_IF_VH

// types
`include "cpu_types_pkg.vh"

interface forward_unit_if;
  // import types
  import cpu_types_pkg::*;

  regbits_t rs, rt, rw_mem, rw_wb; 
  logic ow_rdat1, ow_rdat2, regwrite_mem, regwrite_wb;
  word_t mem_data, wb_data, replace_rs, replace_rt;



  // system ports
  modport fu (
    input rs, rt, regwrite_mem, regwrite_wb, 
          rw_mem, rw_wb, mem_data, wb_data,
    output replace_rs, ow_rdat1, replace_rt, ow_rdat2
  );
  // testbench program
  modport tb (
    output rs, rt, regwrite_mem, regwrite_wb, 
          rw_mem, rw_wb, mem_data, wb_data,
    input replace_rs, ow_rdat1, replace_rt, ow_rdat2
  );
endinterface

`endif
