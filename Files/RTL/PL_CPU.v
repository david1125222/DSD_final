`include "IF_IDreg.v"
`include "ID_EXreg.v"
`include "EX_MEMreg.v"
`include "MEM_WBreg.v"
`include "memory_access.v"
`include "Ifetch.v"
`include "Idecode.v"
`include "execute.v"
`include "Forwarding.v"
`include "Hazard_detector.v"

module PL_CPU(	clk,rst,PC0,PC1,PC2,
			PC_INST,IF_Instruction,		//new
			MEM_ReadDataOUT, MEM_ADDRIN, MEM_WriteData, MEM_MemRead, MEM_MemWrite
					);
input clk,rst;
output PC0,PC1,PC2;
wire [31:0] PC,PC_plus_4;
assign PC0 = PC[0];
assign PC1 = PC[1];
assign PC2 = PC[2];
//new INST
output [31:0] PC_INST;
input	[31:0] IF_Instruction;
assign PC_INST = PC;
//assign IF_Instruction = Inst_INST ; 
//end INST

//new DM
input	[31:0] MEM_ReadDataOUT;
output	[31:0] MEM_ADDRIN, MEM_WriteData; 
output		MEM_MemRead, MEM_MemWrite;
//end DM

//IF
wire IF_PCSrc, IF_Jump;
wire [31:0] IF_ADDOUT;
//reg [31:0] IF_Instruction;
//ID
wire ID_MemtoRegIN, ID_RegWriteIN, ID_RegWrite, ID_MemtoReg, ID_Branch, ID_MemRead, ID_MemWrite, ID_RegDst, ID_ALUSrc, Stall, Branch_taken;
wire [1:0] ID_ALUop;
wire [4:0] ID_WriteRegADDR, ID_INS20to16, ID_INS31to11, ID_INS25to21, ID_INS10to6;
wire [31:0] ID_ALUresult, ID_ReadDataIN, ID_ReadData1, ID_ReadData2;
wire [31:0] ID_instruction, ID_SignExtend;
wire [31:0] ID_PC_plus_4;
wire ID_isJAL;
//new
wire [31:0] Reg_S1, Reg_S2, Reg_S3, Reg_S4, Reg_S5, Reg_S6, Reg_S7, Reg_S8;
//EX
wire EX_RegWrite, EX_MemtoReg, EX_Branch, EX_MemRead, EX_MemWrite, EX_RegDst, EX_ALUSrc, EX_Zero;
wire [1:0] EX_ALUop;
wire [4:0] EX_RsIN,EX_RtIN, EX_RdIN, EX_SHAMTIN, EX_WriteRegOut;
wire [31:0] EX_ReadData1, EX_ReadData2, EX_ALUResult, EX_WriteDataOUT;
wire [31:0] EX_SignExtend;
wire [31:0] EX_PC_plus_4;
wire EX_isJAL;
//MEM
wire MEM_RegWrite, MEM_MemtoReg, MEM_Branch, MEM_ZERO;
wire [4:0] MEM_WriteREG;
wire [31:0] MEM_PC_plus_4;
wire MEM_isJAL;
//WB
wire [31:0] WB_WriteData;
//Forward
wire [1:0] ForwardA,ForwardB;

//new
wire	[5:0]	ID_Opcode,EX_Opcode;
wire	[15:0]	last_inst;

Ifetch				u_Ifetch		(			.clk(clk),
										.rst(rst),
										.Instruction(IF_Instruction),									
										.PCSrc(Branch_taken),
										.stall(Stall),
										.PC(PC),
										.Last_Inst(last_inst),
										.PC_plus_4(PC_plus_4),
										.Read_data1(ID_ReadData1)
									);
IF_IDreg			u_stage1		(			.clk(clk),
										.rst(rst),										
										.INST_RegIN(IF_Instruction),
										.INST_RegOUT(ID_instruction),
										.stall(Stall),
										.Branch_taken(Branch_taken),
										.PC_plus_4IN(PC_plus_4),
										.PC_plus_4OUT(ID_PC_plus_4)
									);
Idecode				u_Idecode		(		.clk(clk),
										.rst(rst),
										.WRITE_RegADDR(ID_WriteRegADDR),
										.MemtoReg_in(ID_MemtoRegIN),
										.RegWrite_in(ID_RegWriteIN),
										.Instruction(ID_instruction),
										.ALU_result(ID_ALUresult),
										.read_datain(ID_ReadDataIN),
										.RegWrite(ID_RegWrite),
										.MemtoReg(ID_MemtoReg),
										.Branch(ID_Branch),
										.MemRead(ID_MemRead),
										.MemWrite(ID_MemWrite),
										.RegDst(ID_RegDst),
										.ALUop(ID_ALUop),
										.ALUSrc(ID_ALUSrc),
										.Jump(IF_Jump),			
										.read_data1(ID_ReadData1),
										.read_data2(ID_ReadData2),
										.Sign_extend(ID_SignExtend),
										.INS_25to21(ID_INS25to21),
										.INS_20to16(ID_INS20to16),
										.INS_15to11(ID_INS15to11),
										.INS_10to6(ID_INS10to6),
										.stall(Stall),
										.branch_taken(Branch_taken),
										.Opcode (ID_Opcode),
										.Reg_S1(Reg_S1), 
										.Reg_S2(Reg_S2), 
										.Reg_S3(Reg_S3), 
										.Reg_S4(Reg_S4), 
										.Reg_S5(Reg_S5), 
										.Reg_S6(Reg_S6), 
										.Reg_S7(Reg_S7), 
										.Reg_S8(Reg_S8),
										.isJAL(ID_isJAL)
									);
ID_EXreg			u_stage2		(			.clk(clk),
										.rst(rst),										
										.OFFSET_IN(ID_SignExtend),
										.RS_ADDRIN(ID_INS25to21),
										.RT_ADDRIN(ID_INS20to16),
										.RD_ADDRIN(ID_INS15to11),
										.SHAME_ADDRIN(ID_INS10to6),
										.RS_IN(ID_ReadData1),
										.RT_IN(ID_ReadData2),
										.RegWrite(ID_RegWrite),
										.MemtoReg(ID_MemtoReg),
										.Branch(ID_Branch),
										.MemRead(ID_MemRead),
										.MemWrite(ID_MemWrite),
										.RegDst(ID_RegDst),
										.ALUop(ID_ALUop),
										.ALUSrc(ID_ALUSrc),										
										.OFFSET_OUT(EX_SignExtend),
										.RS_ADDROUT(EX_RsIN),		
										.RT_ADDROUT(EX_RtIN),
										.RD_ADDROUT(EX_RdIN),
										.SHAMT_ADDROUT(EX_SHAMTIN),
										.RS_OUT(EX_ReadData1),
										.RT_OUT(EX_ReadData2),
										.RegWrite_out(EX_RegWrite),
										.MemtoReg_out(EX_MemtoReg),
										.Branch_out(EX_Branch),
										.MemRead_out(EX_MemRead),
										.MemWrite_out(EX_MemWrite),
										.RegDst_out(EX_RegDst),
										.ALUop_out(EX_ALUop),
										.ALUSrc_out(EX_ALUSrc),
										.Opcode_in(ID_Opcode),
										.Opcode_out(EX_Opcode),
										.stall(Stall),
										.branch_taken(Branch_taken),
										.PC_plus_4IN(ID_PC_plus_4),
										.PC_plus_4OUT(EX_PC_plus_4),
										.isJALIN(ID_isJAL),
										.isJALOUT(EX_isJAL)

									);
Execute				u_Execute		(	.clk(clk),
										.rst(rst),
										.ALUop(EX_ALUop),
										.ALUSrc(EX_ALUSrc),
										.RegDst(EX_RegDst),										
										.Read_data1(EX_ReadData1),
										.Read_data2(EX_ReadData2),
										.Sign_extend(EX_SignExtend),
										.RT_IN(EX_RtIN),
										.RD_IN(EX_RdIN),										
										.Write_RegOUT(EX_WriteRegOut),
										.Write_DataOUT(EX_WriteDataOUT),
										.ALU_Result(EX_ALUResult),
										.Zero(EX_Zero),
										.EX_MEMALUResult(MEM_ADDRIN),
										.MEM_WBWriteDATA(WB_WriteData),
										.EXE_RS(EX_RsIN) ,
										.EXE_SHAMT(EX_SHAMTIN),
										.Ai(ForwardA),
										.Bi(ForwardB),
										.Opcode (EX_Opcode),
										.branch_taken (Branch_taken),
										.Last_inst(last_inst),
										.Branch(EX_Branch)
									);

EX_MEMreg		u_stage3		(	.clk(clk),
										.rst(rst),
										.RegWrite(EX_RegWrite),
										.MemtoReg(EX_MemtoReg),
										.Branch(EX_Branch),
										.MemRead(EX_MemRead),
										.MemWrite(EX_MemWrite),										
										.ZERO_IN(EX_Zero),
										.ALU_ResIN(EX_ALUResult),
										.RT_IN(EX_WriteDataOUT),
										.RTD_ADDRIN(EX_WriteRegOut),
										.RegWrite_out(MEM_RegWrite),
										.MemtoReg_out(MEM_MemtoReg),
										.Branch_out(MEM_Branch),
										.MemRead_out(MEM_MemRead),
										.MemWrite_out(MEM_MemWrite),										
										.ZERO_OUT(MEM_ZERO),
										.ALU_ResOUT(MEM_ADDRIN),
										.RT_OUT(MEM_WriteData),
										.RTD_ADDROUT(MEM_WriteREG),
										.PC_plus_4IN(EX_PC_plus_4),
										.PC_plus_4OUT(MEM_PC_plus_4),
										.isJALIN(EX_isJAL),
										.isJALOUT(MEM_isJAL)
									);
//memory_access(clk,reset,Branch,MemRead,MemWrite,ZERO,ADDRESS_IN,WRITE_DATA,READ_DATA_OUT,PCSrc,Mem_01,Mem_02,Mem_03,Mem_04,Mem_05);
memory_access		u_ACCESS		(				.clk(clk),
										.reset(rst),
										.Branch(MEM_Branch),
										.ZERO(MEM_ZERO),
										.PCSrc(IF_PCSrc)
									);
MEM_WBreg		u_stage4		(	.clk(clk),
										.rst(rst),
										.RegWrite(MEM_RegWrite),
										.MemtoReg(MEM_MemtoReg),
										.READ_DATA(MEM_ReadDataOUT),
										.ADDRESS(MEM_ADDRIN),
										.WRITE_REG(MEM_WriteREG),
										.RegWrite_out(ID_RegWriteIN),
										.MemtoReg_out(ID_MemtoRegIN),
										.READ_DataOUT(ID_ReadDataIN),
										.ADDRESS_OUT(ID_ALUresult),
										.WRITE_RegOUT(ID_WriteRegADDR),
										.write_data(WB_WriteData),
										.isJAL(MEM_isJAL),
										.PC_plus_4(MEM_PC_plus_4)
									);
Forwarding		u_Forwarding		(	
										.Ai(ForwardA),
										.Bi(ForwardB),
										.EX_MEMRegRD(MEM_WriteREG),
										.EXE_MEMRegWRITE(MEM_RegWrite),
										.MEM_WBRegRD(ID_WriteRegADDR),
										.MEM_WBWRITE(ID_RegWriteIN),	
										.ID_RS(EX_RsIN),
										.ID_RT(EX_RtIN)
									);

Hazard_detector	u_Hazard		(		
										.ID_Rt(EX_RtIN),
										.IF_Rs(ID_instruction[25:21]),
										.IF_Rt(ID_instruction[20:16]),
										.mem_read(EX_MemRead),
										.stall(Stall)
									);

endmodule
