module MEM_WBreg(clk,rst,RegWrite,MemtoReg,WRITE_REG,READ_DATA,ADDRESS,
						RegWrite_out,MemtoReg_out,WRITE_RegOUT,READ_DataOUT,ADDRESS_OUT,
				write_data,isJAL,PC_plus_4IN,isJAL		);
input clk,rst;
input RegWrite,MemtoReg;
input [4:0] WRITE_REG;
input [31:0] READ_DATA,ADDRESS;
input [31:0] PC_plus_4IN;
input isJAL;
output RegWrite_out,MemtoReg_out;
output [4:0] WRITE_RegOUT;
output [31:0] READ_DataOUT,ADDRESS_OUT;
output [31:0] write_data;
reg RegWrite_out,MemtoReg_out;
reg [4:0] WRITE_RegOUT;
reg [31:0] READ_DataOUT,ADDRESS_OUT;

assign write_data = (MemtoReg_out == 1'b0) ? ADDRESS_OUT:READ_DataOUT;

always@(posedge clk or posedge rst)
begin
	if(rst) 
	begin
		READ_DataOUT <= 32'b0;
		WRITE_RegOUT <= 5'b0;
		ADDRESS_OUT <= 32'b0;
		RegWrite_out <= 0;
		MemtoReg_out <= 0;
	end
	else begin
		READ_DataOUT <= READ_DATA;
		WRITE_RegOUT <= WRITE_REG;
		ADDRESS_OUT <= ADDRESS;
		//RegWrite_out <= RegWrite;
		MemtoReg_out <= MemtoReg;
		if(isJAL)RegWrite_out <= PC_plus_4IN;
		else RegWrite_out <= RegWrite;
	end
end
endmodule
