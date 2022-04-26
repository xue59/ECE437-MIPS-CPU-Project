import cpu_types_pkg::*;

module icache (
	input logic CLK, nRST,
	datapath_cache_if dcif,
	caches_if.icache cif
);

typedef struct packed {
	logic [25:0] tag;
	word_t data;
	logic valid;
} icache_t;

//Declarations
integer i;
icache_t ht [15:0]; //to match the addrs

logic [25:0] tag;
logic [3:0] index;

word_t imemload;
logic ihit, miss;

//The maps
always_ff @(posedge CLK or negedge nRST) begin
	if(~nRST) begin
		for (i = 0; i < 16; i++) begin
			 ht[i].tag <= 0;
			 ht[i].data <= 0;
			 ht[i].valid <= 0;
		end
	end else begin
		if(ihit) begin
			 ht[index].tag <= dcif.imemaddr[31:6];
			 ht[index].data <= imemload;
			 ht[index].valid <= 1;
		end
	end
end

//Datapath
assign tag = dcif.imemaddr[31:6];
assign index = dcif.imemaddr[5:2];

always_comb begin
	if(dcif.halt) begin
		miss = 0;
		dcif.ihit = 0;
		dcif.imemload = 0;
	end else if(dcif.imemREN && !dcif.dmemREN && !dcif.dmemWEN) begin
		if((tag == ht[index].tag) && ht[index].valid) begin
			miss = 0;
			dcif.ihit = 1;
			dcif.imemload = ht[index].data;
		end else begin
			miss = 1;
			dcif.ihit = ihit;
			dcif.imemload = imemload;
		end
	end else begin
		miss = 0;
		dcif.ihit = 0;
		dcif.imemload = 0;
	end
end

//RAM
assign ihit = ~cif.iwait;
assign imemload = cif.iload;
assign cif.iREN = miss? dcif.imemREN:0;
assign cif.iaddr = miss? dcif.imemaddr: '0;

endmodule // icache