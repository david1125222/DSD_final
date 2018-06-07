`include "instmemory.v"
module Ifetch(	clk, rst, PCSrc, stall,
			Instruction, PC , Last_Inst	
			);
	
	parameter MIP_BUS = 16;		    
	
	`define    JUMP	6'b000010
	`define    OPCODE	Instruction[31:26]
	`define    JUMP_ADDR	Instruction[15:0]
	`define    BR_ADDR	Last_Inst[15:0]
	input			clk,rst;
	input			PCSrc;		//branch_taken
	input			stall;	
	input	[15:0]		Last_Inst;	
	//new
	input	[31:0]		Instruction;
	output	[MIP_BUS-1:0]	PC;		

	reg	[MIP_BUS-1:0]	PC;
	reg	[MIP_BUS-1:0]	next_PC;
	
	wire	[MIP_BUS-1:0]	Branch_offset = `BR_ADDR;
	wire	[MIP_BUS-1:0]	Branch_result = PC + Branch_offset -1;
	
//	instmemory		INST	(.addr(PC),.read_data(Instruction));	//read instruction from IM	
	//combinational part
	always @(*)
	begin		
		if(PCSrc)	
			next_PC = Branch_result;	//branch: current position + offset
		else if (`OPCODE == `JUMP) 
			next_PC = `JUMP_ADDR;
		else if (stall) 
			next_PC =  PC -1;	
		else
			next_PC = PC + 1;		//PC+4	
	end
	//sequential part
	always @(posedge clk or posedge rst )
	begin
		if(rst)
			PC <= 16'b0;
//		else if(stall)	
//			PC <= PC-1;		
		else
			PC <= next_PC;
	end	
endmodule 
