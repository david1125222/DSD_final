module instmemory(addr,read_data);
	input [15:0]addr;
	output [31:0]read_data;
	reg [31:0] mem[1023:0];		//small for systhsis
	reg [31:0]read_data;
	
	always @(*) begin
		read_data = mem[addr];
	end
endmodule
			
