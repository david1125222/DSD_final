module dmemory(clk,reset,addr,Write_data,Read_data,MemRead,MemWrite);

	input clk,reset,MemRead,MemWrite;
	input [15:0]addr,Write_data;
	output [15:0]Read_data;
	reg [15:0] mem[1023:0];		//small for systhsis
	reg [15:0]Read_data; 

	always @(*) begin

		if (reset)	begin
			/*
			mem[0] <= 4'h0000;
			mem[1] <= 4'h0001;
			mem[2] <= 4'h0004;
			mem[3] <= 4'h0005;
			mem[4]	<= 4'h0044;
			mem[5] <= 4'h0022;
			mem[6] <= 4'h0088;
			mem[7] <= 4'h0011;
			mem[8] <= 4'h0077;
			*/
			/*
			mem[0] <= 4'h0000;
			mem[1] <= 4'h0000;
			mem[2] <= 4'h0000;
			mem[3] <= 4'h0000;
			mem[4]	<= 4'h0000;
			mem[5] <= 4'h0000;
			mem[6] <= 4'h0000;
			mem[7] <= 4'h0000;
			mem[8] <= 4'h0000;
			*/
		end
		else if (MemWrite && clk==0) begin		//clk=0 write
			mem[addr] = Write_data;
			Read_data = 0;
		end
		else if (MemRead)
			Read_data = mem[addr];
		else
			Read_data = 0;
	end
endmodule 

			
		
