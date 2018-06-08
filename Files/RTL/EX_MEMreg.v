module EX_MEMreg(clk,rst,RTD_ADDRIN,ALU_ResIN,RT_IN,
						RegWrite,MemtoReg,Branch,MemRead,MemWrite,ZERO_IN,
						RTD_ADDROUT,ALU_ResOUT,RT_OUT,
						RegWrite_out,MemtoReg_out,Branch_out,MemRead_out,MemWrite_out,ZERO_OUT,PC_plus_4IN,PC_plus_4OUT,
						isJALIN,isJALOUT);
input clk,rst;
input [4:0] RTD_ADDRIN;
input [31:0] ALU_ResIN,RT_IN,PC_plus_4IN;
input RegWrite,MemtoReg,Branch,MemRead,MemWrite,ZERO_IN;
input isJALIN;
output [4:0] RTD_ADDROUT;
output [31:0] ALU_ResOUT,RT_OUT,PC_plus_4OUT;
output RegWrite_out,MemtoReg_out,Branch_out,MemRead_out,MemWrite_out,ZERO_OUT;
output isJALOUT;
reg [4:0] RTD_ADDROUT;
reg [31:0] ALU_ResOUT,RT_OUT;
reg RegWrite_out,MemtoReg_out,Branch_out,MemRead_out,MemWrite_out,ZERO_OUT;

always@(posedge clk or posedge rst)
begin
	if(rst) 
	begin
		RTD_ADDROUT <= 5'b0;
		ALU_ResOUT <= 32'b0;
		RT_OUT <= 32'b0;
		RegWrite_out <= 0;
		MemtoReg_out <= 0;
		Branch_out <= 0;
		MemRead_out <= 0;
		MemWrite_out <= 0;
		ZERO_OUT <= 0;
		PC_plus_4OUT <= 0;
		isJALOUT <= 0;
	end
	else begin
		RTD_ADDROUT <= RTD_ADDRIN;
		ALU_ResOUT <= ALU_ResIN;
		RT_OUT <= RT_IN;
		RegWrite_out <= RegWrite;
		MemtoReg_out <= MemtoReg;
		Branch_out <= Branch;
		MemRead_out <= MemRead;
		MemWrite_out <= MemWrite;
		ZERO_OUT <= ZERO_IN;
		PC_plus_4OUT <= PC_plus_4IN;
		isJALOUT <= isJALIN;
	end
end
endmodule
