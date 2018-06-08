module IF_IDreg(clk, rst, stall, INST_RegIN, INST_RegOUT,Branch_taken,PC_plus_4IN,PC_plus_4OUT);

input clk,rst;
input stall,Branch_taken;	//new
input [31:0] INST_RegIN;
input [31:0] PC_plus_4IN;
output [31:0] INST_RegOUT;
output [31:0] PC_plus_4OUT;
reg [31:0] INST_RegOUT;

always@(posedge clk or posedge rst)
begin
	if(rst) 
		INST_RegOUT <= 32'b0;
		PC_plus_4OUT <= 32'b0;
	else if(stall || Branch_taken)
		INST_RegOUT <= 32'b0;
		PC_plus_4OUT <= 32'b0;
	else 	
		INST_RegOUT <= INST_RegIN;
		PC_plus_4OUT <= PC_plus_4IN;
end
endmodule
