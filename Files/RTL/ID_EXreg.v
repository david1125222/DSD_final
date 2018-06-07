module ID_EXreg( clk,rst,RS_ADDRIN,RT_ADDRIN,RD_ADDRIN,SHAME_ADDRIN,RS_IN,RT_IN,
						OFFSET_IN,RegWrite,MemtoReg,Branch,MemRead,MemWrite,RegDst,ALUSrc,ALUop,RS_ADDROUT,
						RT_ADDROUT,RD_ADDROUT,SHAMT_ADDROUT,RS_OUT,RT_OUT,OFFSET_OUT,ALUop_out,
						RegWrite_out,MemtoReg_out,Branch_out,MemRead_out,MemWrite_out,RegDst_out,ALUSrc_out,
						Opcode_in,Opcode_out,stall,branch_taken		//new
						);
input clk,rst,branch_taken;
input [4:0] RS_ADDRIN,RT_ADDRIN,RD_ADDRIN,SHAME_ADDRIN;
input [31:0] RS_IN,RT_IN;
input [31:0] OFFSET_IN;
input RegWrite,MemtoReg,Branch,MemRead,MemWrite,RegDst,ALUSrc;
input [1:0] ALUop;
output [4:0] RS_ADDROUT,RT_ADDROUT,RD_ADDROUT,SHAMT_ADDROUT;
output [31:0] RS_OUT,RT_OUT;
output [31:0] OFFSET_OUT;
output RegWrite_out,MemtoReg_out,Branch_out,MemRead_out,MemWrite_out,RegDst_out,ALUSrc_out;
output [1:0] ALUop_out; 
reg [4:0] RS_ADDROUT,RT_ADDROUT,RD_ADDROUT,SHAMT_ADDROUT;
reg [31:0] RS_OUT,RT_OUT;
reg [31:0] OFFSET_OUT;
reg RegWrite_out,MemtoReg_out,Branch_out,MemRead_out,MemWrite_out,RegDst_out,ALUSrc_out;
reg [1:0] ALUop_out;
//new
input	[5:0]	Opcode_in;
output	[5:0]	Opcode_out;
reg	[5:0]	Opcode_out;
input	stall;

always@(posedge clk or posedge rst)
begin
	if(rst ) 
	begin
		OFFSET_OUT <= 32'b0;
		RT_ADDROUT <= 5'b0;
		RD_ADDROUT <= 5'b0;
		RS_OUT <= 32'b0;
		RT_OUT <= 32'b0;
		RegWrite_out <= 0;
		MemtoReg_out <= 0;
		Branch_out <= 0;
		MemRead_out <= 0;
		MemWrite_out <= 0;
		RegDst_out <= 0;
		ALUSrc_out <= 0;
		ALUop_out <= 2'b0;
		SHAMT_ADDROUT <= 0;
		RS_ADDROUT <= 0;
		Opcode_out <= 6'b0;		//new
	end
	else if(stall || branch_taken) 
	begin
		OFFSET_OUT <= 32'b0;
		RT_ADDROUT <= 5'b0;
		RD_ADDROUT <= 5'b0;
		RS_OUT <= 32'b0;
		RT_OUT <= 32'b0;
		RegWrite_out <= 0;
		MemtoReg_out <= 0;
		Branch_out <= 0;
		MemRead_out <= 0;
		MemWrite_out <= 0;
		RegDst_out <= 0;
		ALUSrc_out <= 0;
		ALUop_out <= 2'b0;
		SHAMT_ADDROUT <= 0;
		RS_ADDROUT <= 0;
		Opcode_out <= 6'b0;		//new
	end
	else begin
		OFFSET_OUT <= OFFSET_IN;
		RT_ADDROUT <= RT_ADDRIN;
		RD_ADDROUT <= RD_ADDRIN;
		RS_OUT <= RS_IN;
		RT_OUT <= RT_IN;
		RegWrite_out <= RegWrite;
		MemtoReg_out <= MemtoReg;
		Branch_out <= Branch;
		MemRead_out <= MemRead;
		MemWrite_out <= MemWrite;
		RegDst_out <= RegDst;
		ALUSrc_out <= ALUSrc;
		ALUop_out <= ALUop;
		SHAMT_ADDROUT <= SHAME_ADDRIN;
		RS_ADDROUT <= RS_ADDRIN;
		Opcode_out <= Opcode_in;	//new
	end
end
endmodule
