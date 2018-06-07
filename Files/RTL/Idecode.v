`include "control.v"
`include "Registers.v"
`include "ID_MUX.v"
module Idecode(	clk, rst, WRITE_RegADDR, Instruction,MemtoReg_in , RegWrite_in, ALU_result, read_datain,				
			Reg_S1, Reg_S2, Reg_S3, Reg_S4, Reg_S5, Reg_S6, Reg_S7, Reg_S8,
			RegWrite, MemtoReg, Branch, MemRead, MemWrite, RegDst, ALUop, ALUSrc,
			Jump, read_data1, read_data2, Sign_extend, INS_25to21, INS_20to16, INS_15to11, INS_10to6, stall, branch_taken ,
			Opcode 	//new	pass next stage	
		);
	
	parameter MIP_BUS = 32;
	parameter NUM_REG = 16;
	
	input			clk,rst;
	input	[4:0]		WRITE_RegADDR;
	input			MemtoReg_in, RegWrite_in;
	input	[31:0]		Instruction;
	input	[MIP_BUS-1:0]	ALU_result;
	input	[MIP_BUS-1:0]	read_datain;
	//new
	input	stall;
	
	output	[MIP_BUS-1:0]	Reg_S1, Reg_S2, Reg_S3, Reg_S4, Reg_S5, Reg_S6, Reg_S7, Reg_S8;
	output			RegWrite ,Branch, RegDst;
	output			MemtoReg, MemRead, MemWrite;
	output	[1:0]		ALUop;
	output			ALUSrc;
	output			Jump;	
	output	[MIP_BUS-1:0]	read_data1, read_data2;
	output	[31:0]		Sign_extend;
	output	[4:0]		INS_25to21, INS_20to16, INS_15to11, INS_10to6;
	//new
	input branch_taken;
	output [5:0]	Opcode;	

	reg	[MIP_BUS-1:0]	register_file	[NUM_REG-1:0];
	reg	[MIP_BUS-1:0]	write_data;
	reg	[15:0]		Instruction_immediateVAL;
	reg	[31:0]		Sign_extend;
	//new
//	wire			Compare;
	wire	[1:0]		ALUop_muxin;
//	wire			and1,and2;
	//new
	assign Opcode = Instruction [31:26];
	wire	Branch_muxin, RegDst_muxin, ALUSrc_muxin, MemtoReg_muxin, RegWrite_muxin, MemRead_muxin, MemWrite_muxin;

	control	CTRL	(		.clk		(clk),
						.rst		(rst),
						.Opcode	(Instruction[31:26]),
						.ALUop		(ALUop_muxin),
						.Branch	(Branch_muxin),
						.Jump		(Jump),
						.RegDst	(RegDst_muxin),
						.ALUSrc	(ALUSrc_muxin),
						.MemtoReg	(MemtoReg_muxin),
						.RegWrite	(RegWrite_muxin),
						.MemRead	(MemRead_muxin),
						.MemWrite	(MemWrite_muxin)										
				);
	Registers u_register	(		.Read_register1	(Instruction[25:21]),
						.Read_register2	(Instruction[20:16]),
						.Write_register	(WRITE_RegADDR),
						.Write_data		(write_data),
						.Read_data1		(read_data1),
						.Read_data2		(read_data2)	,	
						.RegWrite		(RegWrite_in),
						.Reg_S1		(Reg_S1),
						.Reg_S2		(Reg_S2),
						.Reg_S3		(Reg_S3), 
						.Reg_S4		(Reg_S4), 
						.Reg_S5		(Reg_S5), 
						.Reg_S6		(Reg_S6), 
						.Reg_S7		(Reg_S7), 
						.Reg_S8		(Reg_S8),
						.rst			(rst)
				);
	//new	
	ID_MUX			u_IDMUX (
						.stall			(stall),
						.RegWrite_in		(RegWrite_muxin), 	
						.MemtoReg_in		(MemtoReg_muxin), 
						.Branch_in		(Branch_muxin), 
						.MemRead_in		(MemRead_muxin), 
						.MemWrite_in		(MemWrite_muxin), 
						.ALUSrc_in		(ALUSrc_muxin), 
						.ALUop_in		(ALUop_muxin),
						.RegDst_in		(RegDst_muxin),
						.RegWrite_out		(RegWrite),
						.MemtoReg_out		(MemtoReg), 
						.Branch_out		(Branch), 						
						.MemRead_out		(MemRead), 
						.MemWrite_out		(MemWrite), 
						.ALUSrc_out		(ALUSrc), 
						.ALUop_out		(ALUop), 
						.RegDst_out		(RegDst)
					);

	assign	INS_25to21 = Instruction[25:21];	//Rs
	assign	INS_20to16 = Instruction[20:16];	//Rt
	assign	INS_15to11 = Instruction[15:11];	//Rd
	assign	INS_10to6 = Instruction[10:6];	//shamt	
//	assign Compare = (read_data1 == read_data2) ?1 :0;
//	assign branch_taken = and1 | and2;
//	assign and1 = Branch_muxin && Compare && (Instruction[31:26] == 6'b000100);
//	assign and2 = Branch_muxin && (~Compare) && (Instruction[31:26] == 6'b000101);
	always @(*)	begin
		Instruction_immediateVAL = Instruction[15:0];
		// for mux (in ALU_result read_datain)(sel MemtoReg) (out write_data)
		if(MemtoReg_in == 1'b0) 
			write_data = ALU_result;
		else 
			write_data = read_datain;
		//end mux
		//for sign extend
		if(Instruction_immediateVAL[MIP_BUS-1] == 1'b0)
			Sign_extend = {16'h0000,Instruction_immediateVAL};
		else
			Sign_extend = {16'hFFFF,Instruction_immediateVAL};
		//end sign extend
	end
endmodule  
