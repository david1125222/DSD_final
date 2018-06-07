module ID_MUX(
		stall,
		RegWrite_in, MemtoReg_in, Branch_in, MemRead_in, MemWrite_in, ALUSrc_in, ALUop_in, RegDst_in,
		RegWrite_out, MemtoReg_out, Branch_out, MemRead_out, MemWrite_out, ALUSrc_out, ALUop_out, RegDst_out
																);	
input		stall;
input		RegWrite_in, MemtoReg_in, Branch_in, MemRead_in, MemWrite_in, ALUSrc_in, RegDst_in;
input	[1:0]	ALUop_in; 
output		RegWrite_out, MemtoReg_out, Branch_out, MemRead_out, MemWrite_out, ALUSrc_out, RegDst_out; 
output	[1:0]	ALUop_out;
reg		RegWrite_out, MemtoReg_out, Branch_out, MemRead_out, MemWrite_out, ALUSrc_out, RegDst_out;
reg	[1:0]	ALUop_out;
	
always @(*)	
begin 
	if(stall)	begin
		RegWrite_out = 1'b0;
		MemtoReg_out = 1'b0;
		Branch_out   = 1'b0;
		MemRead_out  = 1'b0;
		MemWrite_out = 1'b1;
		ALUSrc_out   = 1'b0;
		ALUop_out    = 2'b10;
		RegDst_out   = 1'b0;
	end
	else	begin	
		RegWrite_out = RegWrite_in;
		MemtoReg_out = MemtoReg_in;
		Branch_out   = Branch_in;
		MemRead_out  = MemRead_in;
		MemWrite_out = MemWrite_in;
		ALUSrc_out   = ALUSrc_in;
		ALUop_out    = ALUop_in;
		RegDst_out   = RegDst_in;
	end
end
endmodule 
