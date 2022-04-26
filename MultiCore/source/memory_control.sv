// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 2;
//Coherence Controller

typedef enum logic[3:0] {
  IDLE, ARB, IF, WB1, WB2, SNOOP, LD1, LD2, RAM_CACHE1, RAM_CACHE2
} state_t;

state_t state, next_state;
logic snooper, snoopy, next_snooper, next_snoopy; //snooper tells cc to snoop into snoopy
word_t [CPUS - 1 : 0] next_snoopaddr;
logic [CPUS - 1 : 0] next_wait, next_inv;

always_ff @(posedge CLK or negedge nRST) begin
  if(~nRST) begin
     state <= IDLE;
     snooper <= 0;
     snoopy <= 1;
  end else begin
     state <= next_state;
     snooper <= next_snooper;
     snoopy <= next_snoopy;
  end
end

always_comb begin : NEXT_STATE_LOGIC
  next_state = state;
  next_snooper = snooper;
  next_snoopy = snoopy;
  case(state)
    IDLE: begin
      if (ccif.dWEN[1] || ccif.dWEN[0]) next_state = WB1;
      else if (ccif.cctrans[1] || ccif.cctrans[0]) next_state = ARB;
      else if (ccif.iREN[1] || ccif.iREN[0]) next_state = IF;
    end
    ARB: begin
      if(ccif.dREN[1] || ccif.dREN[0]) begin
        next_state = SNOOP;
        if(ccif.dREN[0]) begin
          next_snooper = 0;
          next_snoopy = 1;
        end else if (ccif.dREN[1]) begin
          next_snooper = 1;
          next_snoopy = 0;
        end
      end else begin
        next_state = IDLE;
      end
    end
    SNOOP: begin
      if(ccif.cctrans[snoopy])
        next_state = RAM_CACHE1;
      else
        next_state = LD1;
    end
    LD1: begin
      if (ccif.ramstate == ACCESS) next_state = LD2;
    end
    LD2: begin
      if (ccif.ramstate == ACCESS) next_state = IDLE;
    end
    RAM_CACHE1: begin
      if (ccif.ramstate == ACCESS) next_state = RAM_CACHE2;
    end
    RAM_CACHE2: begin
      if (ccif.ramstate == ACCESS) next_state = IDLE;
    end
    IF: begin
      if (ccif.ramstate == ACCESS)
        next_state = (ccif.cctrans != 0)? ARB:IDLE;
      if (ccif.dWEN[1] || ccif.dWEN[0]) next_state = WB1;
    end
    WB1: begin
      if (ccif.ramstate == ACCESS) next_state = WB2;
    end
    WB2: begin
      if (ccif.ramstate == ACCESS) next_state = IDLE;
    end

  endcase // state
end

always_comb begin: OUTPUT_LOGIC

  ccif.iwait[1] = 1; ccif.iwait[0] = 1;
  ccif.iload[1] = 0; ccif.iload[0] = 0;
  ccif.dwait[1] = 1; ccif.dwait[0] = 1;
  ccif.dload[1] = 0; ccif.dload[0] = 0;

  ccif.ramaddr = 0;
  ccif.ramstore = 0;
  ccif.ramWEN = 0;
  ccif.ramREN = 0;

  ccif.ccsnoopaddr[1] = '0; ccif.ccsnoopaddr[0] = '0;
  ccif.ccwait[1] = 0; ccif.ccwait[0] = 0;
  ccif.ccinv[1] = ccif.ccwrite[0];  ccif.ccinv[0] = ccif.ccwrite[1];

  case(state)
    ARB: begin
      ccif.ccwait[next_snoopy] = 1;
      ccif.ccsnoopaddr[next_snoopy] = ccif.daddr[snooper];
    end
    SNOOP: begin
      ccif.ccsnoopaddr[snoopy] = ccif.daddr[snooper];
      ccif.ccwait[snoopy] = 1;
    end
    LD1: begin
      ccif.dwait[snooper] = ccif.ramstate != ACCESS;
      ccif.dload[snooper] = ccif.ramload;
      ccif.ramaddr = ccif.daddr[snooper];
      ccif.ramREN = ccif.dREN[snooper];

      ccif.ccwait[snoopy] = 1;
    end
    LD2: begin
      ccif.dwait[snooper] = ccif.ramstate != ACCESS;
      ccif.dload[snooper] = ccif.ramload;
      ccif.ramaddr = ccif.daddr[snooper];
      ccif.ramREN = ccif.dREN[snooper];

      ccif.ccwait[snoopy] = 1;
    end
    RAM_CACHE1: begin
      ccif.dwait[snoopy] = ccif.ramstate != ACCESS;
      ccif.dwait[snooper] = ccif.ramstate != ACCESS;
      ccif.dload[snooper] = ccif.dstore[snoopy];

      ccif.ramaddr = ccif.daddr[snoopy];
      ccif.ramstore = ccif.dstore[snoopy];
      ccif.ramWEN = 1;

      ccif.ccsnoopaddr[snoopy] = ccif.daddr[snooper];
      ccif.ccwait[snoopy] = 1;
    end
    RAM_CACHE2: begin
      ccif.dwait[snoopy] = ccif.ramstate != ACCESS;
      ccif.dwait[snooper] = ccif.ramstate != ACCESS;
      ccif.dload[snooper] = ccif.dstore[snoopy];

      ccif.ramaddr = ccif.daddr[snoopy];
      ccif.ramstore = ccif.dstore[snoopy];
      ccif.ramWEN = 1;

      ccif.ccsnoopaddr[snoopy] = ccif.daddr[snooper];
      ccif.ccwait[snoopy] = 1;
    end
    IF: begin
      if(ccif.iREN[1]) begin
        ccif.iload[1] = ccif.ramload;
        ccif.iwait[1] = ccif.ramstate != ACCESS;
        ccif.ramaddr = ccif.iaddr[1];
        ccif.ramREN = ccif.iREN[1];
      end else if (ccif.iREN[0]) begin
        ccif.iload[0] = ccif.ramload;
        ccif.iwait[0] = ccif.ramstate != ACCESS;
        ccif.ramaddr = ccif.iaddr[0];
        ccif.ramREN = ccif.iREN[0];
      end
    end
    WB1: begin
      if(ccif.dWEN[1]) begin
        ccif.dwait[1] = ccif.ramstate != ACCESS;
        ccif.ramaddr = ccif.daddr[1];
        ccif.ramWEN = ccif.dWEN[1];
        ccif.ramstore = ccif.dstore[1];
        ccif.ccwait[0] = 1;
      end else if (ccif.dWEN[0]) begin
        ccif.dwait[0] = ccif.ramstate != ACCESS;
        ccif.ramaddr = ccif.daddr[0];
        ccif.ramWEN = ccif.dWEN[0];
        ccif.ramstore = ccif.dstore[0];
        ccif.ccwait[1] = 0;
      end
    end
    WB2: begin
      if(ccif.dWEN[1]) begin
        ccif.dwait[1] = ccif.ramstate != ACCESS;
        ccif.ramaddr = ccif.daddr[1];
        ccif.ramWEN = ccif.dWEN[1];
        ccif.ramstore = ccif.dstore[1];
        ccif.ccwait[0] = 1;
      end else if (ccif.dWEN[0]) begin
        ccif.dwait[0] = ccif.ramstate != ACCESS;
        ccif.ramaddr = ccif.daddr[0];
        ccif.ramWEN = ccif.dWEN[0];
        ccif.ramstore = ccif.dstore[0];
        ccif.ccwait[1] = 0;
      end
    end
  endcase // state
end
endmodule 