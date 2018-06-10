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
	parameter TAG_SIZE = 28;

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
	reg [5:0] ref [63:0];
	reg [5:0] ref_save [63:0];

	wire [27:0] addr;

	//wire [5:0] I_index, D_index, index;

	//wire I_hit, D_hit;
	reg hit;
	wire type_hit;

	reg [5:0] index;

	integer i;
	integer counter, next_counter, miss, next_miss;    


    // type  0 => Instruction, type 1 => data
//==== combinational circuit ==============================


		//	assign I_index = Imem_addr[5:0];
		//	assign D_index = Dmem_addr[5:0];

	//assign I_hit = valid && (tag == Icache_addr[27:0]) && ~type;
	//assign D_hit = valid && (tag == Dcache_addr[27:0]) && type;

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

	assign addr = (Dcache_read || Dcache_write)? Dcache_addr:Icache_addr;
	assign type_hit = (Icache_read || Icache_write)? 1'b0: 1'b1;

	//assign index = (state[2])? D_index: I_index;

	always @(*) begin
		index = 6'd0;

			 if(valid_save[0]  && (addr == tag_save[0] ) &&(type_hit==type_save[0] )) begin index = 6'd0; hit = 1'b1; end
		else if(valid_save[1]  && (addr == tag_save[1] ) &&(type_hit==type_save[1] )) begin index = 6'd1; hit = 1'b1; end
		else if(valid_save[2]  && (addr == tag_save[2] ) &&(type_hit==type_save[2] )) begin index = 6'd2; hit = 1'b1; end
		else if(valid_save[3]  && (addr == tag_save[3] ) &&(type_hit==type_save[3] )) begin index = 6'd3; hit = 1'b1; end
		else if(valid_save[4]  && (addr == tag_save[4] ) &&(type_hit==type_save[4] )) begin index = 6'd4; hit = 1'b1; end
		else if(valid_save[5]  && (addr == tag_save[5] ) &&(type_hit==type_save[5] )) begin index = 6'd5; hit = 1'b1; end
		else if(valid_save[6]  && (addr == tag_save[6] ) &&(type_hit==type_save[6] )) begin index = 6'd6; hit = 1'b1; end
		else if(valid_save[7]  && (addr == tag_save[7] ) &&(type_hit==type_save[7] )) begin index = 6'd7; hit = 1'b1; end
		else if(valid_save[8]  && (addr == tag_save[8] ) &&(type_hit==type_save[8] )) begin index = 6'd8; hit = 1'b1; end
		else if(valid_save[9]  && (addr == tag_save[9] ) &&(type_hit==type_save[9] )) begin index = 6'd9; hit = 1'b1; end
		else if(valid_save[10] && (addr == tag_save[10]) &&(type_hit==type_save[10])) begin index = 6'd10; hit = 1'b1; end
		else if(valid_save[11] && (addr == tag_save[11]) &&(type_hit==type_save[11])) begin index = 6'd11; hit = 1'b1; end
		else if(valid_save[12] && (addr == tag_save[12]) &&(type_hit==type_save[12])) begin index = 6'd12; hit = 1'b1; end
		else if(valid_save[13] && (addr == tag_save[13]) &&(type_hit==type_save[13])) begin index = 6'd13; hit = 1'b1; end
		else if(valid_save[14] && (addr == tag_save[14]) &&(type_hit==type_save[14])) begin index = 6'd14; hit = 1'b1; end
		else if(valid_save[15] && (addr == tag_save[15]) &&(type_hit==type_save[15])) begin index = 6'd15; hit = 1'b1; end
		else if(valid_save[16] && (addr == tag_save[16]) &&(type_hit==type_save[16])) begin index = 6'd16; hit = 1'b1; end
		else if(valid_save[17] && (addr == tag_save[17]) &&(type_hit==type_save[17])) begin index = 6'd17; hit = 1'b1; end
		else if(valid_save[18] && (addr == tag_save[18]) &&(type_hit==type_save[18])) begin index = 6'd18; hit = 1'b1; end
		else if(valid_save[19] && (addr == tag_save[19]) &&(type_hit==type_save[19])) begin index = 6'd19; hit = 1'b1; end
		else if(valid_save[20] && (addr == tag_save[20]) &&(type_hit==type_save[20])) begin index = 6'd20; hit = 1'b1; end
		else if(valid_save[21] && (addr == tag_save[21]) &&(type_hit==type_save[21])) begin index = 6'd21; hit = 1'b1; end
		else if(valid_save[22] && (addr == tag_save[22]) &&(type_hit==type_save[22])) begin index = 6'd22; hit = 1'b1; end
		else if(valid_save[23] && (addr == tag_save[23]) &&(type_hit==type_save[23])) begin index = 6'd23; hit = 1'b1; end
		else if(valid_save[24] && (addr == tag_save[24]) &&(type_hit==type_save[24])) begin index = 6'd24; hit = 1'b1; end
		else if(valid_save[25] && (addr == tag_save[25]) &&(type_hit==type_save[25])) begin index = 6'd25; hit = 1'b1; end
		else if(valid_save[26] && (addr == tag_save[26]) &&(type_hit==type_save[26])) begin index = 6'd26; hit = 1'b1; end
		else if(valid_save[27] && (addr == tag_save[27]) &&(type_hit==type_save[27])) begin index = 6'd27; hit = 1'b1; end
		else if(valid_save[28] && (addr == tag_save[28]) &&(type_hit==type_save[28])) begin index = 6'd28; hit = 1'b1; end
		else if(valid_save[29] && (addr == tag_save[29]) &&(type_hit==type_save[29])) begin index = 6'd29; hit = 1'b1; end
		else if(valid_save[30] && (addr == tag_save[30]) &&(type_hit==type_save[30])) begin index = 6'd30; hit = 1'b1; end
		else if(valid_save[31] && (addr == tag_save[31]) &&(type_hit==type_save[31])) begin index = 6'd31; hit = 1'b1; end
		else if(valid_save[32] && (addr == tag_save[32]) &&(type_hit==type_save[32])) begin index = 6'd32; hit = 1'b1; end
		else if(valid_save[33] && (addr == tag_save[33]) &&(type_hit==type_save[33])) begin index = 6'd33; hit = 1'b1; end
		else if(valid_save[34] && (addr == tag_save[34]) &&(type_hit==type_save[34])) begin index = 6'd34; hit = 1'b1; end
		else if(valid_save[35] && (addr == tag_save[35]) &&(type_hit==type_save[35])) begin index = 6'd35; hit = 1'b1; end
		else if(valid_save[36] && (addr == tag_save[36]) &&(type_hit==type_save[36])) begin index = 6'd36; hit = 1'b1; end
		else if(valid_save[37] && (addr == tag_save[37]) &&(type_hit==type_save[37])) begin index = 6'd37; hit = 1'b1; end
		else if(valid_save[38] && (addr == tag_save[38]) &&(type_hit==type_save[38])) begin index = 6'd38; hit = 1'b1; end
		else if(valid_save[39] && (addr == tag_save[39]) &&(type_hit==type_save[39])) begin index = 6'd39; hit = 1'b1; end
		else if(valid_save[40] && (addr == tag_save[40]) &&(type_hit==type_save[40])) begin index = 6'd40; hit = 1'b1; end
		else if(valid_save[41] && (addr == tag_save[41]) &&(type_hit==type_save[41])) begin index = 6'd41; hit = 1'b1; end
		else if(valid_save[42] && (addr == tag_save[42]) &&(type_hit==type_save[42])) begin index = 6'd42; hit = 1'b1; end
		else if(valid_save[43] && (addr == tag_save[43]) &&(type_hit==type_save[43])) begin index = 6'd43; hit = 1'b1; end
		else if(valid_save[44] && (addr == tag_save[44]) &&(type_hit==type_save[44])) begin index = 6'd44; hit = 1'b1; end
		else if(valid_save[45] && (addr == tag_save[45]) &&(type_hit==type_save[45])) begin index = 6'd45; hit = 1'b1; end
		else if(valid_save[46] && (addr == tag_save[46]) &&(type_hit==type_save[46])) begin index = 6'd46; hit = 1'b1; end
		else if(valid_save[47] && (addr == tag_save[47]) &&(type_hit==type_save[47])) begin index = 6'd47; hit = 1'b1; end
		else if(valid_save[48] && (addr == tag_save[48]) &&(type_hit==type_save[48])) begin index = 6'd48; hit = 1'b1; end
		else if(valid_save[49] && (addr == tag_save[49]) &&(type_hit==type_save[49])) begin index = 6'd49; hit = 1'b1; end
		else if(valid_save[50] && (addr == tag_save[50]) &&(type_hit==type_save[50])) begin index = 6'd50; hit = 1'b1; end
		else if(valid_save[51] && (addr == tag_save[51]) &&(type_hit==type_save[51])) begin index = 6'd51; hit = 1'b1; end
		else if(valid_save[52] && (addr == tag_save[52]) &&(type_hit==type_save[52])) begin index = 6'd52; hit = 1'b1; end
		else if(valid_save[53] && (addr == tag_save[53]) &&(type_hit==type_save[53])) begin index = 6'd53; hit = 1'b1; end
		else if(valid_save[54] && (addr == tag_save[54]) &&(type_hit==type_save[54])) begin index = 6'd54; hit = 1'b1; end
		else if(valid_save[55] && (addr == tag_save[55]) &&(type_hit==type_save[55])) begin index = 6'd55; hit = 1'b1; end
		else if(valid_save[56] && (addr == tag_save[56]) &&(type_hit==type_save[56])) begin index = 6'd56; hit = 1'b1; end
		else if(valid_save[57] && (addr == tag_save[57]) &&(type_hit==type_save[57])) begin index = 6'd57; hit = 1'b1; end
		else if(valid_save[58] && (addr == tag_save[58]) &&(type_hit==type_save[58])) begin index = 6'd58; hit = 1'b1; end
		else if(valid_save[59] && (addr == tag_save[59]) &&(type_hit==type_save[59])) begin index = 6'd59; hit = 1'b1; end
		else if(valid_save[60] && (addr == tag_save[60]) &&(type_hit==type_save[60])) begin index = 6'd60; hit = 1'b1; end
		else if(valid_save[61] && (addr == tag_save[61]) &&(type_hit==type_save[61])) begin index = 6'd61; hit = 1'b1; end
		else if(valid_save[62] && (addr == tag_save[62]) &&(type_hit==type_save[62])) begin index = 6'd62; hit = 1'b1; end
		else if(valid_save[63] && (addr == tag_save[63]) &&(type_hit==type_save[63])) begin index = 6'd63; hit = 1'b1; end

		else if(~valid_save[0] ) begin index = 6'd0; hit = 1'b0; end
		else if(~valid_save[1] ) begin index = 6'd1; hit = 1'b0;end
		else if(~valid_save[2] ) begin index = 6'd2; hit = 1'b0;end
		else if(~valid_save[3] ) begin index = 6'd3; hit = 1'b0;end
		else if(~valid_save[4] ) begin index = 6'd4; hit = 1'b0;end
		else if(~valid_save[5] ) begin index = 6'd5; hit = 1'b0;end
		else if(~valid_save[6] ) begin index = 6'd6; hit = 1'b0;end
		else if(~valid_save[7] ) begin index = 6'd7; hit = 1'b0;end
		else if(~valid_save[8] ) begin index = 6'd8; hit = 1'b0;end
		else if(~valid_save[9] ) begin index = 6'd9; hit = 1'b0;end
		else if(~valid_save[10]) begin index = 6'd10; hit = 1'b0; end
		else if(~valid_save[11]) begin index = 6'd11; hit = 1'b0; end
		else if(~valid_save[12]) begin index = 6'd12; hit = 1'b0; end
		else if(~valid_save[13]) begin index = 6'd13; hit = 1'b0; end
		else if(~valid_save[14]) begin index = 6'd14; hit = 1'b0; end
		else if(~valid_save[15]) begin index = 6'd15; hit = 1'b0; end
		else if(~valid_save[16]) begin index = 6'd16; hit = 1'b0; end
		else if(~valid_save[17]) begin index = 6'd17; hit = 1'b0; end
		else if(~valid_save[18]) begin index = 6'd18; hit = 1'b0; end
		else if(~valid_save[19]) begin index = 6'd19; hit = 1'b0; end
		else if(~valid_save[20]) begin index = 6'd20; hit = 1'b0; end
		else if(~valid_save[21]) begin index = 6'd21; hit = 1'b0; end
		else if(~valid_save[22]) begin index = 6'd22; hit = 1'b0; end
		else if(~valid_save[23]) begin index = 6'd23; hit = 1'b0; end
		else if(~valid_save[24]) begin index = 6'd24; hit = 1'b0; end
		else if(~valid_save[25]) begin index = 6'd25; hit = 1'b0; end
		else if(~valid_save[26]) begin index = 6'd26; hit = 1'b0; end
		else if(~valid_save[27]) begin index = 6'd27; hit = 1'b0; end
		else if(~valid_save[28]) begin index = 6'd28; hit = 1'b0; end
		else if(~valid_save[29]) begin index = 6'd29; hit = 1'b0; end
		else if(~valid_save[30]) begin index = 6'd30; hit = 1'b0; end
		else if(~valid_save[31]) begin index = 6'd31; hit = 1'b0; end
		else if(~valid_save[32]) begin index = 6'd32; hit = 1'b0; end
		else if(~valid_save[33]) begin index = 6'd33; hit = 1'b0; end
		else if(~valid_save[34]) begin index = 6'd34; hit = 1'b0; end
		else if(~valid_save[35]) begin index = 6'd35; hit = 1'b0; end
		else if(~valid_save[36]) begin index = 6'd36; hit = 1'b0; end
		else if(~valid_save[37]) begin index = 6'd37; hit = 1'b0; end
		else if(~valid_save[38]) begin index = 6'd38; hit = 1'b0; end
		else if(~valid_save[39]) begin index = 6'd39; hit = 1'b0; end
		else if(~valid_save[40]) begin index = 6'd40; hit = 1'b0; end
		else if(~valid_save[41]) begin index = 6'd41; hit = 1'b0; end
		else if(~valid_save[42]) begin index = 6'd42; hit = 1'b0; end
		else if(~valid_save[43]) begin index = 6'd43; hit = 1'b0; end
		else if(~valid_save[44]) begin index = 6'd44; hit = 1'b0; end
		else if(~valid_save[45]) begin index = 6'd45; hit = 1'b0; end
		else if(~valid_save[46]) begin index = 6'd46; hit = 1'b0; end
		else if(~valid_save[47]) begin index = 6'd47; hit = 1'b0; end
		else if(~valid_save[48]) begin index = 6'd48; hit = 1'b0; end
		else if(~valid_save[49]) begin index = 6'd49; hit = 1'b0; end
		else if(~valid_save[50]) begin index = 6'd50; hit = 1'b0; end
		else if(~valid_save[51]) begin index = 6'd51; hit = 1'b0; end
		else if(~valid_save[52]) begin index = 6'd52; hit = 1'b0; end
		else if(~valid_save[53]) begin index = 6'd53; hit = 1'b0; end
		else if(~valid_save[54]) begin index = 6'd54; hit = 1'b0; end
		else if(~valid_save[55]) begin index = 6'd55; hit = 1'b0; end
		else if(~valid_save[56]) begin index = 6'd56; hit = 1'b0; end
		else if(~valid_save[57]) begin index = 6'd57; hit = 1'b0; end
		else if(~valid_save[58]) begin index = 6'd58; hit = 1'b0; end
		else if(~valid_save[59]) begin index = 6'd59; hit = 1'b0; end
		else if(~valid_save[60]) begin index = 6'd60; hit = 1'b0; end
		else if(~valid_save[61]) begin index = 6'd61; hit = 1'b0; end
		else if(~valid_save[62]) begin index = 6'd62; hit = 1'b0; end
		else if(~valid_save[63]) begin index = 6'd63; hit = 1'b0; end
		else begin index = ref_save[0]; hit = 1'b0; end
	end


/*
		case(1'b0) 
		valid_save[0] : index = 6'd0;
		valid_save[1] : index = 6'd1;
		valid_save[2] : index = 6'd2;
		valid_save[3] : index = 6'd3;
		valid_save[4] : index = 6'd4;
		valid_save[5] : index = 6'd5;
		valid_save[6] : index = 6'd6;
		valid_save[7] : index = 6'd7;
		valid_save[8] : index = 6'd8;
		valid_save[9] : index = 6'd9;
		valid_save[10]: index = 6'd10;
		valid_save[11]: index = 6'd11;
		valid_save[12]: index = 6'd12;
		valid_save[13]: index = 6'd13;
		valid_save[14]: index = 6'd14;
		valid_save[15]: index = 6'd15;
		valid_save[16]: index = 6'd16;
		valid_save[17]: index = 6'd17;
		valid_save[18]: index = 6'd18;
		valid_save[19]: index = 6'd19;
		valid_save[20]: index = 6'd20;
		valid_save[21]: index = 6'd21;
		valid_save[22]: index = 6'd22;
		valid_save[23]: index = 6'd23;
		valid_save[24]: index = 6'd24;
		valid_save[25]: index = 6'd25;
		valid_save[26]: index = 6'd26;
		valid_save[27]: index = 6'd27;
		valid_save[28]: index = 6'd28;
		valid_save[29]: index = 6'd29;
		valid_save[30]: index = 6'd30;
		valid_save[31]: index = 6'd31;
		valid_save[32]: index = 6'd32;
		valid_save[33]: index = 6'd33;
		valid_save[34]: index = 6'd34;
		valid_save[35]: index = 6'd35;
		valid_save[36]: index = 6'd36;
		valid_save[37]: index = 6'd37;
		valid_save[38]: index = 6'd38;
		valid_save[39]: index = 6'd39;
		valid_save[40]: index = 6'd40;
		valid_save[41]: index = 6'd41;
		valid_save[42]: index = 6'd42;
		valid_save[43]: index = 6'd43;
		valid_save[44]: index = 6'd44;
		valid_save[45]: index = 6'd45;
		valid_save[46]: index = 6'd46;
		valid_save[47]: index = 6'd47;
		valid_save[48]: index = 6'd48;
		valid_save[49]: index = 6'd49;
		valid_save[50]: index = 6'd50;
		valid_save[51]: index = 6'd51;
		valid_save[52]: index = 6'd52;
		valid_save[53]: index = 6'd53;
		valid_save[54]: index = 6'd54;
		valid_save[55]: index = 6'd55;
		valid_save[56]: index = 6'd56;
		valid_save[57]: index = 6'd57;
		valid_save[58]: index = 6'd58;
		valid_save[59]: index = 6'd59;
		valid_save[60]: index = 6'd60;
		valid_save[61]: index = 6'd61;
		valid_save[62]: index = 6'd62;
		valid_save[63]: index = 6'd63;
		default: index = ref_save[0];	
endcase */
	
		

/*
		  if(~valid_save[0] || ~|ref_save[0]) index = 6'd0;
		  if(~valid_save[1] || ~|ref_save[1]) index = 6'd1;
		  if(~valid_save[2] || ~|ref_save[2]) index = 6'd2;
		  if(~valid_save[3] || ~|ref_save[3]) index = 6'd3;
		  if(~valid_save[4] || ~|ref_save[4]) index = 6'd4;
		  if(~valid_save[5] || ~|ref_save[5]) index = 6'd5;
		  if(~valid_save[6] || ~|ref_save[6]) index = 6'd6;
		  if(~valid_save[7] || ~|ref_save[7]) index = 6'd7;
		  if(~valid_save[8] || ~|ref_save[8]) index = 6'd8;
		  if(~valid_save[9] || ~|ref_save[9]) index = 6'd9;
		  if(~valid_save[10] || ~|ref_save[10]) index = 6'd10;
		  if(~valid_save[11] || ~|ref_save[11]) index = 6'd11;
		  if(~valid_save[12] || ~|ref_save[12]) index = 6'd12;
		  if(~valid_save[13] || ~|ref_save[13]) index = 6'd13;
		  if(~valid_save[14] || ~|ref_save[14]) index = 6'd14;
		  if(~valid_save[15] || ~|ref_save[15]) index = 6'd15;
		  if(~valid_save[16] || ~|ref_save[16]) index = 6'd16;
		  if(~valid_save[17] || ~|ref_save[17]) index = 6'd17;
		  if(~valid_save[18] || ~|ref_save[18]) index = 6'd18;
		  if(~valid_save[19] || ~|ref_save[19]) index = 6'd19;
		  if(~valid_save[20] || ~|ref_save[20]) index = 6'd20;
		  if(~valid_save[21] || ~|ref_save[21]) index = 6'd21;
		  if(~valid_save[22] || ~|ref_save[22]) index = 6'd22;
		  if(~valid_save[23] || ~|ref_save[23]) index = 6'd23;
		  if(~valid_save[24] || ~|ref_save[24]) index = 6'd24;
		  if(~valid_save[25] || ~|ref_save[25]) index = 6'd25;
		  if(~valid_save[26] || ~|ref_save[26]) index = 6'd26;
		  if(~valid_save[27] || ~|ref_save[27]) index = 6'd27;
		  if(~valid_save[28] || ~|ref_save[28]) index = 6'd28;
		  if(~valid_save[29] || ~|ref_save[29]) index = 6'd29;
		  if(~valid_save[30] || ~|ref_save[30]) index = 6'd30;
		  if(~valid_save[31] || ~|ref_save[31]) index = 6'd31;
		  if(~valid_save[32] || ~|ref_save[32]) index = 6'd32;
		  if(~valid_save[33] || ~|ref_save[33]) index = 6'd33;
		  if(~valid_save[34] || ~|ref_save[34]) index = 6'd34;
		  if(~valid_save[35] || ~|ref_save[35]) index = 6'd35;
		  if(~valid_save[36] || ~|ref_save[36]) index = 6'd36;
		  if(~valid_save[37] || ~|ref_save[37]) index = 6'd37;
		  if(~valid_save[38] || ~|ref_save[38]) index = 6'd38;
		  if(~valid_save[39] || ~|ref_save[39]) index = 6'd39;
		  if(~valid_save[40] || ~|ref_save[40]) index = 6'd40;
		  if(~valid_save[41] || ~|ref_save[41]) index = 6'd41;
		  if(~valid_save[42] || ~|ref_save[42]) index = 6'd42;
		  if(~valid_save[43] || ~|ref_save[43]) index = 6'd43;
		  if(~valid_save[44] || ~|ref_save[44]) index = 6'd44;
		  if(~valid_save[45] || ~|ref_save[45]) index = 6'd45;
		  if(~valid_save[46] || ~|ref_save[46]) index = 6'd46;
		  if(~valid_save[47] || ~|ref_save[47]) index = 6'd47;
		  if(~valid_save[48] || ~|ref_save[48]) index = 6'd48;
		  if(~valid_save[49] || ~|ref_save[49]) index = 6'd49;
		  if(~valid_save[50] || ~|ref_save[50]) index = 6'd50;
		  if(~valid_save[51] || ~|ref_save[51]) index = 6'd51;
		  if(~valid_save[52] || ~|ref_save[52]) index = 6'd52;
		  if(~valid_save[53] || ~|ref_save[53]) index = 6'd53;
		  if(~valid_save[54] || ~|ref_save[54]) index = 6'd54;
		  if(~valid_save[55] || ~|ref_save[55]) index = 6'd55;
		  if(~valid_save[56] || ~|ref_save[56]) index = 6'd56;
		  if(~valid_save[57] || ~|ref_save[57]) index = 6'd57;
		  if(~valid_save[58] || ~|ref_save[58]) index = 6'd58;
		  if(~valid_save[59] || ~|ref_save[59]) index = 6'd59;
		  if(~valid_save[60] || ~|ref_save[60]) index = 6'd60;
		  if(~valid_save[61] || ~|ref_save[61]) index = 6'd61;
		  if(~valid_save[62] || ~|ref_save[62]) index = 6'd62;
		  if(~valid_save[63] || ~|ref_save[63]) index = 6'd63;
	end
*/


	always @(*) begin
		
		ref[0] 	= ref_save[0] ;
		ref[1] 	= ref_save[1] ;
		ref[2] 	= ref_save[2] ;
		ref[3] 	= ref_save[3] ;
		ref[4] 	= ref_save[4] ;
		ref[5] 	= ref_save[5] ;
		ref[6] 	= ref_save[6] ;
		ref[7] 	= ref_save[7] ;
		ref[8] 	= ref_save[8] ;
		ref[9] 	= ref_save[9] ;
		ref[10]	= ref_save[10];
		ref[11]	= ref_save[11];
		ref[12]	= ref_save[12];
		ref[13]	= ref_save[13];
		ref[14]	= ref_save[14];
		ref[15]	= ref_save[15];
		ref[16]	= ref_save[16];
		ref[17]	= ref_save[17];
		ref[18]	= ref_save[18];
		ref[19]	= ref_save[19];
		ref[20]	= ref_save[20];
		ref[21]	= ref_save[21];
		ref[22]	= ref_save[22];
		ref[23]	= ref_save[23];
		ref[24]	= ref_save[24];
		ref[25]	= ref_save[25];
		ref[26]	= ref_save[26];
		ref[27]	= ref_save[27];
		ref[28]	= ref_save[28];
		ref[29]	= ref_save[29];
		ref[30]	= ref_save[30];
		ref[31]	= ref_save[31];
		ref[32]	= ref_save[32];
		ref[33]	= ref_save[33];
		ref[34]	= ref_save[34];
		ref[35]	= ref_save[35];
		ref[36]	= ref_save[36];
		ref[37]	= ref_save[37];
		ref[38]	= ref_save[38];
		ref[39]	= ref_save[39];
		ref[40]	= ref_save[40];
		ref[41]	= ref_save[41];
		ref[42]	= ref_save[42];
		ref[43]	= ref_save[43];
		ref[44]	= ref_save[44];
		ref[45]	= ref_save[45];
		ref[46]	= ref_save[46];
		ref[47]	= ref_save[47];
		ref[48]	= ref_save[48];
		ref[49]	= ref_save[49];
		ref[50]	= ref_save[50];
		ref[51]	= ref_save[51];
		ref[52]	= ref_save[52];
		ref[53]	= ref_save[53];
		ref[54]	= ref_save[54];
		ref[55]	= ref_save[55];
		ref[56]	= ref_save[56];
		ref[57]	= ref_save[57];
		ref[58]	= ref_save[58];
		ref[59]	= ref_save[59];
		ref[60]	= ref_save[60];
		ref[61]	= ref_save[61];
		ref[62]	= ref_save[62];
		ref[63]	= ref_save[63];
		case(state)
			IDLE: begin
				case({Icache_read, Icache_write, Dcache_read, Dcache_write})
				4'b1000: begin 
							next_counter = counter +1;
							if(hit) begin
							next_state = I_READY;
							next_miss = miss;
													if(ref_save[0] == index) begin //0
														ref[0] 	=ref_save[1] ;
														ref[1] 	=ref_save[2] ;
														ref[2] 	=ref_save[3] ;
														ref[3] 	=ref_save[4] ;
														ref[4] 	=ref_save[5] ;
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[1] == index) begin //1
														ref[1] 	=ref_save[2] ;
														ref[2] 	=ref_save[3] ;
														ref[3] 	=ref_save[4] ;
														ref[4] 	=ref_save[5] ;
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[2] == index) begin //2
														ref[2] 	=ref_save[3] ;
														ref[3] 	=ref_save[4] ;
														ref[4] 	=ref_save[5] ;
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[3] == index) begin
														ref[3] 	=ref_save[4] ;
														ref[4] 	=ref_save[5] ;
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[4] == index) begin
														ref[4] 	=ref_save[5] ;
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[5] == index) begin
														
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[6] == index) begin
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[7] == index) begin
														
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[8] == index) begin
														
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[9] == index) begin
														
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[10] == index) begin
														
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[11] == index) begin
														
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[12] == index) begin
														
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[13] == index) begin
														
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[14] == index) begin
														
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[15] == index) begin
														
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[16] == index) begin
														
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[17] == index) begin
														
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[18] == index) begin
														
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[19] == index) begin
														
														
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[20] == index) begin
														
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[21] == index) begin
														
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[22] == index) begin
														
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[23] == index) begin
														
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[24] == index) begin
														
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[25] == index) begin
														
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[26] == index) begin
														
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[27] == index) begin
														
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[28] == index) begin
														
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[29] == index) begin
														
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[30] == index) begin
														
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[31] == index) begin
														
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[32] == index) begin
														
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[33] == index) begin
														
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[34] == index) begin
														
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[35] == index) begin
														
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[36] == index) begin
														
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[37] == index) begin
														
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[38] == index) begin
														
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end

													if(ref_save[39] == index) begin
														
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[40] == index) begin
													
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[41] == index) begin
												
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[42] == index) begin
													
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[43] == index) begin
													
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[44] == index) begin
													
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[45] == index) begin
													
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[46] == index) begin
													
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[47] == index) begin
													
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[48] == index) begin
													
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[49] == index) begin
													
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[50] == index) begin
													
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[51] == index) begin
													
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[52] == index) begin
													
														
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[53] == index) begin
													
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[54] == index) begin
													
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[55] == index) begin
													
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[56] == index) begin
													
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[57] == index) begin
													
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[58] == index) begin
													
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[59] == index) begin
													
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[60] == index) begin
													
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[61] == index) begin
													
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[62] == index) begin
													
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[63] == index) begin
														ref[63] = index;
													end
											end
							else begin
							next_miss = miss +1;
							next_state = I_FROMMEM;
							end
						end
				4'b0100: begin next_state = IDLE; next_counter = counter;
		next_miss = miss; end
				4'b0010: begin 
							next_counter = counter +1;
							if(hit) begin
														if(ref_save[0] == index) begin //0
														ref[0] 	=ref_save[1] ;
														ref[1] 	=ref_save[2] ;
														ref[2] 	=ref_save[3] ;
														ref[3] 	=ref_save[4] ;
														ref[4] 	=ref_save[5] ;
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[1] == index) begin //1
														ref[1] 	=ref_save[2] ;
														ref[2] 	=ref_save[3] ;
														ref[3] 	=ref_save[4] ;
														ref[4] 	=ref_save[5] ;
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[2] == index) begin //2
														ref[2] 	=ref_save[3] ;
														ref[3] 	=ref_save[4] ;
														ref[4] 	=ref_save[5] ;
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[3] == index) begin
														ref[3] 	=ref_save[4] ;
														ref[4] 	=ref_save[5] ;
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[4] == index) begin
														ref[4] 	=ref_save[5] ;
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[5] == index) begin
														
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[6] == index) begin
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[7] == index) begin
														
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[8] == index) begin
														
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[9] == index) begin
														
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[10] == index) begin
														
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[11] == index) begin
														
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[12] == index) begin
														
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[13] == index) begin
														
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[14] == index) begin
														
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[15] == index) begin
														
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[16] == index) begin
														
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[17] == index) begin
														
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[18] == index) begin
														
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[19] == index) begin
														
														
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[20] == index) begin
														
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[21] == index) begin
														
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[22] == index) begin
														
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[23] == index) begin
														
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[24] == index) begin
														
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[25] == index) begin
														
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[26] == index) begin
														
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[27] == index) begin
														
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[28] == index) begin
														
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[29] == index) begin
														
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[30] == index) begin
														
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[31] == index) begin
														
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[32] == index) begin
														
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[33] == index) begin
														
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[34] == index) begin
														
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[35] == index) begin
														
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[36] == index) begin
														
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[37] == index) begin
														
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[38] == index) begin
														
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end

													if(ref_save[39] == index) begin
														
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[40] == index) begin
													
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[41] == index) begin
												
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[42] == index) begin
													
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[43] == index) begin
													
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[44] == index) begin
													
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[45] == index) begin
													
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[46] == index) begin
													
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[47] == index) begin
													
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[48] == index) begin
													
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[49] == index) begin
													
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[50] == index) begin
													
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[51] == index) begin
													
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[52] == index) begin
													
														
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[53] == index) begin
													
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[54] == index) begin
													
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[55] == index) begin
													
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[56] == index) begin
													
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[57] == index) begin
													
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[58] == index) begin
													
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[59] == index) begin
													
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[60] == index) begin
													
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[61] == index) begin
													
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[62] == index) begin
													
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[63] == index) begin
														ref[63] = index;
													end
							next_state = D_READY;
							next_miss = miss;
							end
							else begin
							next_miss = miss +1;
							next_state = D_FROMMEM;
						end end
				4'b0001: begin 
						next_counter = counter +1;
							if(hit) begin
							next_miss = miss;
							next_state = D_WRITE;
							end
							else begin 
							next_miss = miss +1;
							next_state = D_FROMMEM;
							end
						end
				4'b1010: begin 
							next_counter = counter +1;
							if(hit) begin
														if(ref_save[0] == index) begin //0
														ref[0] 	=ref_save[1] ;
														ref[1] 	=ref_save[2] ;
														ref[2] 	=ref_save[3] ;
														ref[3] 	=ref_save[4] ;
														ref[4] 	=ref_save[5] ;
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[1] == index) begin //1
														ref[1] 	=ref_save[2] ;
														ref[2] 	=ref_save[3] ;
														ref[3] 	=ref_save[4] ;
														ref[4] 	=ref_save[5] ;
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[2] == index) begin //2
														ref[2] 	=ref_save[3] ;
														ref[3] 	=ref_save[4] ;
														ref[4] 	=ref_save[5] ;
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[3] == index) begin
														ref[3] 	=ref_save[4] ;
														ref[4] 	=ref_save[5] ;
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[4] == index) begin
														ref[4] 	=ref_save[5] ;
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[5] == index) begin
														
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[6] == index) begin
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[7] == index) begin
														
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[8] == index) begin
														
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[9] == index) begin
														
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[10] == index) begin
														
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[11] == index) begin
														
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[12] == index) begin
														
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[13] == index) begin
														
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[14] == index) begin
														
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[15] == index) begin
														
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[16] == index) begin
														
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[17] == index) begin
														
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[18] == index) begin
														
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[19] == index) begin
														
														
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[20] == index) begin
														
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[21] == index) begin
														
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[22] == index) begin
														
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[23] == index) begin
														
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[24] == index) begin
														
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[25] == index) begin
														
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[26] == index) begin
														
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[27] == index) begin
														
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[28] == index) begin
														
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[29] == index) begin
														
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[30] == index) begin
														
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[31] == index) begin
														
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[32] == index) begin
														
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[33] == index) begin
														
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[34] == index) begin
														
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[35] == index) begin
														
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[36] == index) begin
														
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[37] == index) begin
														
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[38] == index) begin
														
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end

													if(ref_save[39] == index) begin
														
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[40] == index) begin
													
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[41] == index) begin
												
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[42] == index) begin
													
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[43] == index) begin
													
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[44] == index) begin
													
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[45] == index) begin
													
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[46] == index) begin
													
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[47] == index) begin
													
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[48] == index) begin
													
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[49] == index) begin
													
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[50] == index) begin
													
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[51] == index) begin
													
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[52] == index) begin
													
														
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[53] == index) begin
													
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[54] == index) begin
													
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[55] == index) begin
													
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[56] == index) begin
													
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[57] == index) begin
													
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[58] == index) begin
													
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[59] == index) begin
													
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[60] == index) begin
													
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[61] == index) begin
													
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[62] == index) begin
													
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[63] == index) begin
														ref[63] = index;
													end
							next_state = I_READY;
							next_miss = miss;
							end
							else begin
							next_state = I_FROMMEM;
							next_miss =miss+1;
							end
						end
				4'b1001: begin 
							next_counter = counter +1;
							if(hit) begin							
								if(ref_save[0] == index) begin //0
														ref[0] 	=ref_save[1] ;
														ref[1] 	=ref_save[2] ;
														ref[2] 	=ref_save[3] ;
														ref[3] 	=ref_save[4] ;
														ref[4] 	=ref_save[5] ;
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[1] == index) begin //1
														ref[1] 	=ref_save[2] ;
														ref[2] 	=ref_save[3] ;
														ref[3] 	=ref_save[4] ;
														ref[4] 	=ref_save[5] ;
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[2] == index) begin //2
														ref[2] 	=ref_save[3] ;
														ref[3] 	=ref_save[4] ;
														ref[4] 	=ref_save[5] ;
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[3] == index) begin
														ref[3] 	=ref_save[4] ;
														ref[4] 	=ref_save[5] ;
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[4] == index) begin
														ref[4] 	=ref_save[5] ;
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[5] == index) begin
														
														ref[5] 	=ref_save[6] ;
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[6] == index) begin
														ref[6] 	=ref_save[7] ;
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[7] == index) begin
														
														ref[7] 	=ref_save[8] ;
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[8] == index) begin
														
														ref[8] 	=ref_save[9] ;
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[9] == index) begin
														
														ref[9] 	=ref_save[10];
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[10] == index) begin
														
														ref[10]	=ref_save[11];
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[11] == index) begin
														
														ref[11]	=ref_save[12];
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[12] == index) begin
														
														ref[12]	=ref_save[13];
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[13] == index) begin
														
														ref[13]	=ref_save[14];
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[14] == index) begin
														
														ref[14]	=ref_save[15];
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[15] == index) begin
														
														ref[15]	=ref_save[16];
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[16] == index) begin
														
														ref[16]	=ref_save[17];
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[17] == index) begin
														
														ref[17]	=ref_save[18];
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[18] == index) begin
														
														ref[18]	=ref_save[19];
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[19] == index) begin
														
														
														ref[19]	=ref_save[20];
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[20] == index) begin
														
														ref[20]	=ref_save[21];
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[21] == index) begin
														
														ref[21]	=ref_save[22];
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[22] == index) begin
														
														ref[22]	=ref_save[23];
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[23] == index) begin
														
														ref[23]	=ref_save[24];
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[24] == index) begin
														
														ref[24]	=ref_save[25];
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[25] == index) begin
														
														ref[25]	=ref_save[26];
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[26] == index) begin
														
														ref[26]	=ref_save[27];
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[27] == index) begin
														
														ref[27]	=ref_save[28];
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[28] == index) begin
														
														ref[28]	=ref_save[29];
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[29] == index) begin
														
														ref[29]	=ref_save[30];
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[30] == index) begin
														
														ref[30]	=ref_save[31];
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[31] == index) begin
														
														ref[31]	=ref_save[32];
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[32] == index) begin
														
														ref[32]	=ref_save[33];
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[33] == index) begin
														
														ref[33]	=ref_save[34];
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[34] == index) begin
														
														ref[34]	=ref_save[35];
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[35] == index) begin
														
														ref[35]	=ref_save[36];
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[36] == index) begin
														
														ref[36]	=ref_save[37];
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[37] == index) begin
														
														ref[37]	=ref_save[38];
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[38] == index) begin
														
														ref[38]	=ref_save[39];
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end

													if(ref_save[39] == index) begin
														
														ref[39]	=ref_save[40];
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[40] == index) begin
													
														ref[40]	=ref_save[41];
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[41] == index) begin
												
														ref[41]	=ref_save[42];
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[42] == index) begin
													
														ref[42]	=ref_save[43];
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[43] == index) begin
													
														ref[43]	=ref_save[44];
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[44] == index) begin
													
														ref[44]	=ref_save[45];
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[45] == index) begin
													
														ref[45]	=ref_save[46];
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[46] == index) begin
													
														ref[46]	=ref_save[47];
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[47] == index) begin
													
														ref[47]	=ref_save[48];
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[48] == index) begin
													
														ref[48]	=ref_save[49];
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[49] == index) begin
													
														ref[49]	=ref_save[50];
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[50] == index) begin
													
														ref[50]	=ref_save[51];
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[51] == index) begin
													
														ref[51]	=ref_save[52];
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[52] == index) begin
													
														
														ref[52]	=ref_save[53];
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[53] == index) begin
													
														ref[53]	=ref_save[54];
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[54] == index) begin
													
														ref[54]	=ref_save[55];
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[55] == index) begin
													
														ref[55]	=ref_save[56];
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[56] == index) begin
													
														ref[56]	=ref_save[57];
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[57] == index) begin
													
														ref[57]	=ref_save[58];
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[58] == index) begin
													
														ref[58]	=ref_save[59];
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[59] == index) begin
													
														ref[59]	=ref_save[60];
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[60] == index) begin
													
														ref[60]	=ref_save[61];
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[61] == index) begin
													
														ref[61]	=ref_save[62];
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[62] == index) begin
													
														ref[62]	=ref_save[63];
														ref[63] = index;
													end
													if(ref_save[63] == index) begin
														ref[63] = index;
													end
							next_state = I_READY;
							next_miss = miss;
							end
							else begin
							next_miss = miss+1;
							next_state = I_FROMMEM;
							end
						end
				default: begin next_state = IDLE; next_counter = counter;
		next_miss = miss; end
				endcase
			end


			I_FROMMEM:begin
			next_counter = counter;
		next_miss = miss;
				if(Imem_ready) begin
							ref[0] 	= ref_save[1] ;
							ref[1] 	=ref_save[2] ;
							ref[2] 	=ref_save[3] ;
							ref[3] 	=ref_save[4] ;
							ref[4] 	=ref_save[5] ;
							ref[5] 	=ref_save[6] ;
							ref[6] 	=ref_save[7] ;
							ref[7] 	=ref_save[8] ;
							ref[8] 	=ref_save[9] ;
							ref[9] 	=ref_save[10];
							ref[10]	=ref_save[11];
							ref[11]	=ref_save[12];
							ref[12]	=ref_save[13];
							ref[13]	=ref_save[14];
							ref[14]	=ref_save[15];
							ref[15]	=ref_save[16];
							ref[16]	=ref_save[17];
							ref[17]	=ref_save[18];
							ref[18]	=ref_save[19];
							ref[19]	=ref_save[20];
							ref[20]	=ref_save[21];
							ref[21]	=ref_save[22];
							ref[22]	=ref_save[23];
							ref[23]	=ref_save[24];
							ref[24]	=ref_save[25];
							ref[25]	=ref_save[26];
							ref[26]	=ref_save[27];
							ref[27]	=ref_save[28];
							ref[28]	=ref_save[29];
							ref[29]	=ref_save[30];
							ref[30]	=ref_save[31];
							ref[31]	=ref_save[32];
							ref[32]	=ref_save[33];
							ref[33]	=ref_save[34];
							ref[34]	=ref_save[35];
							ref[35]	=ref_save[36];
							ref[36]	=ref_save[37];
							ref[37]	=ref_save[38];
							ref[38]	=ref_save[39];
							ref[39]	=ref_save[40];
							ref[40]	=ref_save[41];
							ref[41]	=ref_save[42];
							ref[42]	=ref_save[43];
							ref[43]	=ref_save[44];
							ref[44]	=ref_save[45];
							ref[45]	=ref_save[46];
							ref[46]	=ref_save[47];
							ref[47]	=ref_save[48];
							ref[48]	=ref_save[49];
							ref[49]	=ref_save[50];
							ref[50]	=ref_save[51];
							ref[51]	=ref_save[52];
							ref[52]	=ref_save[53];
							ref[53]	=ref_save[54];
							ref[54]	=ref_save[55];
							ref[55]	=ref_save[56];
							ref[56]	=ref_save[57];
							ref[57]	=ref_save[58];
							ref[58]	=ref_save[59];
							ref[59]	=ref_save[60];
							ref[60]	=ref_save[61];
							ref[61]	=ref_save[62];
							ref[62]	=ref_save[63];
							ref[63] = index; 
							ref[index] = ref_save[0];
					next_state = I_READY;
				end
				else
					next_state = I_FROMMEM;
			end
			I_READY: begin next_counter = counter;
		next_miss = miss; next_state = IDLE;
			end
			D_WRITE: begin next_counter = counter;
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
							ref[0] 	=ref_save[1] ;
							ref[1] 	=ref_save[2] ;
							ref[2] 	=ref_save[3] ;
							ref[3] 	=ref_save[4] ;
							ref[4] 	=ref_save[5] ;
							ref[5] 	=ref_save[6] ;
							ref[6] 	=ref_save[7] ;
							ref[7] 	=ref_save[8] ;
							ref[8] 	=ref_save[9] ;
							ref[9] 	=ref_save[10];
							ref[10]	=ref_save[11];
							ref[11]	=ref_save[12];
							ref[12]	=ref_save[13];
							ref[13]	=ref_save[14];
							ref[14]	=ref_save[15];
							ref[15]	=ref_save[16];
							ref[16]	=ref_save[17];
							ref[17]	=ref_save[18];
							ref[18]	=ref_save[19];
							ref[19]	=ref_save[20];
							ref[20]	=ref_save[21];
							ref[21]	=ref_save[22];
							ref[22]	=ref_save[23];
							ref[23]	=ref_save[24];
							ref[24]	=ref_save[25];
							ref[25]	=ref_save[26];
							ref[26]	=ref_save[27];
							ref[27]	=ref_save[28];
							ref[28]	=ref_save[29];
							ref[29]	=ref_save[30];
							ref[30]	=ref_save[31];
							ref[31]	=ref_save[32];
							ref[32]	=ref_save[33];
							ref[33]	=ref_save[34];
							ref[34]	=ref_save[35];
							ref[35]	=ref_save[36];
							ref[36]	=ref_save[37];
							ref[37]	=ref_save[38];
							ref[38]	=ref_save[39];
							ref[39]	=ref_save[40];
							ref[40]	=ref_save[41];
							ref[41]	=ref_save[42];
							ref[42]	=ref_save[43];
							ref[43]	=ref_save[44];
							ref[44]	=ref_save[45];
							ref[45]	=ref_save[46];
							ref[46]	=ref_save[47];
							ref[47]	=ref_save[48];
							ref[48]	=ref_save[49];
							ref[49]	=ref_save[50];
							ref[50]	=ref_save[51];
							ref[51]	=ref_save[52];
							ref[52]	=ref_save[53];
							ref[53]	=ref_save[54];
							ref[54]	=ref_save[55];
							ref[55]	=ref_save[56];
							ref[56]	=ref_save[57];
							ref[57]	=ref_save[58];
							ref[58]	=ref_save[59];
							ref[59]	=ref_save[60];
							ref[60]	=ref_save[61];
							ref[61]	=ref_save[62];
							ref[62]	=ref_save[63];
							ref[63] = index;
							ref[index] = ref_save[0];
					if(Dcache_read)
						next_state = D_READY;
					else 
						next_state = D_WRITE;
				end
				else
					next_state = D_FROMMEM;
			end
			D_READY:begin next_state = IDLE;
next_counter = counter;
		next_miss = miss; end
			default: begin
				next_state = IDLE; next_counter = counter;
		next_miss = miss; end
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
					tag = Icache_addr[27:0];
					block = Icache_wdata;
		end
		I_FROMMEM:	begin
					valid = 1'b1;
					type = 1'b0;
					tag = Icache_addr[27:0];
					block = Imem_rdata;
		end
		D_WRITE:begin
					valid = 1'b1;
					type = 1'b1;
					tag = Dcache_addr[27:0];
					block = Dcache_wdata;
		end
		D_FROMMEM:begin
					valid = 1'b1;
					type = 1'b1;
					tag = Dcache_addr[27:0];
					block = Dmem_rdata;
		end
		endcase
	end





//==== sequential circuit =================================
	always@( posedge clk or posedge proc_reset ) begin
	    if( proc_reset ) begin
	    	miss <= 0;
	    	counter <=0;
	    	state <= 3'b00;
			valid_save <= 256'b0;
			type_save <= 256'b0;

			ref_save[0]  <= 6'd0;
			ref_save[1]  <= 6'd1;
			ref_save[2]  <= 6'd2;
			ref_save[3]  <= 6'd3;
			ref_save[4]  <= 6'd4;
			ref_save[5]  <= 6'd5;
			ref_save[6]  <= 6'd6;
			ref_save[7]  <= 6'd7;
			ref_save[8]  <= 6'd8;
			ref_save[9]  <= 6'd9;
			ref_save[10] <= 6'd10;
			ref_save[11] <= 6'd11;
			ref_save[12] <= 6'd12;
			ref_save[13] <= 6'd13;
			ref_save[14] <= 6'd14;
			ref_save[15] <= 6'd15;
			ref_save[16] <= 6'd16;
			ref_save[17] <= 6'd17;
			ref_save[18] <= 6'd18;
			ref_save[19] <= 6'd19;
			ref_save[20] <= 6'd20;
			ref_save[21] <= 6'd21;
			ref_save[22] <= 6'd22;
			ref_save[23] <= 6'd23;
			ref_save[24] <= 6'd24;
			ref_save[25] <= 6'd25;
			ref_save[26] <= 6'd26;
			ref_save[27] <= 6'd27;
			ref_save[28] <= 6'd28;
			ref_save[29] <= 6'd29;
			ref_save[30] <= 6'd30;
			ref_save[31] <= 6'd31;
			ref_save[32] <= 6'd32;
			ref_save[33] <= 6'd33;
			ref_save[34] <= 6'd34;
			ref_save[35] <= 6'd35;
			ref_save[36] <= 6'd36;
			ref_save[37] <= 6'd37;
			ref_save[38] <= 6'd38;
			ref_save[39] <= 6'd39;
			ref_save[40] <= 6'd40;
			ref_save[41] <= 6'd41;
			ref_save[42] <= 6'd42;
			ref_save[43] <= 6'd43;
			ref_save[44] <= 6'd44;
			ref_save[45] <= 6'd45;
			ref_save[46] <= 6'd46;
			ref_save[47] <= 6'd47;
			ref_save[48] <= 6'd48;
			ref_save[49] <= 6'd49;
			ref_save[50] <= 6'd50;
			ref_save[51] <= 6'd51;
			ref_save[52] <= 6'd52;
			ref_save[53] <= 6'd53;
			ref_save[54] <= 6'd54;
			ref_save[55] <= 6'd55;
			ref_save[56] <= 6'd56;
			ref_save[57] <= 6'd57;
			ref_save[58] <= 6'd58;
			ref_save[59] <= 6'd59;
			ref_save[60] <= 6'd60;
			ref_save[61] <= 6'd61;
			ref_save[62] <= 6'd62;
			ref_save[63] <= 6'd63;
			for(i = 0; i <BLOCK_NUM; i = i+1) begin
			tag_save[i] <= 28'b0;  
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

			for(i = 0; i <BLOCK_NUM; i = i+1) begin
			ref_save[i] <= ref[i];
			end

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