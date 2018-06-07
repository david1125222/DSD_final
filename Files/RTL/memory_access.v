
module memory_access(clk,reset,Branch,ZERO,PCSrc);
	
	input clk,reset,Branch,ZERO;
	output PCSrc;

	reg PCSrc;

	
	always @(*) begin
		if (reset)
			PCSrc = 0;
		else
			PCSrc = (ZERO & Branch);
	end
	
endmodule
