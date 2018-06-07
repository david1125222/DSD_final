module Execute(	Read_data1,Read_data2,Sign_extend,RT_IN,RD_IN,ALUop,ALUSrc,RegDst,clk,rst,
				Zero,ALU_Result,Write_RegOUT,Write_DataOUT,	
				EX_MEMALUResult ,MEM_WBWriteDATA , EXE_RS ,EXE_SHAMT ,Ai ,Bi,
				Opcode ,branch_taken ,Last_inst,Branch//new
		);
	
	parameter MIPS_BUS=32;
	
	input	[MIPS_BUS-1:0]	Read_data1;
	input	[MIPS_BUS-1:0]	Read_data2;
	input	[31:0]			Sign_extend;
	input	[4:0]			RT_IN;
	input	[4:0]			RD_IN;
	input	[4:0]			EXE_RS ,EXE_SHAMT;
	input	[MIPS_BUS-1:0]	EX_MEMALUResult ,MEM_WBWriteDATA ;
	input	[1:0]			ALUop;
	input					ALUSrc;
	input					RegDst;
	input					clk, rst;
	input	[1:0]			Ai,Bi;				//forwarding
	input	[5:0]			Opcode;
	output					Zero;
	output	[MIPS_BUS-1:0]		ALU_Result;
	output	[4:0]				Write_RegOUT;
	output	[MIPS_BUS-1:0]		Write_DataOUT;
						
	reg	[MIPS_BUS-1:0]	ALU_OutputMUX;
	reg	[3:0]			ALU_ctl;
	reg	Zero;
	`define add 6'b100000	//
	`define AND_gate 6'b100100	//
	`define OR_gate  6'b100101	//
	`define SLL_gate 6'b000000	//
	`define sub 6'b100010	//
	`define SLT 6'b101010	//
	`define SRL_gate 6'b000010	//
	`define XOR_gate 6'b100110	//
	`define BIG 6'b111110  	//
	`define Special 6'b111111    //
	
	wire	[MIPS_BUS-1:0]	Ainput = (Ai!=2'b00) ? ( (Ai==2'b10) ? (EX_MEMALUResult):(MEM_WBWriteDATA) ) :(Read_data1);
	wire	[MIPS_BUS-1:0]	Binput_before = (Bi!=2'b00)?( (Bi==2'b10) ? (EX_MEMALUResult):(MEM_WBWriteDATA) ):Read_data2 ;	
	wire	[MIPS_BUS-1:0]	Binput = ((ALUSrc == 0) ? Binput_before :Sign_extend[MIPS_BUS-1:0]);
	wire	[5:0]	Function_opcode = Sign_extend[5:0];
	wire	[MIPS_BUS-1:0]	Write_DataOUT = (Bi!=2'b00)?( (Bi==2'b10) ? (EX_MEMALUResult):(MEM_WBWriteDATA) ):Read_data2 ;
	wire	[4:0]	Write_RegOUT = (RegDst == 1'b1) ? RD_IN : RT_IN;
	wire	[MIPS_BUS-1:0]	ALU_Result = ALU_OutputMUX[MIPS_BUS-1:0];
	
	//new
	input	Branch;
	output	branch_taken;
	output	[15:0] Last_inst;
	wire			Compare;
	wire	[1:0]		ALUop_muxin;
	wire			and1,and2;
	assign Compare = (Ainput == Binput) ?1 :0;
	assign branch_taken = and1 | and2;
	assign and1 = Branch && Compare && (Opcode== 6'b000100);
	assign and2 = Branch && (~Compare) && (Opcode== 6'b000101);
	assign	Last_inst = Sign_extend[15:0];
	
	always @(*)
	begin
		//for ALU control
		case (ALUop)
			2'b00:begin
				ALU_ctl = 4'b0010;
			end
			2'b01:begin
				ALU_ctl = 4'b0110;
			end
			2'b10:begin
				case	(Function_opcode)
					`add:	ALU_ctl = 4'b0010;
					`sub:	ALU_ctl = 4'b0110;
					`AND_gate: ALU_ctl = 4'b0000;
					`OR_gate: ALU_ctl = 4'b0001;
					`SLT:	ALU_ctl = 4'b0111;
					`SLL_gate: ALU_ctl = 4'b1000;
					`SRL_gate: ALU_ctl = 4'b1001;
					`XOR_gate: ALU_ctl = 4'b0011;
					`BIG: ALU_ctl = 4'b1010;
					`Special: ALU_ctl = 4'b1011;
				endcase	
			end
			default:ALU_ctl = 4'b0000; //new
		endcase
	end
	
	always @(*)
	begin
		case(ALU_ctl)
		4'b0000:	ALU_OutputMUX = Ainput & Binput;
		4'b0001:	ALU_OutputMUX = Ainput | Binput;
		4'b0010:	ALU_OutputMUX = Ainput + Binput;
		4'b0011:	ALU_OutputMUX = Ainput ^ Binput;
		4'b0100:	ALU_OutputMUX = ~(Ainput | Binput);
		4'b0101:	ALU_OutputMUX = 32'h0000;
		4'b0110:	ALU_OutputMUX = Ainput - Binput;
		4'b0111:	begin
					if(Ainput < Binput)
						ALU_OutputMUX = 32'h0001;
					else
						ALU_OutputMUX = 32'h0000;
				end
		4'b1000:	ALU_OutputMUX = Binput<<EXE_SHAMT;
		4'b1001:	ALU_OutputMUX = Binput>>EXE_SHAMT;
		4'b1010:	begin
					if(Ainput < Binput)
						ALU_OutputMUX = Binput;
					else
						ALU_OutputMUX = Ainput;
				end
		4'b1011:	begin
					if(Ainput < Binput)
						ALU_OutputMUX = Ainput + Binput;
					else
						ALU_OutputMUX = Ainput - Binput;
				end
		default:ALU_OutputMUX = 32'h0000;	
		endcase	

		if(ALU_OutputMUX == 32'h0000)
			Zero = 1'b1;
		else
			Zero = 1'b0;			
	end
	
	
	
endmodule 
