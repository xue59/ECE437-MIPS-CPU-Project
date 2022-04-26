import cpu_types_pkg::*;

module dcache (
	input logic CLK, nRST,
	datapath_cache_if.dcache dcif,
	caches_if.dcache cif
);

typedef struct packed {
	//left table
	logic [25:0] left_tag;
	word_t left_data1, left_data2;
	logic left_dirty, left_valid;
	//right table
	logic [25:0] right_tag;
	word_t right_data1, right_data2;
	logic right_dirty, right_valid;
} dcache_t;

typedef enum logic[3:0] {
	IDLE, WB1, WB2, LD1, LD2, 
	FLUSH1, FLUSH2, DIRTY, CNT, HALT, 
	CHK, SHARE1, SHARE2, INVALID
} state_t;

//Declaration
dcache_t ht[7:0];
integer i;

logic offset;
logic [25:0] tag;
logic [2:0] ind, row_trunc;

logic miss, available[7:0], next_available[7:0];
logic [4:0] row, next_row;
word_t hit_count, next_hit_count;

state_t state, next_state;
//Link reg
word_t linkreg, next_linkreg;
logic linkreg_valid, next_linkreg_valid;
//Seperate my input address
assign offset = dcif.dmemaddr[2];
assign ind = dcif.dmemaddr[5:3];
assign tag = dcif.dmemaddr[31:6];
assign row_trunc = row[2:0] - 1;
//IDLE state
logic [25:0] left_tag, right_tag;
word_t left_data1, left_data2, right_data1, right_data2;
logic left_dirty, left_valid, right_dirty, right_valid;

logic [25:0] sleft_tag, sright_tag;
word_t sleft_data1, sleft_data2, sright_data1, sright_data2;
logic sleft_dirty, sleft_valid, sright_dirty, sright_valid;

//CCWRITE signal
assign cif.ccwrite = dcif.dmemWEN;
logic [25:0] snooptag;
logic [2:0] snoopind;
logic snoopoffset;
logic snoophitL, snoophitR,snoopdirty;
logic next_snoophitL, next_snoophitR;
assign snooptag = cif.ccsnoopaddr[31:6];
assign snoopind = cif.ccsnoopaddr[5:3];
assign snoopoffset = cif.ccsnoopaddr[2];

always_ff @(posedge CLK or negedge nRST) begin
	if(~nRST) begin
		 for (i = 0; i < 8; i++) begin
		 	ht[i].left_tag <= 0;
		 	ht[i].left_data1 <= 0;
		 	ht[i].left_data2 <= 0;
		 	ht[i].left_dirty <= 0;
		 	ht[i].left_valid <= 0;

		 	ht[i].right_tag <= 0;
		 	ht[i].right_data1 <= 0;
		 	ht[i].right_data2 <= 0;
		 	ht[i].right_dirty <= 0;
		 	ht[i].right_valid <= 0;
		 end
	end else begin
		ht[ind].left_data1 <= left_data1;
		ht[ind].left_data2 <= left_data2;
		ht[ind].right_data1 <= right_data1;
		ht[ind].right_data2 <= right_data2;
		ht[ind].left_dirty <= left_dirty;
		ht[ind].right_dirty <= right_dirty;
		ht[ind].left_tag <= left_tag;
		ht[ind].left_valid <= left_valid;
		ht[ind].right_tag <= right_tag;
		ht[ind].right_valid <= right_valid;

		if(state == CHK || state == SHARE1 || state == SHARE2) begin
			ht[snoopind].left_data1 <= sleft_data1;
			ht[snoopind].left_data2 <= sleft_data2;
			ht[snoopind].right_data1 <= sright_data1;
			ht[snoopind].right_data2 <= sright_data2;
			ht[snoopind].left_dirty <= sleft_dirty;
			ht[snoopind].right_dirty <= sright_dirty;
			ht[snoopind].left_tag <= sleft_tag;
			ht[snoopind].left_valid <= sleft_valid;
			ht[snoopind].right_tag <= sright_tag;
			ht[snoopind].right_valid <= sright_valid;
		end
	end
end

//State Machine
always_ff @(posedge CLK or negedge nRST) begin
	if(~nRST) begin
		 state <= IDLE;
		 for (i = 0; i < 8; i++)
		 	available[i] <= 0;
		 row <= 0;
		 hit_count <= 0;
		 snoophitL <= 0;
		 snoophitR <= 0;
		 linkreg <= 0;
		 linkreg_valid <= 0;
	end else begin
		 state <= next_state;
		 for (i = 0; i < 8; i++)
		 	available[i] <= next_available[i];
		 row <= next_row;
		 hit_count <= next_hit_count;
		 snoophitL <= next_snoophitL;
		 snoophitR <= next_snoophitR;
		 linkreg <= next_linkreg;
		 linkreg_valid <= next_linkreg_valid;
	end
end

//Next State Logic
always_comb begin : NEXT_LOGIC
	next_state = state;
	next_row = row;
	cif.cctrans = 0;
	case(state)
		IDLE : begin
			if (dcif.halt) next_state = DIRTY;
			else if (cif.ccwait) next_state = CHK;
			else if (miss) begin //miss has two: dirty miss and clean miss
				if (available[ind] == 0) begin
					next_state = ht[ind].left_dirty? WB1:LD1;
					cif.cctrans = ~ht[ind].left_dirty;
				end else begin
					next_state = ht[ind].right_dirty? WB1:LD1;
					cif.cctrans = ~ht[ind].right_dirty;
				end
			end
		end
		WB1 : begin
			if (~cif.dwait) next_state = WB2;
		end
		WB2 : begin
			if (~cif.dwait) next_state = LD1;
		end
		LD1 : begin
			cif.cctrans = ~cif.ccwait;
			if (~cif.dwait) next_state = LD2;
			if(cif.ccwait) next_state = CHK;
		end
		LD2 : begin
			if (~cif.dwait) next_state = IDLE;
		end
		DIRTY : begin
			if (row < 8) begin
				if(ht[row[2:0]].left_dirty && ht[row[2:0]].left_valid) begin
					next_state = FLUSH1;
				end
			end else begin
				if(ht[row[2:0]].right_dirty && ht[row[2:0]].right_valid) begin
					next_state = FLUSH1;
				end
			end
			next_row = row + 1;
		 	if(row == 5'b10000)
		 		next_state = HALT; // we don't need CNT anymore
		end
		FLUSH1 : begin
			if (~cif.dwait) next_state = FLUSH2;
		end
		FLUSH2 : begin
			if (~cif.dwait) next_state = DIRTY;
		end
		CNT : begin
			if (~cif.dwait) next_state = HALT;
		end
		CHK : begin
			if(cif.ccwait) begin
				next_state = snoopdirty? SHARE1 : CHK;
				cif.cctrans = snoopdirty;
				if ((next_snoophitL || next_snoophitR) == 0) next_state = CHK;
			end else next_state = IDLE;
		end
		SHARE1 : begin
			if (~cif.dwait) next_state = SHARE2;
		end
		SHARE2 : begin
			if (~cif.dwait) next_state = INVALID;
		end
		INVALID: begin
			next_state = IDLE;
		end
	endcase // state
end

//Output Logic
assign dcif.flushed = state == HALT;
integer j;
always_comb begin : OUTPUT_LOGIC
	miss = 0;
	dcif.dhit = 0;
	dcif.dmemload = 0;
	cif.dREN = 0;
	cif.dWEN = 0;
	cif.daddr = 0;
	cif.dstore = 0;

	left_data1 = ht[ind].left_data1; 
	left_data2 = ht[ind].left_data2;
	right_data1 = ht[ind].right_data1;
	right_data2 = ht[ind].right_data2;
	left_dirty = ht[ind].left_dirty;
	right_dirty = ht[ind].right_dirty;
	left_valid = ht[ind].left_valid; 
	right_valid = ht[ind].right_valid;
	left_tag = ht[ind].left_tag;
	right_tag = ht[ind].right_tag;

	sleft_data1 = ht[snoopind].left_data1; 
	sleft_data2 = ht[snoopind].left_data2;
	sright_data1 = ht[snoopind].right_data1;
	sright_data2 = ht[snoopind].right_data2;
	sleft_dirty = ht[snoopind].left_dirty;
	sright_dirty = ht[snoopind].right_dirty;
	sleft_valid = ht[snoopind].left_valid; 
	sright_valid = ht[snoopind].right_valid;
	sleft_tag = ht[snoopind].left_tag;
	sright_tag = ht[snoopind].right_tag;

	for(j = 0; j < 8; j++) next_available[j] = available[j];
	next_hit_count = hit_count;

	next_snoophitL = snoophitL;
	next_snoophitR = snoophitR;
	snoopdirty = 0;
	//LL SC
	next_linkreg_valid = linkreg_valid;
	next_linkreg = linkreg;
	case(state)
		IDLE : begin
			if (dcif.halt) next_hit_count = hit_count;
			else if (dcif.dmemREN) begin
				if (dcif.datomic) begin
					next_linkreg = dcif.dmemaddr;
					next_linkreg_valid = 1;
				end
				if ((tag == ht[ind].left_tag) && ht[ind].left_valid) begin
					dcif.dhit = 1;
					dcif.dmemload = offset? ht[ind].left_data2:ht[ind].left_data1;
					next_available[ind] = 1;
					next_hit_count = hit_count + 1;
				end else if ((tag == ht[ind].right_tag) && ht[ind].right_valid) begin
					dcif.dhit = 1;
					dcif.dmemload = offset? ht[ind].right_data2:ht[ind].right_data1;
					next_available[ind] = 0;
					next_hit_count = hit_count + 1;
				end else begin
					miss = 1;
					next_hit_count = hit_count - 1;
					if(next_available[ind] == 0) begin
						left_dirty = 0; left_valid = 1;
					end else begin
						right_dirty = 0; right_valid = 1;
					end
				end
			end else if (dcif.dmemWEN) begin
				//SC
				if (dcif.datomic) begin
					dcif.dmemload = (dcif.dmemaddr == linkreg) && linkreg_valid;

					//SC's SW part, store only when addr is correct, and hasn't been inv-ed
					if(dcif.dmemaddr == linkreg && linkreg_valid) begin
						if ((tag == ht[ind].left_tag)) begin
							if (!ht[ind].left_dirty && ht[ind].left_valid) begin 
								miss = 1; //treat it as a miss
								left_dirty = 1;
								next_available[ind] = 0;
							end else begin
								next_linkreg_valid = 0;
								next_linkreg = 0;
								dcif.dhit = 1;
								left_dirty = 1;
								next_available[ind] = 1;
								next_hit_count = hit_count + 1;
								if(offset == 0) left_data1 = dcif.dmemstore;
								else left_data2 = dcif.dmemstore;
							end
						end else if ((tag == ht[ind].right_tag)) begin
							if (!ht[ind].right_dirty && ht[ind].right_valid) begin
								miss = 1;
								right_dirty = 1;
								next_available[ind] = 1;
							end else begin
								next_linkreg_valid = 0;
								next_linkreg = 0;
								dcif.dhit = 1;
								right_dirty = 1;
								next_available[ind] = 0;
								next_hit_count = hit_count + 1;
								if(offset == 0) right_data1 = dcif.dmemstore;
								else right_data2 = dcif.dmemstore;
							end
						end else begin
							miss = 1;
							next_hit_count = hit_count - 1;
							if(next_available[ind] == 0) begin
								left_dirty = 0; left_valid = 1;
							end else begin
								right_dirty = 0; right_valid = 1;
							end
						end
					end else begin
						//Fail, dhit it
						dcif.dhit = 1;
					end
				//SW
				end else begin 
					if (dcif.dmemaddr == linkreg) begin
						next_linkreg_valid = 0;
						next_linkreg = 0;
					end
					if ((tag == ht[ind].left_tag)) begin
						if (!ht[ind].left_dirty && ht[ind].left_valid) begin 
							miss = 1; //treat it as a miss
							left_dirty = 1;
							next_available[ind] = 0;
						end else begin
							dcif.dhit = 1;
							left_dirty = 1;
							next_available[ind] = 1;
							next_hit_count = hit_count + 1;
							if(offset == 0) left_data1 = dcif.dmemstore;
							else left_data2 = dcif.dmemstore;
						end
					end else if ((tag == ht[ind].right_tag)) begin
						if (!ht[ind].right_dirty && ht[ind].right_valid) begin
							miss = 1;
							right_dirty = 1;
							next_available[ind] = 1;
						end else begin
							dcif.dhit = 1;
							right_dirty = 1;
							next_available[ind] = 0;
							next_hit_count = hit_count + 1;
							if(offset == 0) right_data1 = dcif.dmemstore;
							else right_data2 = dcif.dmemstore;
						end
					end else begin
						miss = 1;
						next_hit_count = hit_count - 1;
						if(next_available[ind] == 0) begin
							left_dirty = 0; left_valid = 1;
						end else begin
							right_dirty = 0; right_valid = 1;
						end
					end
				end
			end
		end
		WB1 : begin
			cif.dWEN = 1;
			if(available[ind] == 0) begin
				cif.daddr = {ht[ind].left_tag, ind, 3'b000};
				cif.dstore = ht[ind].left_data1;
			end else begin
				cif.daddr = {ht[ind].right_tag, ind, 3'b000};
				cif.dstore = ht[ind].right_data1;
			end
		end
		WB2 : begin
			cif.dWEN = 1;
			if(available[ind] == 0) begin
				cif.daddr = {ht[ind].left_tag, ind, 3'b100};
				cif.dstore = ht[ind].left_data2;
			end else begin
				cif.daddr = {ht[ind].right_tag, ind, 3'b100};
				cif.dstore = ht[ind].right_data2;
			end
		end
		LD1 : begin
			cif.dREN = 1;
			cif.daddr = {tag, ind, 3'b000};
			if (available[ind] == 0) begin
				left_data1 = cif.dload;
			end else begin
				right_data1 = cif.dload;
			end
		end
		LD2 : begin
			cif.dREN = 1;
			cif.daddr = {tag, ind, 3'b100};
			//cif.cctrans = 1;
			if (available[ind] == 0) begin
				left_data2 = cif.dload;
				left_tag = tag;
			end else begin
				right_data2 = cif.dload;
				right_tag = tag;
			end
		end
		FLUSH1 : begin
			cif.dWEN = 1;
			if(row - 1 < 8) begin
				cif.daddr = {ht[row_trunc].left_tag, row_trunc, 3'b000};
				cif.dstore = ht[row_trunc].left_data1;
			end else begin
				cif.daddr = {ht[row_trunc].right_tag, row_trunc, 3'b000};
				cif.dstore = ht[row_trunc].right_data1;
			end
		end
		FLUSH2 : begin
			cif.dWEN = 1;
			if(row - 1 < 8) begin
				cif.daddr = {ht[row_trunc].left_tag, row_trunc, 3'b100};
				cif.dstore = ht[row_trunc].left_data2;
			end else begin
				cif.daddr = {ht[row_trunc].right_tag, row_trunc, 3'b100};
				cif.dstore = ht[row_trunc].right_data2;
			end
		end
		CNT : begin
			cif.dWEN = 1;
			cif.daddr = 32'h00003100;
			cif.dstore = hit_count; 
		end
		CHK : begin
			next_snoophitL = snooptag == ht[snoopind].left_tag;
			next_snoophitR = snooptag == ht[snoopind].right_tag;

			if(next_snoophitL) snoopdirty = ht[snoopind].left_dirty;
			if(next_snoophitR) snoopdirty = ht[snoopind].right_dirty;

			//dirty? share the data if the other is doing a lw
			//dirty? invalidate the data if the other is doing a sw,
				//However, since we go thru LD1, LD2 as well
				//make the data share first, then invalid
			if(cif.ccinv && ~snoopdirty) begin
				if(next_snoophitL) begin
					sleft_valid = 0;
					sleft_dirty = 0;
					sleft_tag = 0;
					sleft_data1 = 0;
					sleft_data2 = 0;
				end
				if(next_snoophitR) begin
					sright_valid = 0;
					sright_dirty = 0;
					sright_tag = 0;
					sright_data1 = 0;
					sright_data2 = 0;
				end
			end
		end
		SHARE1 : begin
			//cif.cctrans = 1;
			if(snoophitL) begin
				cif.daddr = {ht[snoopind].left_tag, snoopind, 3'b000};
				cif.dstore = ht[snoopind].left_data1;
				sleft_dirty = 0;
			end else if(snoophitR) begin
				cif.daddr = {ht[snoopind].right_tag, snoopind, 3'b000};
				cif.dstore = ht[snoopind].right_data1;
				sright_dirty = 0;
			end
		end
		SHARE2 : begin
			//cif.cctrans = 1;
			if(snoophitL) begin
				cif.daddr = {ht[snoopind].left_tag, snoopind, 3'b100};
				cif.dstore = ht[snoopind].left_data2;
				sleft_dirty = 0;
			end else if(snoophitR) begin
				cif.daddr = {ht[snoopind].right_tag, snoopind, 3'b100};
				cif.dstore = ht[snoopind].right_data2;
				sright_dirty = 0;
			end
		end
		INVALID: begin
			if(cif.ccinv) begin
				if(snoophitL) begin
					sleft_valid = 0;
					sleft_dirty = 0;
					sleft_tag = 0;
					sleft_data1 = 0;
					sleft_data2 = 0;
				end
				if(snoophitR) begin
					sright_valid = 0;
					sright_dirty = 0;
					sright_tag = 0;
					sright_data1 = 0;
					sright_data2 = 0;
				end
			end
		end
	endcase // state
end

endmodule // dcache
