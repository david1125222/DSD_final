module L2cache(
    clk,
    proc_reset,
    Icache_read,
    Icache_write,
    Icache_addr,
    Icache_wdata,
    Icache_ready,
    Icache_rdata,
    Dcache_read,
    Dcache_write,
    Dcache_addr,
    Dcache_wdata,
    Dcache_ready,
    Dcache_rdata,

    Imem_read,
    Imem_write,
    Imem_addr,
    Imem_rdata,
    Imem_wdata,
    Imem_ready,
    Dmem_read,
    Dmem_write,
    Dmem_addr,
    Dmem_rdata,
    Dmem_wdata,
    Dmem_ready
);	// output improvement
    
	parameter BLOCK_SIZE = 128;
	parameter TAG_SIZE = 22;

	parameter BLOCK_NUM = 64;

	parameter IDLE = 3'd0;
	parameter I_WRITE = 3'd1;
	parameter I_FROMMEM = 3'd2;
	parameter I_READY = 3'd3;
	parameter D_WRITE = 3'd4;
	parameter D_FROMMEM = 3'd5;
	parameter D_READY = 3'd6;

//==== input/output definition ============================
    // processor interface
    input          clk;
    input		   proc_reset;
    input 		   Icache_read;
    input 		   Icache_write;
    input	[27:0] Icache_addr;
    input 	[127:0] Icache_wdata;
    output 		   Icache_ready;
    output  [127:0] Icache_rdata;

    input 		   Dcache_read;
    input 		   Dcache_write;
    input	[27:0] Dcache_addr;
    input 	[127:0] Dcache_wdata;
    output 		   Dcache_ready;
    output  [127:0] Dcache_rdata;

    // memory interface
    output			Imem_read;
    output 			Imem_write;
    input 			Imem_ready;
    input  [127:0]  Imem_rdata;
    output [27:0]	Imem_addr;
    output [127:0]  Imem_wdata;

    output 			Dmem_read;
    output 			Dmem_write;
    input 			Dmem_ready;
    input  [127:0]  Dmem_rdata;    
    output 	[27:0]	Dmem_addr;
    output [127:0]  Dmem_wdata;
    
   
    
//==== wire/reg definition ================================

	reg [BLOCK_SIZE-1:0] block;
	reg  [BLOCK_SIZE-1:0]block_save[BLOCK_NUM-1:0] ;
	reg [BLOCK_SIZE-1:0] data; 	//cache
	reg [BLOCK_NUM-1:0] valid_save, type_save;
	reg valid, type;
	reg [TAG_SIZE-1:0] tag;
	reg [TAG_SIZE-1:0] tag_save [BLOCK_NUM-1:0];

	reg [2:0] state, next_state;

	wire [5:0] I_index, D_index, index;

	wire I_hit, D_hit;

	integer i;
	integer counter, next_counter, miss, next_miss;    


    // type  0 => Instruction, type 1 => data
//==== combinational circuit ==============================


	assign I_index = Icache_addr[5:0];
	assign D_index = Dcache_addr[5:0];

	assign I_hit = valid && (tag == Icache_addr[27:6]) && ~type;
	assign D_hit = valid && (tag == Dcache_addr[27:6]) && type;

	assign Icache_rdata = block;
	assign Dcache_rdata = block;

	assign Imem_wdata = 128'b0;
	assign Dmem_wdata = block;

	assign Imem_addr = Icache_addr;
	assign Dmem_addr = Dcache_addr;

	assign Icache_ready = ~state[2] && state[1] && state[0];
	assign Dcache_ready = state[2] && state[1] && ~state[0];


	assign Imem_read = ~state[2] && state[1] && ~state[0];
	assign Imem_write = 1'b0;
	assign Dmem_read = state[2] && ~state[1] && state[0];
	assign Dmem_write = state[2] && ~state[1] && ~state[0];

	assign index = (Dcache_read ||Dcache_write)? D_index: I_index;

	

	always @(*) begin

		case(state)
			IDLE: begin
				case({Icache_read, Icache_write, Dcache_read, Dcache_write})
				4'b1000: begin 
							next_counter = counter + 1;
							if(I_hit) begin
							next_miss = miss;
							next_state = I_READY;
							end
							else begin
							next_state = I_FROMMEM;
							next_miss = miss +1;
						end
						end
				4'b0100: begin next_state = IDLE; 
								next_counter = counter+1;
								next_miss = miss; end
				4'b0010: begin 
							next_counter = counter + 1;
							if(D_hit) begin
							next_state = D_READY;
							next_miss = miss;
							end
							else begin
							next_state = D_FROMMEM;
							next_miss = miss +1;
							end
						end
				4'b0001: begin 
							next_counter = counter + 1;
							if(D_hit) begin
							next_miss = miss;
							next_state = D_WRITE;
							end
							else begin
							next_miss = miss+1;
							next_state = D_FROMMEM;
							end
						end
				4'b1010: begin 
							next_counter = counter +1;
							if(I_hit) begin
							next_state = I_READY;
							next_miss = miss;
							end
							else begin
							next_state = I_FROMMEM;
							next_miss = miss +1;
							end
						end
				4'b1001: begin 
							next_counter = counter +1;
							if(I_hit) begin
							next_state = I_READY;
							next_miss = miss;
							end
							else begin
							next_state = I_FROMMEM;
							next_miss = miss +1;
							end
				end
				default: begin next_state = IDLE; next_miss = miss; next_counter = counter; end
				endcase
			end

			I_WRITE: begin 
			next_counter = counter;
			next_miss = miss;
				if(Imem_ready)
					next_state = I_READY;
				else
					next_state = I_WRITE;
			end

			I_FROMMEM:begin
			next_counter = counter;
	next_miss = miss;
				if(Imem_ready) begin
					if(Icache_read)
						next_state = I_READY;
					else 
						next_state = I_WRITE;
				end
				else
					next_state = I_FROMMEM;
			end
			I_READY: begin next_counter = counter;
	next_miss = miss; 
	next_state = IDLE;
	end

			D_WRITE: begin 
			next_counter = counter;
	next_miss = miss;
				if(Dmem_ready)
					next_state = D_READY;
				else
					next_state = D_WRITE;
			end

			D_FROMMEM:begin
			next_counter = counter;
	next_miss = miss;
				if(Dmem_ready) begin
					if(Dcache_read)
						next_state = D_READY;
					else 
						next_state = D_WRITE;
				end
				else
					next_state = D_FROMMEM;
			end
			D_READY: begin next_state = IDLE; next_counter = counter;
	next_miss = miss; end

			default: begin next_counter = counter;
	next_miss = miss;
				next_state = IDLE;
				end
		endcase
	end

	always @(*) begin	
		valid = valid_save[index];
		type = type_save[index];
		tag = tag_save[index];
		block = block_save[index];

		case(state)
		I_WRITE:begin
					valid = 1'b1;
					type = 1'b0;
					tag = Icache_addr[27:6];
					block = Icache_wdata;
		end
		I_FROMMEM:	begin
					valid = 1'b1;
					type = 1'b0;
					tag = Icache_addr[27:6];
					block = Imem_rdata;
		end
		D_WRITE:begin
					valid = 1'b1;
					type = 1'b1;
					tag = Dcache_addr[27:6];
					block = Dcache_wdata;
		end
		D_FROMMEM:begin
					valid = 1'b1;
					type = 1'b1;
					tag = Dcache_addr[27:6];
					block = Dmem_rdata;
		end
		endcase
	end





//==== sequential circuit =================================
	always@( posedge clk or posedge proc_reset ) begin
	    if( proc_reset ) begin
	    	state <= 3'b00;
			valid_save <= 63'b0;
			type_save <= 63'b0;
			miss <= 0;
			counter <= 0;
			for(i = 0; i <BLOCK_NUM; i = i+1) begin
			tag_save[i] <= 22'b0;  
			block_save[i] <= 128'b0;
			end
		end
	    else begin
	    	miss <= next_miss;
	    	counter <= next_counter;
	    	state <= next_state;
	    	type_save[index] <= type;
			valid_save[index] <= valid;
			tag_save[index] <= tag;
			block_save[index] <= block;

	    end
	end


endmodule


/*
	always @(*) begin	//for state
		case(state) 
			2'b00:begin 	//Read or Write
				case({(valid && (proc_addr[29:5] == tag)),dirty})
				2'b00: next_state = 2'b10;
				2'b01: next_state = 2'b11;
				2'b10: next_state = 2'b00;
				2'b11: next_state = 2'b00;
				endcase
			end
			2'b01:begin
				next_state = 2'b00;
			end
			2'b10:begin	//Write 4-word data from memory to cache
				if(mem_ready) begin
					next_state = 2'b00;
				end
				else begin
					next_state = 2'b10;
				end
			end
			2'b11:begin	//Write back
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
	assign proc_stall =  ~valid || ~(proc_addr[29:5] == tag ) || state[1];
	assign mem_wdata = block;
	assign mem_addr = state[0] ? {tag, index}:proc_addr[29:2];
	assign mem_read = state[1] && ~state[0];
	assign mem_write = state[1] && state [0];
	always @(*)begin	//to write data to cache
			valid = valid_save[index];
			dirty = dirty_save[index];
			block = block_save[index];
			tag = tag_save[index];
			
		case(state) 
		2'b00:begin
			if(proc_write && valid && (proc_addr[29:5] == tag )) begin
				dirty = 1'b1;
				valid = 1'b1;
				case(proc_addr[1:0])
				2'd0: block[31:0] = proc_wdata; 
				2'd1: block[63:32] = proc_wdata; 
				2'd2: block[95:64] = proc_wdata; 
				2'd3: block[127:96] = proc_wdata; 
				endcase
			end
		end
		
		2'b10:begin
			valid = 1'b1;
			tag = proc_addr[29:5];
			dirty = 1'b0;
			block = mem_rdata;
		end
	
		endcase
	
	end
*/