module control( clk,rst,Opcode,ALUop,Branch,Jump,
				RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite
				);
input clk,rst;
input [5:0] Opcode;
output [1:0] ALUop;
output RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite;
output Branch,Jump;

reg	[1:0] ALUop;
reg	RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite;
reg	Branch,Jump;

`define R_format 6'b000000
`define Lw 6'b100011
`define Sw 6'b101011
`define Beq 6'b000100 
`define Bne 6'b000101
`define ADDI 6'b001000
`define ORI 6'b001101
`define XORI 6'b001110 
`define J 6'b000010
/*
wire [1:0] ALUop;
wire RegDst = (Opcode ==`R_format) ? 1 : 0;
wire ALUSrc = (Opcode ==`Lw || Opcode ==`Sw) ? 1 : 0;
wire MemtoReg = (Opcode ==`Lw) ? 1 : 0;wire RegWrite = ((Opcode ==`R_format) || (Opcode ==`Lw)) ? 1 : 0;		
wire MemRead = (Opcode ==`Lw) ? 1 : 0;
wire MemWrite = (Opcode ==`Sw) ? 1 : 0;
wire Branch = (Opcode ==`Beq) ? 1 : 0;
wire Jump = (Opcode ==`J) ? 1 : 0;
//wire [1:0] ALUop = (Opcode ==`R_format) ? 2'b10 : 2'b01;
assign ALUop[1] = (Opcode ==`R_format) ? 1 : 0;
assign ALUop[0] = (Opcode ==`Beq) ? 1: 0;
*/
always@(*) begin
	case (Opcode)
		`R_format:begin
			RegDst = 1;
			ALUSrc = 0;
			MemtoReg = 0;
			RegWrite = 1;
			MemRead = 0;
			MemWrite = 0;
			Branch = 0;
			Jump = 0;
			ALUop = 2'b10;
		end
		`Lw:begin
			RegDst = 0;
			ALUSrc = 1;
			MemtoReg = 1;
			RegWrite = 1;
			MemRead = 1;
			MemWrite = 0;
			Branch = 0;
			Jump = 0;
			ALUop = 2'b00;
		end
		`Sw:begin
			RegDst = 0;
			ALUSrc = 1;
			MemtoReg = 0;
			RegWrite = 0;
			MemRead = 0;
			MemWrite = 1;	
			Branch = 0;
			Jump = 0;
			ALUop = 2'b00;
		end
		`ADDI:	begin
			RegDst = 0;
			ALUSrc = 1;
			MemtoReg = 0;
			RegWrite = 1;
			MemRead = 1;
			MemWrite = 0;	
			Branch = 0;
			Jump = 0;
			ALUop = 2'b00;
			end
		`ORI:	begin
			RegDst = 0;
			ALUSrc = 1;
			MemtoReg = 0;
			RegWrite = 1;
			MemRead = 1;
			MemWrite = 0;	
			Branch = 0;
			Jump = 0;
			ALUop = 2'b00;
			end
		`XORI:	begin
			RegDst = 0;
			ALUSrc = 1;
			MemtoReg = 0;
			RegWrite = 1;
			MemRead = 1;
			MemWrite = 0;	
			Branch = 0;
			Jump = 0;
			ALUop = 2'b00;
			end
		`Beq:	begin
			RegDst = 0;
			ALUSrc = 0;
			MemtoReg = 0;
			RegWrite = 0;
			MemRead = 0;
			MemWrite = 0;	
			Branch = 1;
			Jump = 0;
			ALUop = 2'b01;
			end
		`Bne:	begin
			RegDst = 0;
			ALUSrc = 0;
			MemtoReg = 0;
			RegWrite = 0;
			MemRead = 0;
			MemWrite = 0;	
			Branch = 1;
			Jump = 0;
			ALUop = 2'b01;
			end
		`J:	begin
			RegDst = 0;
			ALUSrc = 0;
			MemtoReg = 0;
			RegWrite = 0;
			MemRead = 0;
			MemWrite = 0;	
			Branch = 0;
			Jump = 1;
			ALUop = 2'b00;
			end
		default:begin
			RegDst = 0;
			ALUSrc = 0;
			MemtoReg = 0;
			RegWrite = 0;
			MemRead = 0;
			MemWrite = 0;	
			Branch = 0;
			Jump = 0;
			ALUop = 2'b00;
			end
	endcase
end
endmodule
