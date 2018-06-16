//-----------------------------------------------------------------------------
//
// This is a Booth recoded 32x32 multiplier producing a 64-bit product.
//
// Shift and add are done in the same cycle
//
//-----------------------------------------------------------------------------

module booth(
             iClk,      // input clock
             iReset_b,  // reset signal
             iGo,       // indicates inputs are ready
             oDone,     // indicates that the result is ready
             iMer,      // 32-bit multiplier
             iMand,     // 32-bit multiplicand
             oAns_hi,   // 32-bit product_lo
             oAns_lo    // 32-bit product_hi
             );

    input iClk,iReset_b,iGo;
    input [31:0] iMer,iMand;
    output oDone;
    output [31:0] oAns_hi, oAns_lo;


    // State names

    parameter	WaitForGoState = 2'd0,
		InitState = 2'd1,
		AddShiftState = 2'd2,
		DoneState = 2'd3;

    reg [1:0] PresentState, NextState;

    reg [1:0] NumShifts;

    reg [66:0] Product;
    reg [33:0] Sum;


//-----------------------------------------------------------------------------
//  This is the main FSM controller
//-----------------------------------------------------------------------------

    always @(iGo,PresentState,NumShifts)
        
    begin :  Controller
        case (PresentState)

            WaitForGoState:
                if (iGo)
                    NextState = InitState;
                else
                    NextState = WaitForGoState;

            InitState:
                NextState = AddShiftState;

            AddShiftState:
                if (NumShifts == 4'b0000)
                    NextState = DoneState;
                else
                    NextState = AddShiftState;

            DoneState:
                NextState = DoneState;

	    default:
		NextState = InitState;
        endcase //  PresentState
    end // Controller;
    


    always @(posedge iClk or negedge iReset_b)
    
    begin //  StateRegs
        if (!iReset_b)
            PresentState <= WaitForGoState;
        else
            PresentState <= NextState;
    end // StateRegs;


//-----------------------------------------------------------------------------
//  This does the addition of the appropriate version of the multiplicand
//-----------------------------------------------------------------------------

    reg [33:0] Mand1,Mand2;

    always @(Product,iMand)
        
    begin //  Adder
        Mand1 = {iMand[31],iMand[31],iMand};  // sign extend to 34 bits
        Mand2 = Mand1<<1;

        case (Product[2:0])
            3'b000:
                Sum = Product[66:33];
            3'b001:
                Sum = Product[66:33] + Mand1;
            3'b010:
                Sum = Product[66:33] + Mand1;
            3'b011:
                Sum = Product[66:33] + Mand2;
            3'b100:
                Sum = Product[66:33] - Mand2;
            3'b101:
                Sum = Product[66:33] - Mand1;
            3'b110:
                Sum = Product[66:33] - Mand1;
            default:
                Sum = Product[66:33];
        endcase  //  Product[2:0]
    end // Adder


//-----------------------------------------------------------------------------
//  This is the Product register and counter
//-----------------------------------------------------------------------------

    always @(posedge iClk)
        
    begin //  ProdReg
            case (PresentState)

                WaitForGoState:
		    ;
                InitState:
		  begin
                    Product[66:33] <= 34'd0;
                    Product[32:1] <= iMer;
                    Product[0] <= 1'b0;
                    NumShifts <= 4'b1111;
		  end

                AddShiftState:
		  begin
                    //---------------------------------------------------------
                    //  This takes the Sum, sign extends it to 36 bits and
                    //  puts that into the top part of the Product register,
                    //  effectively shifting it at the same time.  The bottom
                    //  part of the register is loaded with a shifted value of
                    //  the previous contents in that part.
                    //  The counter is also updated here.
                    //---------------------------------------------------------
                    Product[66:31] <= {Sum[33],Sum[33],Sum};
                    Product[30:0] <= Product[32:2];
                    NumShifts <= NumShifts - 4'b0001;
		  end
                DoneState:
		;
            endcase //  PresentState

    end //ProdReg;

    
//-----------------------------------------------------------------------------
//  The output product and done signal.
//-----------------------------------------------------------------------------

    assign oAns_hi = Product[64:33];
    assign oAns_lo = Product[32:1];

    assign oDone = (PresentState == DoneState) ? 1'b1:1'b0;

endmodule  // of booth
