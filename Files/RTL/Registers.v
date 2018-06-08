module Registers(Read_register1,Read_register2,Write_register,Write_data,Read_data1,Read_data2,RegWrite,Reg_S1, Reg_S2, Reg_S3, Reg_S4, Reg_S5, Reg_S6, Reg_S7, Reg_S8,rst,isJAL);

	parameter MIP_BUS = 32;
	parameter NUM_REG = 32;
	input [4:0]Read_register1,Read_register2,Write_register;
	input [MIP_BUS-1:0]Write_data;
	input	RegWrite,rst,isJAL;                                  
	output	[MIP_BUS-1:0]Read_data1,Read_data2;
	output	[MIP_BUS-1:0]Reg_S1, Reg_S2, Reg_S3, Reg_S4, Reg_S5, Reg_S6, Reg_S7, Reg_S8;
	reg	[MIP_BUS-1:0]register_file[NUM_REG-1:0];
	integer count;
	wire Write_register_0;
	//show reg data	
	assign Reg_S1 = register_file[1];
	assign	Reg_S2 = register_file[2];
	assign	Reg_S3 = register_file[3];
	assign	Reg_S4 = register_file[4];
	assign	Reg_S5 = register_file[5];
	assign	Reg_S6 = register_file[6];
	assign	Reg_S7 = register_file[7];
	assign	Reg_S8 = register_file[8];
	//end reg data	

	assign Write_register_0 = isJAL ? 5'd31 : Write_register;

	assign Read_data1=register_file[Read_register1];
	assign Read_data2=register_file[Read_register2];
	always@(*)begin
		if (rst)	begin
			for(count=0;count<NUM_REG;count=count+1) begin
				register_file[count] = 32'b0;
			end
		end
//		else if(RegWrite_in ==1 && write_register_address != 0)
		else if(RegWrite ==1 )
			register_file[Write_register_0] = Write_data;

	end
endmodule
	
