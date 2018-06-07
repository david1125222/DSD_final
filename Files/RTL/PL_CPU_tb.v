`include "PL_CPU.v"
`include "instmemory.v"
`include "dmemory.v"

module testbench();
	reg clk,rst;
	wire PC0,PC1,PC2;
	parameter clkc=10;
	//new	INST
	wire [15:0]addr;
	wire [31:0]read_data;
	//end INST
	//new DM
	wire	[15:0] MEM_ReadDataOUT, MEM_ADDRIN, MEM_WriteData; 
	wire		MEM_MemRead, MEM_MemWrite;
	//end DM
	

	PL_CPU u_cpu (  clk,rst,PC0,PC1,PC2,
				addr,read_data,		//new
				MEM_ReadDataOUT, MEM_ADDRIN, MEM_WriteData, MEM_MemRead, MEM_MemWrite
				);

	instmemory u_inst ( .addr(addr) , .read_data(read_data) );
	
	dmemory u_dmemory (	.clk(clk),.reset(rst),
				.addr(MEM_ADDRIN), .Write_data(MEM_WriteData), .Read_data(MEM_ReadDataOUT),
				.MemRead(MEM_MemRead), .MemWrite(MEM_MemWrite)	);
	

	always #(clkc/2) clk=~clk;
	initial begin
		rst=0;  clk=1;
		#10 rst=1;
		#1	$readmemb("test1.prog",u_inst.mem);
			$readmemh("dm_test1.prog",u_dmemory.mem);
		#40 rst=0;
		#750 rst=1;	
		#51	$readmemb("test2.prog",u_inst.mem);
			$readmemb("dm_test2.prog",u_dmemory.mem);
		#40 rst=0;
		#7000 rst=1;
		#51	$readmemb("test3.prog",u_inst.mem);
			$readmemh("dm_test3.prog",u_dmemory.mem);
		#40 rst=0;
		#1000 rst=1;
		#50 $finish ; 
	end
	initial begin
		$fsdbDumpfile("PL_CPU.fsdb");
		$fsdbDumpvars;
	end
endmodule    
