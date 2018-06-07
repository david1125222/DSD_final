module IF_IDreg(clk, rst, stall, INST_RegIN, INST_RegOUT,Branch_taken);

input clk,rst;
input stall,Branch_taken;	//new
input [31:0] INST_RegIN;

output [31:0] INST_RegOUT;

reg [31:0] INST_RegOUT;

always@(posedge clk or posedge rst)
begin
	if(rst) 
		INST_RegOUT <= 32'b0;

	else if(stall || Branch_taken)
		INST_RegOUT <= 32'b0;
	else 	
		INST_RegOUT <= INST_RegIN;
end
endmodule
