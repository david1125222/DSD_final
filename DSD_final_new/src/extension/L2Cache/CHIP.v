`include "MIPS_Pipeline.v"
`include "L1cache.v"
`include "I_L1cache.v"

// Top module of your design, you cannot modify this module!!
module CHIP (	clk,
				rst_n,
//----------for slow_memD------------
				mem_read_D,
				mem_write_D,
				mem_addr_D,
				mem_wdata_D,
				mem_rdata_D,
				mem_ready_D,
//----------for slow_memI------------
				mem_read_I,
				mem_write_I,
				mem_addr_I,
				mem_wdata_I,
				mem_rdata_I,
				mem_ready_I,
//----------for TestBed--------------				
				DCACHE_addr, 
				DCACHE_wdata,
				DCACHE_wen   
			);
input			clk, rst_n;
//--------------------------

output			mem_read_D;
output			mem_write_D;
output	[27:0]	mem_addr_D;
output	[127:0]	mem_wdata_D;
input	[127:0]	mem_rdata_D;
input			mem_ready_D;
//--------------------------
output			mem_read_I;
output			mem_write_I;
output	[27:0]	mem_addr_I;
output	[127:0]	mem_wdata_I;
input	[127:0]	mem_rdata_I;
input			mem_ready_I;
//----------for TestBed--------------
output	[29:0]	DCACHE_addr;
output	[31:0]	DCACHE_wdata;
output			DCACHE_wen;
//--------------------------

// wire declaration
wire        ICACHE_ren;
wire        ICACHE_wen;
wire [29:0] ICACHE_addr;
wire [31:0] ICACHE_wdata;
wire        ICACHE_stall;
wire [31:0] ICACHE_rdata;

wire        DCACHE_ren;
wire        DCACHE_wen;
wire [29:0] DCACHE_addr;
wire [31:0] DCACHE_wdata;
wire        DCACHE_stall;
wire [31:0] DCACHE_rdata;

wire 		L2_read_D;
wire		L2_write_D;
wire [27:0]	L2_addr_D;
wire [127:0]	L2_rdata_D;
wire [127:0]	L2_wdata_D;
wire 		L2_ready_D;

wire 		L2_read_I;
wire		L2_write_I;
wire [27:0]	L2_addr_I;
wire [127:0]	L2_rdata_I;
wire [127:0]	L2_wdata_I;
wire 		L2_ready_I;

//=========================================
	// Note that the overall design of your MIPS includes:
	// 1. pipelined MIPS processor
	// 2. data cache
	// 3. instruction cache


	MIPS_Pipeline i_MIPS(
		// control interface
		clk, 
		rst_n,
//----------I cache interface-------		
		ICACHE_ren,
		ICACHE_wen,
		ICACHE_addr,
		ICACHE_wdata,
		ICACHE_stall,
		ICACHE_rdata,
//----------D cache interface-------
		DCACHE_ren,
		DCACHE_wen,
		DCACHE_addr,
		DCACHE_wdata,
		DCACHE_stall,
		DCACHE_rdata,
	);
	
	L1cache D_cache(
		clk,
		~rst_n,
		DCACHE_ren,
		DCACHE_wen,
		DCACHE_addr,
		DCACHE_wdata,
		DCACHE_stall,
		DCACHE_rdata,
		L2_read_D,
		L2_write_D,
		L2_addr_D,
		L2_rdata_D,
		L2_wdata_D,
		L2_ready_D
	);

	I_L1cache I_cache(
		clk,
		~rst_n,
		ICACHE_ren,
		ICACHE_wen,
		ICACHE_addr,
		ICACHE_wdata,
		ICACHE_stall,
		ICACHE_rdata,
		L2_read_I,
		L2_write_I,
		L2_addr_I,
		L2_rdata_I,
		L2_wdata_I,
		L2_ready_I
	);

	L2cache L2cache0(
		clk,
	    ~rst_n,
	    L2_read_I,
	    L2_write_I,
	    L2_addr_I,
	    L2_wdata_I,
	    L2_ready_I,
	    L2_rdata_I,
	    L2_read_D,
	    L2_write_D,
	    L2_addr_D,
	    L2_wdata_D,
	    L2_ready_D,
	    L2_rdata_D,

	    mem_read_I,
	    mem_write_I,
	    mem_addr_I,
	    mem_rdata_I,
	    mem_wdata_I,
	    mem_ready_I,
	    mem_read_D,
	    mem_write_D,
	    mem_addr_D,
	    mem_rdata_D,
	    mem_wdata_D,
	    mem_ready_D
	);

	
endmodule

