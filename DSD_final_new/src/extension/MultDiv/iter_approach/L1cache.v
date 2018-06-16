module L1cache(
    clk,
    proc_reset,
    proc_read,
    proc_write,
    proc_addr,
    proc_wdata,
    proc_stall,
    proc_rdata,
    mem_read,
    mem_write,
    mem_addr,
    mem_rdata,
    mem_wdata,
    mem_ready
);	// output improvement
    

	//parameter BLOCK_SIZE = 128;
	//parameter TAG_SIZE = 25;

	//parameter BLOCK_NUM = 8;
//==== input/output definition ============================
    input          clk;
    // processor interface
    input          proc_reset;
    input          proc_read, proc_write;
    input   [29:0] proc_addr;
    input   [31:0] proc_wdata;
    output         proc_stall;
    output reg [31:0] proc_rdata;
    // memory interface
    input  [127:0] mem_rdata;
    input          mem_ready;
    output 	       mem_read, mem_write;
    output  [27:0] mem_addr;
    output  [127:0] mem_wdata;
    
//==== wire/reg definition ================================

	reg [127:0] block;
	reg [127:0] block_save [7:0] ;
	reg [127:0] data; 	//cache
	reg [7:0] valid_save,dirty_save;
	reg valid,dirty;
	reg [24:0] tag;
	reg [24:0] tag_save [7:0];

	reg [1:0] state, next_state;

	wire [2:0] index;
	wire hit;

	integer i;
	integer counter, next_counter, miss, next_miss;    


    
//==== combinational circuit ==============================


	assign index = proc_addr[4:2];
	assign hit = valid && (proc_addr[29:5] == tag);


	always @(*) begin	//for state
	next_counter = counter;
	next_miss = miss;
		case(state) 
			2'b00:begin 	//Read or Write
				if((proc_read||proc_write)) begin
					next_counter = counter +1;
					case({hit,dirty})
					2'b00: begin next_state = 2'b10; next_miss = miss +1; end
					2'b01: begin next_state = 2'b11; next_miss = miss +1;end
					2'b10: begin next_state = 2'b00; next_miss = miss;end
					2'b11: begin next_state = 2'b00; next_miss = miss;end
					endcase
				end
				else begin
					next_counter = counter;
					next_miss = miss;
					next_state = 2'b00;
				end
			end

			2'b01:begin
				next_counter = counter;
				next_miss = miss;
				next_state = 2'b00;
			end

			2'b10:begin	//Write 4-word data from memory to cache
			next_counter = counter;
				next_miss = miss;
				if(mem_ready) begin
					next_state = 2'b00;
				end
				else begin
					next_state = 2'b10;
				end
			end
			2'b11:begin	//Write back
			next_counter = counter;
	next_miss = miss;
				if(mem_ready) begin
					next_state = 2'b10;
				end
				else begin
					next_state = 2'b11;
				end
			end
		endcase
	end

	always @(*) begin //for output
		case(proc_addr[1:0])
			2'd0: proc_rdata = block[31:0];
			2'd1: proc_rdata = block[63:32];
			2'd2: proc_rdata = block[95:64];
			2'd3: proc_rdata = block[127:96];
		endcase
	end

	assign proc_stall = (~hit || state[1]) && (proc_read||proc_write);
	assign mem_wdata = block;
	assign mem_addr = state[0] ? {tag, index}:proc_addr[29:2];
	assign mem_read = state[1] && ~state[0];
	assign mem_write = state[1] && state [0];


	always @(*)begin	//to write data to cache
			valid = valid_save[index];
			dirty = dirty_save[index];
			block = block_save[index];
			tag = tag_save[index];
			

			if(hit) begin
				if(~state[1] && ~state[0] && proc_write) begin
					dirty = 1'b1;
					case(proc_addr[1:0])
					2'd0: block[31:0] = proc_wdata; 
					2'd1: block[63:32] = proc_wdata; 
					2'd2: block[95:64] = proc_wdata; 
					2'd3: block[127:96] = proc_wdata; 
					endcase
				end
			end
		

			if(state[1] && ~state[0]) begin
			valid = 1'b1;
			tag = proc_addr[29:5];
			dirty = 1'b0;
			block = mem_rdata;
			end
	end

//==== sequential circuit =================================
	always@( posedge clk or posedge proc_reset ) begin
	    if( proc_reset ) begin
	    	state <= 2'b00;
			valid_save <= 8'b0;
			dirty_save <= 8'b0; 
			miss <= 0;
			counter <= 0;

			for(i = 0; i <8; i = i+1) begin
			tag_save[i] <= 25'b0;  
			block_save[i] <= 128'b0;
			end
		end
	    else begin
	    	state <= next_state;
	    	miss <= next_miss;
	    	counter <= next_counter;
			valid_save[index] <= valid;
			dirty_save[index] <= dirty;
			tag_save[index] <= tag;
			block_save[index] <= block;

	    end
	end


endmodule
