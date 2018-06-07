module Forwarding(	//output
			Ai,
			Bi,
			//input
			EX_MEMRegRD,
			EXE_MEMRegWRITE,
			MEM_WBRegRD,
			MEM_WBWRITE,	
			ID_RS,
			ID_RT
		);
	input	[4:0] EX_MEMRegRD , MEM_WBRegRD , ID_RS , ID_RT ;
	input	EXE_MEMRegWRITE,MEM_WBWRITE ;
	output	[1:0]Ai,Bi;
	reg	[1:0]Ai,Bi;
	always@(*)	begin
		//EX hazard
		if ( EXE_MEMRegWRITE && (EX_MEMRegRD!=5'd0) && (EX_MEMRegRD==ID_RS) )
			Ai = 2'b10;
		//MEM hazard
		else if ( MEM_WBWRITE && (MEM_WBRegRD!=5'd0) && (MEM_WBRegRD==ID_RS) )
			Ai = 2'b01;
		else
			Ai = 2'b00;
		//EX hazard
		if ( EXE_MEMRegWRITE && (EX_MEMRegRD!=5'd0) && (EX_MEMRegRD==ID_RT) )
			Bi = 2'b10;
		//MEM hazard
		else if ( MEM_WBWRITE && (MEM_WBRegRD!=5'd0) && (MEM_WBRegRD==ID_RT) )
			Bi = 2'b01;		
		else
			Bi = 2'b00;
	end
endmodule
