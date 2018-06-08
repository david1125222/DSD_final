`include "instmemory.v"
module Ifetch(	clk, rst, PCSrc, stall,
			Instruction, PC , Last_Inst, PC_plus_4,Read_data1
			);
	
	parameter MIP_BUS = 32;		    
	
	`define    JUMP	6'b000010
	`define    JR   6'b001000
	`define    OPCODE	Instruction[31:26]
	`define    func     Instruction[5:0]
	//`define    JUMP_ADDR	Instruction[15:0]
	`define    BR_ADDR	Last_Inst[15:0]
	input			clk,rst;
	input			PCSrc;		//branch_taken
	input			stall;	
	input	[15:0]		Last_Inst;	
	input   [31:0]  Read_data1;
	//new
	input	[31:0]		Instruction;
	output	[MIP_BUS-1:0]	PC;		
	output  [MIP_BUS-1:0]   PC_plus_4;
	reg	[MIP_BUS-1:0]	PC;
	reg	[MIP_BUS-1:0]	next_PC;
	
	wire	[MIP_BUS-1:0]	Branch_offset = `BR_ADDR;
	wire	[MIP_BUS-1:0]	Branch_result = PC + Branch_offset -1;
	wire    [5:0]           func;

	assign PC_plus_4 = next_PC + 4;

//	instmemory		INST	(.addr(PC),.read_data(Instruction));	//read instruction from IM	
	//combinational part
	always @(*)
	begin		
		if(PCSrc)	
			next_PC = Branch_result;	//branch: current position + offset
		else if (`OPCODE == `JUMP) 
			next_PC = {PC_plus_4[31:28],Instruction[25:0],2'b00};
		else if (stall) 
			next_PC =  PC -1;	
		else if ((`OPCODE == 6'b0) && (`func==`JR))
			next_PC = Read_data1;
		else
			next_PC = PC_plus_4;		//PC+4	
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
