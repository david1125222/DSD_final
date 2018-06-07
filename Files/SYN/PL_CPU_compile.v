
module Ifetch_DW01_inc_0 ( A, SUM );
  input [15:0] A;
  output [15:0] SUM;

  wire   [15:2] carry;

  ADDHXL U1_1_14 ( .A(A[14]), .B(carry[14]), .CO(carry[15]), .S(SUM[14]) );
  ADDHXL U1_1_13 ( .A(A[13]), .B(carry[13]), .CO(carry[14]), .S(SUM[13]) );
  ADDHXL U1_1_12 ( .A(A[12]), .B(carry[12]), .CO(carry[13]), .S(SUM[12]) );
  ADDHXL U1_1_11 ( .A(A[11]), .B(carry[11]), .CO(carry[12]), .S(SUM[11]) );
  ADDHXL U1_1_8 ( .A(A[8]), .B(carry[8]), .CO(carry[9]), .S(SUM[8]) );
  ADDHXL U1_1_7 ( .A(A[7]), .B(carry[7]), .CO(carry[8]), .S(SUM[7]) );
  ADDHXL U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHXL U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHXL U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHXL U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHXL U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHXL U1_1_9 ( .A(A[9]), .B(carry[9]), .CO(carry[10]), .S(SUM[9]) );
  ADDHXL U1_1_10 ( .A(A[10]), .B(carry[10]), .CO(carry[11]), .S(SUM[10]) );
  ADDHXL U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  XOR2X1 U1 ( .A(carry[15]), .B(A[15]), .Y(SUM[15]) );
  INVX1 U2 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module Ifetch_DW01_dec_0 ( A, SUM );
  input [15:0] A;
  output [15:0] SUM;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16
;

  OR2X2 U1 ( .A(A[1]), .B(A[0]), .Y(n11) );
  INVX1 U2 ( .A(A[10]), .Y(n1) );
  INVX1 U3 ( .A(n2), .Y(SUM[9]) );
  AOI21X1 U4 ( .A0(n3), .A1(A[9]), .B0(n4), .Y(n2) );
  OAI2BB1X1 U5 ( .A0N(n5), .A1N(A[8]), .B0(n3), .Y(SUM[8]) );
  OAI2BB1X1 U6 ( .A0N(n6), .A1N(A[7]), .B0(n5), .Y(SUM[7]) );
  OAI2BB1X1 U7 ( .A0N(n7), .A1N(A[6]), .B0(n6), .Y(SUM[6]) );
  OAI2BB1X1 U8 ( .A0N(n8), .A1N(A[5]), .B0(n7), .Y(SUM[5]) );
  OAI2BB1X1 U9 ( .A0N(n9), .A1N(A[4]), .B0(n8), .Y(SUM[4]) );
  OAI2BB1X1 U10 ( .A0N(n10), .A1N(A[3]), .B0(n9), .Y(SUM[3]) );
  OAI2BB1X1 U11 ( .A0N(n11), .A1N(A[2]), .B0(n10), .Y(SUM[2]) );
  OAI2BB1X1 U12 ( .A0N(A[0]), .A1N(A[1]), .B0(n11), .Y(SUM[1]) );
  XOR2X1 U13 ( .A(A[15]), .B(n12), .Y(SUM[15]) );
  NOR2X1 U14 ( .A(A[14]), .B(n13), .Y(n12) );
  XNOR2X1 U15 ( .A(A[14]), .B(n13), .Y(SUM[14]) );
  OAI2BB1X1 U16 ( .A0N(n14), .A1N(A[13]), .B0(n13), .Y(SUM[13]) );
  OR2X1 U17 ( .A(n14), .B(A[13]), .Y(n13) );
  OAI2BB1X1 U18 ( .A0N(n15), .A1N(A[12]), .B0(n14), .Y(SUM[12]) );
  OR2X1 U19 ( .A(n15), .B(A[12]), .Y(n14) );
  OAI2BB1X1 U20 ( .A0N(n16), .A1N(A[11]), .B0(n15), .Y(SUM[11]) );
  OR2X1 U21 ( .A(n16), .B(A[11]), .Y(n15) );
  OAI21XL U22 ( .A0(n4), .A1(n1), .B0(n16), .Y(SUM[10]) );
  NAND2X1 U23 ( .A(n4), .B(n1), .Y(n16) );
  NOR2X1 U24 ( .A(n3), .B(A[9]), .Y(n4) );
  OR2X1 U25 ( .A(n5), .B(A[8]), .Y(n3) );
  OR2X1 U26 ( .A(n6), .B(A[7]), .Y(n5) );
  OR2X1 U27 ( .A(n7), .B(A[6]), .Y(n6) );
  OR2X1 U28 ( .A(n8), .B(A[5]), .Y(n7) );
  OR2X1 U29 ( .A(n9), .B(A[4]), .Y(n8) );
  OR2X1 U30 ( .A(n10), .B(A[3]), .Y(n9) );
  OR2X1 U31 ( .A(n11), .B(A[2]), .Y(n10) );
  INVX1 U32 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module Ifetch_DW01_dec_1 ( A, SUM );
  input [15:0] A;
  output [15:0] SUM;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16
;

  OR2X2 U1 ( .A(A[1]), .B(A[0]), .Y(n11) );
  INVX1 U2 ( .A(A[10]), .Y(n1) );
  INVX1 U3 ( .A(n2), .Y(SUM[9]) );
  AOI21X1 U4 ( .A0(n3), .A1(A[9]), .B0(n4), .Y(n2) );
  OAI2BB1X1 U5 ( .A0N(n5), .A1N(A[8]), .B0(n3), .Y(SUM[8]) );
  OAI2BB1X1 U6 ( .A0N(n6), .A1N(A[7]), .B0(n5), .Y(SUM[7]) );
  OAI2BB1X1 U7 ( .A0N(n7), .A1N(A[6]), .B0(n6), .Y(SUM[6]) );
  OAI2BB1X1 U8 ( .A0N(n8), .A1N(A[5]), .B0(n7), .Y(SUM[5]) );
  OAI2BB1X1 U9 ( .A0N(n9), .A1N(A[4]), .B0(n8), .Y(SUM[4]) );
  OAI2BB1X1 U10 ( .A0N(n10), .A1N(A[3]), .B0(n9), .Y(SUM[3]) );
  OAI2BB1X1 U11 ( .A0N(n11), .A1N(A[2]), .B0(n10), .Y(SUM[2]) );
  OAI2BB1X1 U12 ( .A0N(A[0]), .A1N(A[1]), .B0(n11), .Y(SUM[1]) );
  XOR2X1 U13 ( .A(A[15]), .B(n12), .Y(SUM[15]) );
  NOR2X1 U14 ( .A(A[14]), .B(n13), .Y(n12) );
  XNOR2X1 U15 ( .A(A[14]), .B(n13), .Y(SUM[14]) );
  OAI2BB1X1 U16 ( .A0N(n14), .A1N(A[13]), .B0(n13), .Y(SUM[13]) );
  OR2X1 U17 ( .A(n14), .B(A[13]), .Y(n13) );
  OAI2BB1X1 U18 ( .A0N(n15), .A1N(A[12]), .B0(n14), .Y(SUM[12]) );
  OR2X1 U19 ( .A(n15), .B(A[12]), .Y(n14) );
  OAI2BB1X1 U20 ( .A0N(n16), .A1N(A[11]), .B0(n15), .Y(SUM[11]) );
  OR2X1 U21 ( .A(n16), .B(A[11]), .Y(n15) );
  OAI21XL U22 ( .A0(n4), .A1(n1), .B0(n16), .Y(SUM[10]) );
  NAND2X1 U23 ( .A(n4), .B(n1), .Y(n16) );
  NOR2X1 U24 ( .A(n3), .B(A[9]), .Y(n4) );
  OR2X1 U25 ( .A(n5), .B(A[8]), .Y(n3) );
  OR2X1 U26 ( .A(n6), .B(A[7]), .Y(n5) );
  OR2X1 U27 ( .A(n7), .B(A[6]), .Y(n6) );
  OR2X1 U28 ( .A(n8), .B(A[5]), .Y(n7) );
  OR2X1 U29 ( .A(n9), .B(A[4]), .Y(n8) );
  OR2X1 U30 ( .A(n10), .B(A[3]), .Y(n9) );
  OR2X1 U31 ( .A(n11), .B(A[2]), .Y(n10) );
  INVX1 U32 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module Ifetch_DW01_add_0 ( A, B, CI, SUM, CO );
  input [15:0] A;
  input [15:0] B;
  output [15:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [15:2] carry;

  ADDFX2 U1_14 ( .A(A[14]), .B(B[14]), .CI(carry[14]), .CO(carry[15]), .S(
        SUM[14]) );
  ADDFX2 U1_11 ( .A(A[11]), .B(B[11]), .CI(carry[11]), .CO(carry[12]), .S(
        SUM[11]) );
  ADDFX2 U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(carry[8]), .S(SUM[7])
         );
  ADDFX2 U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFX2 U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFX2 U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFX2 U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFX2 U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFX2 U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  ADDFX2 U1_10 ( .A(A[10]), .B(B[10]), .CI(carry[10]), .CO(carry[11]), .S(
        SUM[10]) );
  ADDFX2 U1_9 ( .A(A[9]), .B(B[9]), .CI(carry[9]), .CO(carry[10]), .S(SUM[9])
         );
  ADDFX2 U1_13 ( .A(A[13]), .B(B[13]), .CI(carry[13]), .CO(carry[14]), .S(
        SUM[13]) );
  ADDFX2 U1_8 ( .A(A[8]), .B(B[8]), .CI(carry[8]), .CO(carry[9]), .S(SUM[8])
         );
  ADDFX2 U1_12 ( .A(A[12]), .B(B[12]), .CI(carry[12]), .CO(carry[13]), .S(
        SUM[12]) );
  XOR3X2 U1_15 ( .A(A[15]), .B(B[15]), .C(carry[15]), .Y(SUM[15]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module Ifetch ( clk, rst, PCSrc, stall, Instruction, PC, Last_Inst );
  input [31:0] Instruction;
  output [15:0] PC;
  input [15:0] Last_Inst;
  input clk, rst, PCSrc, stall;
  wire   N21, N22, N23, N24, N25, N26, N27, N28, N29, N30, N31, N32, N33, N34,
         N35, N36, N37, N38, N39, N40, N41, N42, N43, N44, N45, N46, N47, N48,
         N49, N50, N51, N52, n5, n6, n8, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, N9, N8,
         N7, N6, N5, N4, N3, N2, N16, N15, N14, N13, N12, N11, N10, N1, n1, n2,
         n3, n4, n7, n9;
  wire   [15:0] Branch_result;
  wire   [15:0] next_PC;

  Ifetch_DW01_inc_0 add_37 ( .A(PC), .SUM({N52, N51, N50, N49, N48, N47, N46, 
        N45, N44, N43, N42, N41, N40, N39, N38, N37}) );
  Ifetch_DW01_dec_0 sub_35 ( .A(PC), .SUM({N36, N35, N34, N33, N32, N31, N30, 
        N29, N28, N27, N26, N25, N24, N23, N22, N21}) );
  Ifetch_DW01_dec_1 sub_1_root_sub_0_root_sub_24 ( .A(PC), .SUM({N16, N15, N14, 
        N13, N12, N11, N10, N9, N8, N7, N6, N5, N4, N3, N2, N1}) );
  Ifetch_DW01_add_0 add_0_root_sub_0_root_sub_24 ( .A(Last_Inst), .B({N16, N15, 
        N14, N13, N12, N11, N10, N9, N8, N7, N6, N5, N4, N3, N2, N1}), .CI(
        1'b0), .SUM(Branch_result) );
  DFFRHQX1 PC_reg_15_ ( .D(next_PC[15]), .CK(clk), .RN(n7), .Q(PC[15]) );
  DFFRHQX1 PC_reg_13_ ( .D(next_PC[13]), .CK(clk), .RN(n7), .Q(PC[13]) );
  DFFRHQX1 PC_reg_14_ ( .D(next_PC[14]), .CK(clk), .RN(n7), .Q(PC[14]) );
  DFFRHQX1 PC_reg_3_ ( .D(next_PC[3]), .CK(clk), .RN(n7), .Q(PC[3]) );
  DFFRHQX1 PC_reg_4_ ( .D(next_PC[4]), .CK(clk), .RN(n7), .Q(PC[4]) );
  DFFRHQX1 PC_reg_5_ ( .D(next_PC[5]), .CK(clk), .RN(n7), .Q(PC[5]) );
  DFFRHQX1 PC_reg_6_ ( .D(next_PC[6]), .CK(clk), .RN(n7), .Q(PC[6]) );
  DFFRHQX1 PC_reg_7_ ( .D(next_PC[7]), .CK(clk), .RN(n7), .Q(PC[7]) );
  DFFRHQX1 PC_reg_8_ ( .D(next_PC[8]), .CK(clk), .RN(n7), .Q(PC[8]) );
  DFFRHQX1 PC_reg_11_ ( .D(next_PC[11]), .CK(clk), .RN(n7), .Q(PC[11]) );
  DFFRHQX1 PC_reg_12_ ( .D(next_PC[12]), .CK(clk), .RN(n7), .Q(PC[12]) );
  DFFRHQX1 PC_reg_9_ ( .D(next_PC[9]), .CK(clk), .RN(n7), .Q(PC[9]) );
  DFFRHQX1 PC_reg_10_ ( .D(next_PC[10]), .CK(clk), .RN(n7), .Q(PC[10]) );
  DFFRHQX1 PC_reg_1_ ( .D(next_PC[1]), .CK(clk), .RN(n7), .Q(PC[1]) );
  DFFRHQX1 PC_reg_2_ ( .D(next_PC[2]), .CK(clk), .RN(n7), .Q(PC[2]) );
  DFFRHQX1 PC_reg_0_ ( .D(next_PC[0]), .CK(clk), .RN(n7), .Q(PC[0]) );
  NOR2X1 U3 ( .A(n40), .B(n3), .Y(n1) );
  NOR3X1 U4 ( .A(n3), .B(stall), .C(n9), .Y(n2) );
  BUFX3 U5 ( .A(PCSrc), .Y(n3) );
  BUFX3 U6 ( .A(n8), .Y(n4) );
  NOR3BX1 U7 ( .AN(stall), .B(n9), .C(n3), .Y(n8) );
  INVX1 U8 ( .A(n40), .Y(n9) );
  NAND2X1 U9 ( .A(n36), .B(n37), .Y(next_PC[10]) );
  AOI22X1 U10 ( .A0(Instruction[10]), .A1(n1), .B0(Branch_result[10]), .B1(n3), 
        .Y(n36) );
  AOI22X1 U11 ( .A0(N47), .A1(n2), .B0(N31), .B1(n4), .Y(n37) );
  NAND2X1 U12 ( .A(n30), .B(n31), .Y(next_PC[13]) );
  AOI22X1 U13 ( .A0(Instruction[13]), .A1(n1), .B0(Branch_result[13]), .B1(n3), 
        .Y(n30) );
  AOI22X1 U14 ( .A0(N50), .A1(n2), .B0(N34), .B1(n4), .Y(n31) );
  NAND2X1 U15 ( .A(n10), .B(n11), .Y(next_PC[8]) );
  AOI22X1 U16 ( .A0(Instruction[8]), .A1(n1), .B0(Branch_result[8]), .B1(n3), 
        .Y(n10) );
  AOI22X1 U17 ( .A0(N45), .A1(n2), .B0(N29), .B1(n4), .Y(n11) );
  NAND2X1 U18 ( .A(n32), .B(n33), .Y(next_PC[12]) );
  AOI22X1 U19 ( .A0(Instruction[12]), .A1(n1), .B0(Branch_result[12]), .B1(n3), 
        .Y(n32) );
  AOI22X1 U20 ( .A0(N49), .A1(n2), .B0(N33), .B1(n4), .Y(n33) );
  NAND2X1 U21 ( .A(n34), .B(n35), .Y(next_PC[11]) );
  AOI22X1 U22 ( .A0(Instruction[11]), .A1(n1), .B0(Branch_result[11]), .B1(n3), 
        .Y(n34) );
  AOI22X1 U23 ( .A0(N48), .A1(n2), .B0(N32), .B1(n4), .Y(n35) );
  NAND2X1 U24 ( .A(n12), .B(n13), .Y(next_PC[7]) );
  AOI22X1 U25 ( .A0(Instruction[7]), .A1(n1), .B0(Branch_result[7]), .B1(n3), 
        .Y(n12) );
  AOI22X1 U26 ( .A0(N44), .A1(n2), .B0(N28), .B1(n4), .Y(n13) );
  NAND2X1 U27 ( .A(n14), .B(n15), .Y(next_PC[6]) );
  AOI22X1 U28 ( .A0(Instruction[6]), .A1(n1), .B0(Branch_result[6]), .B1(n3), 
        .Y(n14) );
  AOI22X1 U29 ( .A0(N43), .A1(n2), .B0(N27), .B1(n4), .Y(n15) );
  NAND2X1 U30 ( .A(n16), .B(n17), .Y(next_PC[5]) );
  AOI22X1 U31 ( .A0(Instruction[5]), .A1(n1), .B0(Branch_result[5]), .B1(n3), 
        .Y(n16) );
  AOI22X1 U32 ( .A0(N42), .A1(n2), .B0(N26), .B1(n4), .Y(n17) );
  NAND2X1 U33 ( .A(n18), .B(n19), .Y(next_PC[4]) );
  AOI22X1 U34 ( .A0(Instruction[4]), .A1(n1), .B0(Branch_result[4]), .B1(n3), 
        .Y(n18) );
  AOI22X1 U35 ( .A0(N41), .A1(n2), .B0(N25), .B1(n4), .Y(n19) );
  NAND2X1 U36 ( .A(n20), .B(n21), .Y(next_PC[3]) );
  AOI22X1 U37 ( .A0(Instruction[3]), .A1(n1), .B0(Branch_result[3]), .B1(n3), 
        .Y(n20) );
  AOI22X1 U38 ( .A0(N40), .A1(n2), .B0(N24), .B1(n4), .Y(n21) );
  NAND2X1 U39 ( .A(n22), .B(n23), .Y(next_PC[2]) );
  AOI22X1 U40 ( .A0(Instruction[2]), .A1(n1), .B0(Branch_result[2]), .B1(n3), 
        .Y(n22) );
  AOI22X1 U41 ( .A0(N39), .A1(n2), .B0(N23), .B1(n4), .Y(n23) );
  NAND2X1 U42 ( .A(n24), .B(n25), .Y(next_PC[1]) );
  AOI22X1 U43 ( .A0(Instruction[1]), .A1(n1), .B0(Branch_result[1]), .B1(n3), 
        .Y(n24) );
  AOI22X1 U44 ( .A0(N38), .A1(n2), .B0(N22), .B1(n4), .Y(n25) );
  NAND2X1 U45 ( .A(n38), .B(n39), .Y(next_PC[0]) );
  AOI22X1 U46 ( .A0(Instruction[0]), .A1(n1), .B0(Branch_result[0]), .B1(n3), 
        .Y(n38) );
  AOI22X1 U47 ( .A0(N37), .A1(n2), .B0(N21), .B1(n4), .Y(n39) );
  NAND2X1 U48 ( .A(n28), .B(n29), .Y(next_PC[14]) );
  AOI22X1 U49 ( .A0(Instruction[14]), .A1(n1), .B0(Branch_result[14]), .B1(n3), 
        .Y(n28) );
  AOI22X1 U50 ( .A0(N51), .A1(n2), .B0(N35), .B1(n4), .Y(n29) );
  NAND2X1 U51 ( .A(n26), .B(n27), .Y(next_PC[15]) );
  AOI22X1 U52 ( .A0(Instruction[15]), .A1(n1), .B0(Branch_result[15]), .B1(n3), 
        .Y(n26) );
  AOI22X1 U53 ( .A0(N52), .A1(n2), .B0(N36), .B1(n4), .Y(n27) );
  NAND2X1 U54 ( .A(n5), .B(n6), .Y(next_PC[9]) );
  AOI22X1 U55 ( .A0(Instruction[9]), .A1(n1), .B0(n3), .B1(Branch_result[9]), 
        .Y(n5) );
  AOI22X1 U56 ( .A0(N46), .A1(n2), .B0(N30), .B1(n4), .Y(n6) );
  NAND3X1 U57 ( .A(n41), .B(Instruction[27]), .C(n42), .Y(n40) );
  NOR2X1 U58 ( .A(Instruction[28]), .B(Instruction[26]), .Y(n41) );
  NOR3X1 U59 ( .A(Instruction[29]), .B(Instruction[31]), .C(Instruction[30]), 
        .Y(n42) );
  INVX1 U60 ( .A(rst), .Y(n7) );
endmodule


module IF_IDreg ( clk, rst, stall, INST_RegIN, INST_RegOUT, Branch_taken );
  input [31:0] INST_RegIN;
  output [31:0] INST_RegOUT;
  input clk, rst, stall, Branch_taken;
  wire   N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17,
         N18, N19, N20, N21, N22, N23, N24, N25, N26, N27, N28, N29, N30, N31,
         N32, N33, N34, n1, n2;

  DFFRHQX1 INST_RegOUT_reg_15_ ( .D(N18), .CK(clk), .RN(n2), .Q(
        INST_RegOUT[15]) );
  DFFRHQX1 INST_RegOUT_reg_14_ ( .D(N17), .CK(clk), .RN(n2), .Q(
        INST_RegOUT[14]) );
  DFFRHQX1 INST_RegOUT_reg_13_ ( .D(N16), .CK(clk), .RN(n2), .Q(
        INST_RegOUT[13]) );
  DFFRHQX1 INST_RegOUT_reg_12_ ( .D(N15), .CK(clk), .RN(n2), .Q(
        INST_RegOUT[12]) );
  DFFRHQX1 INST_RegOUT_reg_11_ ( .D(N14), .CK(clk), .RN(n2), .Q(
        INST_RegOUT[11]) );
  DFFRHQX1 INST_RegOUT_reg_10_ ( .D(N13), .CK(clk), .RN(n2), .Q(
        INST_RegOUT[10]) );
  DFFRHQX1 INST_RegOUT_reg_9_ ( .D(N12), .CK(clk), .RN(n2), .Q(INST_RegOUT[9])
         );
  DFFRHQX1 INST_RegOUT_reg_8_ ( .D(N11), .CK(clk), .RN(n2), .Q(INST_RegOUT[8])
         );
  DFFRHQX1 INST_RegOUT_reg_7_ ( .D(N10), .CK(clk), .RN(n2), .Q(INST_RegOUT[7])
         );
  DFFRHQX1 INST_RegOUT_reg_5_ ( .D(N8), .CK(clk), .RN(n2), .Q(INST_RegOUT[5])
         );
  DFFRHQX1 INST_RegOUT_reg_4_ ( .D(N7), .CK(clk), .RN(n2), .Q(INST_RegOUT[4])
         );
  DFFRHQX1 INST_RegOUT_reg_3_ ( .D(N6), .CK(clk), .RN(n2), .Q(INST_RegOUT[3])
         );
  DFFRHQX1 INST_RegOUT_reg_2_ ( .D(N5), .CK(clk), .RN(n2), .Q(INST_RegOUT[2])
         );
  DFFRHQX1 INST_RegOUT_reg_1_ ( .D(N4), .CK(clk), .RN(n2), .Q(INST_RegOUT[1])
         );
  DFFRHQX1 INST_RegOUT_reg_0_ ( .D(N3), .CK(clk), .RN(n2), .Q(INST_RegOUT[0])
         );
  DFFRHQX1 INST_RegOUT_reg_6_ ( .D(N9), .CK(clk), .RN(n2), .Q(INST_RegOUT[6])
         );
  DFFRHQX1 INST_RegOUT_reg_26_ ( .D(N29), .CK(clk), .RN(n2), .Q(
        INST_RegOUT[26]) );
  DFFRHQX1 INST_RegOUT_reg_28_ ( .D(N31), .CK(clk), .RN(n2), .Q(
        INST_RegOUT[28]) );
  DFFRHQX1 INST_RegOUT_reg_30_ ( .D(N33), .CK(clk), .RN(n2), .Q(
        INST_RegOUT[30]) );
  DFFRHQX1 INST_RegOUT_reg_27_ ( .D(N30), .CK(clk), .RN(n2), .Q(
        INST_RegOUT[27]) );
  DFFRHQX1 INST_RegOUT_reg_31_ ( .D(N34), .CK(clk), .RN(n2), .Q(
        INST_RegOUT[31]) );
  DFFRHQX1 INST_RegOUT_reg_29_ ( .D(N32), .CK(clk), .RN(n2), .Q(
        INST_RegOUT[29]) );
  DFFRHQX1 INST_RegOUT_reg_22_ ( .D(N25), .CK(clk), .RN(n2), .Q(
        INST_RegOUT[22]) );
  DFFRHQX1 INST_RegOUT_reg_21_ ( .D(N24), .CK(clk), .RN(n2), .Q(
        INST_RegOUT[21]) );
  DFFRHQX1 INST_RegOUT_reg_17_ ( .D(N20), .CK(clk), .RN(n2), .Q(
        INST_RegOUT[17]) );
  DFFRHQX1 INST_RegOUT_reg_16_ ( .D(N19), .CK(clk), .RN(n2), .Q(
        INST_RegOUT[16]) );
  DFFRHQX1 INST_RegOUT_reg_25_ ( .D(N28), .CK(clk), .RN(n2), .Q(
        INST_RegOUT[25]) );
  DFFRHQX1 INST_RegOUT_reg_20_ ( .D(N23), .CK(clk), .RN(n2), .Q(
        INST_RegOUT[20]) );
  DFFRHQX1 INST_RegOUT_reg_24_ ( .D(N27), .CK(clk), .RN(n2), .Q(
        INST_RegOUT[24]) );
  DFFRHQX1 INST_RegOUT_reg_23_ ( .D(N26), .CK(clk), .RN(n2), .Q(
        INST_RegOUT[23]) );
  DFFRHQX1 INST_RegOUT_reg_19_ ( .D(N22), .CK(clk), .RN(n2), .Q(
        INST_RegOUT[19]) );
  DFFRHQX1 INST_RegOUT_reg_18_ ( .D(N21), .CK(clk), .RN(n2), .Q(
        INST_RegOUT[18]) );
  OR2X2 U3 ( .A(Branch_taken), .B(stall), .Y(n1) );
  NOR2BX1 U4 ( .AN(INST_RegIN[0]), .B(n1), .Y(N3) );
  NOR2BX1 U5 ( .AN(INST_RegIN[1]), .B(n1), .Y(N4) );
  NOR2BX1 U6 ( .AN(INST_RegIN[2]), .B(n1), .Y(N5) );
  NOR2BX1 U7 ( .AN(INST_RegIN[3]), .B(n1), .Y(N6) );
  NOR2BX1 U8 ( .AN(INST_RegIN[4]), .B(n1), .Y(N7) );
  NOR2BX1 U9 ( .AN(INST_RegIN[5]), .B(n1), .Y(N8) );
  NOR2BX1 U10 ( .AN(INST_RegIN[6]), .B(n1), .Y(N9) );
  NOR2BX1 U11 ( .AN(INST_RegIN[13]), .B(n1), .Y(N16) );
  NOR2BX1 U12 ( .AN(INST_RegIN[14]), .B(n1), .Y(N17) );
  NOR2BX1 U13 ( .AN(INST_RegIN[15]), .B(n1), .Y(N18) );
  NOR2BX1 U14 ( .AN(INST_RegIN[16]), .B(n1), .Y(N19) );
  NOR2BX1 U15 ( .AN(INST_RegIN[17]), .B(n1), .Y(N20) );
  NOR2BX1 U16 ( .AN(INST_RegIN[18]), .B(n1), .Y(N21) );
  NOR2BX1 U17 ( .AN(INST_RegIN[19]), .B(n1), .Y(N22) );
  NOR2BX1 U18 ( .AN(INST_RegIN[20]), .B(n1), .Y(N23) );
  NOR2BX1 U19 ( .AN(INST_RegIN[21]), .B(n1), .Y(N24) );
  NOR2BX1 U20 ( .AN(INST_RegIN[22]), .B(n1), .Y(N25) );
  NOR2BX1 U21 ( .AN(INST_RegIN[23]), .B(n1), .Y(N26) );
  NOR2BX1 U22 ( .AN(INST_RegIN[24]), .B(n1), .Y(N27) );
  NOR2BX1 U23 ( .AN(INST_RegIN[25]), .B(n1), .Y(N28) );
  NOR2BX1 U24 ( .AN(INST_RegIN[26]), .B(n1), .Y(N29) );
  NOR2BX1 U25 ( .AN(INST_RegIN[27]), .B(n1), .Y(N30) );
  NOR2BX1 U26 ( .AN(INST_RegIN[28]), .B(n1), .Y(N31) );
  NOR2BX1 U27 ( .AN(INST_RegIN[29]), .B(n1), .Y(N32) );
  NOR2BX1 U28 ( .AN(INST_RegIN[30]), .B(n1), .Y(N33) );
  NOR2BX1 U29 ( .AN(INST_RegIN[31]), .B(n1), .Y(N34) );
  NOR2BX1 U30 ( .AN(INST_RegIN[7]), .B(n1), .Y(N10) );
  NOR2BX1 U31 ( .AN(INST_RegIN[8]), .B(n1), .Y(N11) );
  NOR2BX1 U32 ( .AN(INST_RegIN[9]), .B(n1), .Y(N12) );
  NOR2BX1 U33 ( .AN(INST_RegIN[10]), .B(n1), .Y(N13) );
  NOR2BX1 U34 ( .AN(INST_RegIN[11]), .B(n1), .Y(N14) );
  NOR2BX1 U35 ( .AN(INST_RegIN[12]), .B(n1), .Y(N15) );
  INVX1 U36 ( .A(rst), .Y(n2) );
endmodule


module control ( clk, rst, Opcode, ALUop, Branch, Jump, RegDst, ALUSrc, 
        MemtoReg, RegWrite, MemRead, MemWrite );
  input [5:0] Opcode;
  output [1:0] ALUop;
  input clk, rst;
  output Branch, Jump, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite;
  wire   n6, n7, n8, n9, n10, n11, n12, n13, n14, n3, n4, n5, n15, n16;

  NAND2X1 U2 ( .A(n9), .B(n4), .Y(MemRead) );
  NAND2X1 U3 ( .A(n9), .B(n8), .Y(ALUSrc) );
  BUFX3 U4 ( .A(ALUop[1]), .Y(RegDst) );
  BUFX3 U5 ( .A(ALUop[0]), .Y(Branch) );
  NAND3X1 U6 ( .A(n6), .B(n4), .C(n7), .Y(RegWrite) );
  NAND2X1 U7 ( .A(n10), .B(n11), .Y(n7) );
  AOI31X1 U8 ( .A0(n11), .A1(n15), .A2(n14), .B0(n3), .Y(n9) );
  INVX1 U9 ( .A(n6), .Y(n3) );
  INVX1 U10 ( .A(MemtoReg), .Y(n4) );
  NOR4BX1 U11 ( .AN(n10), .B(n16), .C(Opcode[0]), .D(Opcode[3]), .Y(Jump) );
  NOR2X1 U12 ( .A(n8), .B(n5), .Y(MemWrite) );
  INVX1 U13 ( .A(Opcode[3]), .Y(n5) );
  NOR4BX1 U14 ( .AN(n12), .B(n15), .C(Opcode[1]), .D(Opcode[3]), .Y(ALUop[0])
         );
  NOR2X1 U15 ( .A(Opcode[5]), .B(Opcode[4]), .Y(n12) );
  NOR4BX1 U16 ( .AN(Opcode[3]), .B(n13), .C(Opcode[4]), .D(Opcode[5]), .Y(n14)
         );
  NAND4BXL U17 ( .AN(Opcode[4]), .B(Opcode[5]), .C(n13), .D(n15), .Y(n8) );
  NOR3X1 U18 ( .A(Opcode[4]), .B(Opcode[5]), .C(Opcode[2]), .Y(n10) );
  NAND3BX1 U19 ( .AN(n11), .B(n14), .C(Opcode[2]), .Y(n6) );
  NOR2X1 U20 ( .A(n7), .B(Opcode[3]), .Y(ALUop[1]) );
  NOR2X1 U21 ( .A(n8), .B(Opcode[3]), .Y(MemtoReg) );
  NOR2X1 U22 ( .A(Opcode[0]), .B(Opcode[1]), .Y(n11) );
  AND2X2 U23 ( .A(Opcode[0]), .B(Opcode[1]), .Y(n13) );
  INVX1 U24 ( .A(Opcode[2]), .Y(n15) );
  INVX1 U25 ( .A(Opcode[1]), .Y(n16) );
endmodule


module Registers ( Read_register1, Read_register2, Write_register, Write_data, 
        Read_data1, Read_data2, RegWrite, Reg_S1, Reg_S2, Reg_S3, Reg_S4, 
        Reg_S5, Reg_S6, Reg_S7, Reg_S8, rst );
  input [4:0] Read_register1;
  input [4:0] Read_register2;
  input [4:0] Write_register;
  input [15:0] Write_data;
  output [15:0] Read_data1;
  output [15:0] Read_data2;
  output [15:0] Reg_S1;
  output [15:0] Reg_S2;
  output [15:0] Reg_S3;
  output [15:0] Reg_S4;
  output [15:0] Reg_S5;
  output [15:0] Reg_S6;
  output [15:0] Reg_S7;
  output [15:0] Reg_S8;
  input RegWrite, rst;
  wire   register_file_15__15_, register_file_15__14_, register_file_15__13_,
         register_file_15__12_, register_file_15__11_, register_file_15__10_,
         register_file_15__9_, register_file_15__8_, register_file_15__7_,
         register_file_15__6_, register_file_15__5_, register_file_15__4_,
         register_file_15__3_, register_file_15__2_, register_file_15__1_,
         register_file_15__0_, register_file_14__15_, register_file_14__14_,
         register_file_14__13_, register_file_14__12_, register_file_14__11_,
         register_file_14__10_, register_file_14__9_, register_file_14__8_,
         register_file_14__7_, register_file_14__6_, register_file_14__5_,
         register_file_14__4_, register_file_14__3_, register_file_14__2_,
         register_file_14__1_, register_file_14__0_, register_file_13__15_,
         register_file_13__14_, register_file_13__13_, register_file_13__12_,
         register_file_13__11_, register_file_13__10_, register_file_13__9_,
         register_file_13__8_, register_file_13__7_, register_file_13__6_,
         register_file_13__5_, register_file_13__4_, register_file_13__3_,
         register_file_13__2_, register_file_13__1_, register_file_13__0_,
         register_file_12__15_, register_file_12__14_, register_file_12__13_,
         register_file_12__12_, register_file_12__11_, register_file_12__10_,
         register_file_12__9_, register_file_12__8_, register_file_12__7_,
         register_file_12__6_, register_file_12__5_, register_file_12__4_,
         register_file_12__3_, register_file_12__2_, register_file_12__1_,
         register_file_12__0_, register_file_11__15_, register_file_11__14_,
         register_file_11__13_, register_file_11__12_, register_file_11__11_,
         register_file_11__10_, register_file_11__9_, register_file_11__8_,
         register_file_11__7_, register_file_11__6_, register_file_11__5_,
         register_file_11__4_, register_file_11__3_, register_file_11__2_,
         register_file_11__1_, register_file_11__0_, register_file_10__15_,
         register_file_10__14_, register_file_10__13_, register_file_10__12_,
         register_file_10__11_, register_file_10__10_, register_file_10__9_,
         register_file_10__8_, register_file_10__7_, register_file_10__6_,
         register_file_10__5_, register_file_10__4_, register_file_10__3_,
         register_file_10__2_, register_file_10__1_, register_file_10__0_,
         register_file_9__15_, register_file_9__14_, register_file_9__13_,
         register_file_9__12_, register_file_9__11_, register_file_9__10_,
         register_file_9__9_, register_file_9__8_, register_file_9__7_,
         register_file_9__6_, register_file_9__5_, register_file_9__4_,
         register_file_9__3_, register_file_9__2_, register_file_9__1_,
         register_file_9__0_, register_file_0__15_, register_file_0__14_,
         register_file_0__13_, register_file_0__12_, register_file_0__11_,
         register_file_0__10_, register_file_0__9_, register_file_0__8_,
         register_file_0__7_, register_file_0__6_, register_file_0__5_,
         register_file_0__4_, register_file_0__3_, register_file_0__2_,
         register_file_0__1_, register_file_0__0_, N19, N20, N21, N22, N23,
         N24, N25, N26, N27, N28, N29, N30, N31, N32, N33, N34, N35, N36, N37,
         N38, N39, N40, N41, N42, N43, N44, N45, N46, N47, N48, N49, N50, n261,
         n262, n263, n264, n265, n266, n267, n268, n269, n270, n271, n272,
         n257, n258, n259, n260, n273, n274, n275, n276, n277, n278, n279,
         n280, n281, n282, n283, n284, n285, n286, n287, n288, n289, n290,
         n291, n292, n293, n294, n295, n296, n297, n298, n299, n300, n301,
         n302, n303, n304, n305, n306, n307, n308, n309, n310, n311, n312,
         n313, n314, n315, n316, n317, n318, n319, n320, n321, n322, n323,
         n324, n325, n326, n327, n328, n329, n330, n331, n332, n333, n334,
         n335, n336, n337, n338, n339, n340, n341, n342, n343, n344, n345,
         n346, n347, n348, n349, n350, n351, n352, n353, n354, n355, n356,
         n357, n358, n359, n360, n361, n362, n363, n364, n365, n366, n367,
         n368, n369, n370, n371, n372, n373, n374, n375, n376, n377, n378,
         n379, n380, n381, n382, n383, n384, n385, n386, n387, n388, n389,
         n390, n391, n392, n393, n394, n395, n396, n397, n398, n399, n400,
         n401, n402, n403, n404, n405, n406, n407, n408, n409, n410, n411,
         n412, n413, n414, n415, n416, n417, n418, n419, n420, n421, n422,
         n423, n424, n425, n426, n427, n428, n429, n430, n431, n432, n433,
         n434, n435, n436, n437, n438;

  TLATX1 register_file_reg_13__15_ ( .G(N48), .D(n434), .Q(
        register_file_13__15_) );
  TLATX1 register_file_reg_13__14_ ( .G(N48), .D(n433), .Q(
        register_file_13__14_) );
  TLATX1 register_file_reg_13__13_ ( .G(N48), .D(n432), .Q(
        register_file_13__13_) );
  TLATX1 register_file_reg_13__12_ ( .G(N48), .D(n431), .Q(
        register_file_13__12_) );
  TLATX1 register_file_reg_13__11_ ( .G(N48), .D(n430), .Q(
        register_file_13__11_) );
  TLATX1 register_file_reg_13__10_ ( .G(N48), .D(n429), .Q(
        register_file_13__10_) );
  TLATX1 register_file_reg_13__9_ ( .G(N48), .D(n428), .Q(register_file_13__9_) );
  TLATX1 register_file_reg_13__8_ ( .G(N48), .D(n427), .Q(register_file_13__8_) );
  TLATX1 register_file_reg_13__7_ ( .G(N48), .D(n426), .Q(register_file_13__7_) );
  TLATX1 register_file_reg_13__6_ ( .G(N48), .D(n425), .Q(register_file_13__6_) );
  TLATX1 register_file_reg_13__5_ ( .G(N48), .D(n424), .Q(register_file_13__5_) );
  TLATX1 register_file_reg_13__4_ ( .G(N48), .D(n423), .Q(register_file_13__4_) );
  TLATX1 register_file_reg_13__3_ ( .G(N48), .D(n422), .Q(register_file_13__3_) );
  TLATX1 register_file_reg_13__2_ ( .G(N48), .D(n421), .Q(register_file_13__2_) );
  TLATX1 register_file_reg_13__1_ ( .G(N48), .D(n420), .Q(register_file_13__1_) );
  TLATX1 register_file_reg_13__0_ ( .G(N48), .D(n419), .Q(register_file_13__0_) );
  TLATX1 register_file_reg_9__15_ ( .G(N44), .D(n434), .Q(register_file_9__15_) );
  TLATX1 register_file_reg_9__14_ ( .G(N44), .D(n433), .Q(register_file_9__14_) );
  TLATX1 register_file_reg_9__13_ ( .G(N44), .D(n432), .Q(register_file_9__13_) );
  TLATX1 register_file_reg_9__12_ ( .G(N44), .D(n431), .Q(register_file_9__12_) );
  TLATX1 register_file_reg_9__11_ ( .G(N44), .D(n430), .Q(register_file_9__11_) );
  TLATX1 register_file_reg_9__10_ ( .G(N44), .D(n429), .Q(register_file_9__10_) );
  TLATX1 register_file_reg_9__9_ ( .G(N44), .D(n428), .Q(register_file_9__9_)
         );
  TLATX1 register_file_reg_9__8_ ( .G(N44), .D(n427), .Q(register_file_9__8_)
         );
  TLATX1 register_file_reg_9__7_ ( .G(N44), .D(n426), .Q(register_file_9__7_)
         );
  TLATX1 register_file_reg_9__6_ ( .G(N44), .D(n425), .Q(register_file_9__6_)
         );
  TLATX1 register_file_reg_9__5_ ( .G(N44), .D(n424), .Q(register_file_9__5_)
         );
  TLATX1 register_file_reg_9__4_ ( .G(N44), .D(n423), .Q(register_file_9__4_)
         );
  TLATX1 register_file_reg_9__3_ ( .G(N44), .D(n422), .Q(register_file_9__3_)
         );
  TLATX1 register_file_reg_9__2_ ( .G(N44), .D(n421), .Q(register_file_9__2_)
         );
  TLATX1 register_file_reg_9__1_ ( .G(N44), .D(n420), .Q(register_file_9__1_)
         );
  TLATX1 register_file_reg_9__0_ ( .G(N44), .D(n419), .Q(register_file_9__0_)
         );
  TLATX1 register_file_reg_5__15_ ( .G(N40), .D(n434), .Q(Reg_S5[15]) );
  TLATX1 register_file_reg_5__14_ ( .G(N40), .D(n433), .Q(Reg_S5[14]) );
  TLATX1 register_file_reg_5__13_ ( .G(N40), .D(n432), .Q(Reg_S5[13]) );
  TLATX1 register_file_reg_5__12_ ( .G(N40), .D(n431), .Q(Reg_S5[12]) );
  TLATX1 register_file_reg_5__11_ ( .G(N40), .D(n430), .Q(Reg_S5[11]) );
  TLATX1 register_file_reg_5__10_ ( .G(N40), .D(n429), .Q(Reg_S5[10]) );
  TLATX1 register_file_reg_5__9_ ( .G(N40), .D(n428), .Q(Reg_S5[9]) );
  TLATX1 register_file_reg_5__8_ ( .G(N40), .D(n427), .Q(Reg_S5[8]) );
  TLATX1 register_file_reg_5__7_ ( .G(N40), .D(n426), .Q(Reg_S5[7]) );
  TLATX1 register_file_reg_5__6_ ( .G(N40), .D(n425), .Q(Reg_S5[6]) );
  TLATX1 register_file_reg_5__5_ ( .G(N40), .D(n424), .Q(Reg_S5[5]) );
  TLATX1 register_file_reg_5__4_ ( .G(N40), .D(n423), .Q(Reg_S5[4]) );
  TLATX1 register_file_reg_5__3_ ( .G(N40), .D(n422), .Q(Reg_S5[3]) );
  TLATX1 register_file_reg_5__2_ ( .G(N40), .D(n421), .Q(Reg_S5[2]) );
  TLATX1 register_file_reg_5__1_ ( .G(N40), .D(n420), .Q(Reg_S5[1]) );
  TLATX1 register_file_reg_5__0_ ( .G(N40), .D(n419), .Q(Reg_S5[0]) );
  TLATX1 register_file_reg_1__15_ ( .G(N36), .D(n434), .Q(Reg_S1[15]) );
  TLATX1 register_file_reg_1__14_ ( .G(N36), .D(n433), .Q(Reg_S1[14]) );
  TLATX1 register_file_reg_1__13_ ( .G(N36), .D(n432), .Q(Reg_S1[13]) );
  TLATX1 register_file_reg_1__12_ ( .G(N36), .D(n431), .Q(Reg_S1[12]) );
  TLATX1 register_file_reg_1__11_ ( .G(N36), .D(n430), .Q(Reg_S1[11]) );
  TLATX1 register_file_reg_1__10_ ( .G(N36), .D(n429), .Q(Reg_S1[10]) );
  TLATX1 register_file_reg_1__9_ ( .G(N36), .D(n428), .Q(Reg_S1[9]) );
  TLATX1 register_file_reg_1__8_ ( .G(N36), .D(n427), .Q(Reg_S1[8]) );
  TLATX1 register_file_reg_1__7_ ( .G(N36), .D(n426), .Q(Reg_S1[7]) );
  TLATX1 register_file_reg_1__6_ ( .G(N36), .D(n425), .Q(Reg_S1[6]) );
  TLATX1 register_file_reg_1__5_ ( .G(N36), .D(n424), .Q(Reg_S1[5]) );
  TLATX1 register_file_reg_1__4_ ( .G(N36), .D(n423), .Q(Reg_S1[4]) );
  TLATX1 register_file_reg_1__3_ ( .G(N36), .D(n422), .Q(Reg_S1[3]) );
  TLATX1 register_file_reg_1__2_ ( .G(N36), .D(n421), .Q(Reg_S1[2]) );
  TLATX1 register_file_reg_1__1_ ( .G(N36), .D(n420), .Q(Reg_S1[1]) );
  TLATX1 register_file_reg_1__0_ ( .G(N36), .D(n419), .Q(Reg_S1[0]) );
  TLATX1 register_file_reg_15__15_ ( .G(N50), .D(n434), .Q(
        register_file_15__15_) );
  TLATX1 register_file_reg_15__14_ ( .G(N50), .D(n433), .Q(
        register_file_15__14_) );
  TLATX1 register_file_reg_15__13_ ( .G(N50), .D(n432), .Q(
        register_file_15__13_) );
  TLATX1 register_file_reg_15__12_ ( .G(N50), .D(n431), .Q(
        register_file_15__12_) );
  TLATX1 register_file_reg_15__11_ ( .G(N50), .D(n430), .Q(
        register_file_15__11_) );
  TLATX1 register_file_reg_15__10_ ( .G(N50), .D(n429), .Q(
        register_file_15__10_) );
  TLATX1 register_file_reg_15__9_ ( .G(N50), .D(n428), .Q(register_file_15__9_) );
  TLATX1 register_file_reg_15__8_ ( .G(N50), .D(n427), .Q(register_file_15__8_) );
  TLATX1 register_file_reg_15__7_ ( .G(N50), .D(n426), .Q(register_file_15__7_) );
  TLATX1 register_file_reg_15__6_ ( .G(N50), .D(n425), .Q(register_file_15__6_) );
  TLATX1 register_file_reg_15__5_ ( .G(N50), .D(n424), .Q(register_file_15__5_) );
  TLATX1 register_file_reg_15__4_ ( .G(N50), .D(n423), .Q(register_file_15__4_) );
  TLATX1 register_file_reg_15__3_ ( .G(N50), .D(n422), .Q(register_file_15__3_) );
  TLATX1 register_file_reg_15__2_ ( .G(N50), .D(n421), .Q(register_file_15__2_) );
  TLATX1 register_file_reg_15__1_ ( .G(N50), .D(n420), .Q(register_file_15__1_) );
  TLATX1 register_file_reg_15__0_ ( .G(N50), .D(n419), .Q(register_file_15__0_) );
  TLATX1 register_file_reg_11__15_ ( .G(N46), .D(n434), .Q(
        register_file_11__15_) );
  TLATX1 register_file_reg_11__14_ ( .G(N46), .D(n433), .Q(
        register_file_11__14_) );
  TLATX1 register_file_reg_11__13_ ( .G(N46), .D(n432), .Q(
        register_file_11__13_) );
  TLATX1 register_file_reg_11__12_ ( .G(N46), .D(n431), .Q(
        register_file_11__12_) );
  TLATX1 register_file_reg_11__11_ ( .G(N46), .D(n430), .Q(
        register_file_11__11_) );
  TLATX1 register_file_reg_11__10_ ( .G(N46), .D(n429), .Q(
        register_file_11__10_) );
  TLATX1 register_file_reg_11__9_ ( .G(N46), .D(n428), .Q(register_file_11__9_) );
  TLATX1 register_file_reg_11__8_ ( .G(N46), .D(n427), .Q(register_file_11__8_) );
  TLATX1 register_file_reg_11__7_ ( .G(N46), .D(n426), .Q(register_file_11__7_) );
  TLATX1 register_file_reg_11__6_ ( .G(N46), .D(n425), .Q(register_file_11__6_) );
  TLATX1 register_file_reg_11__5_ ( .G(N46), .D(n424), .Q(register_file_11__5_) );
  TLATX1 register_file_reg_11__4_ ( .G(N46), .D(n423), .Q(register_file_11__4_) );
  TLATX1 register_file_reg_11__3_ ( .G(N46), .D(n422), .Q(register_file_11__3_) );
  TLATX1 register_file_reg_11__2_ ( .G(N46), .D(n421), .Q(register_file_11__2_) );
  TLATX1 register_file_reg_11__1_ ( .G(N46), .D(n420), .Q(register_file_11__1_) );
  TLATX1 register_file_reg_11__0_ ( .G(N46), .D(n419), .Q(register_file_11__0_) );
  TLATX1 register_file_reg_7__15_ ( .G(N42), .D(n434), .Q(Reg_S7[15]) );
  TLATX1 register_file_reg_7__14_ ( .G(N42), .D(n433), .Q(Reg_S7[14]) );
  TLATX1 register_file_reg_7__13_ ( .G(N42), .D(n432), .Q(Reg_S7[13]) );
  TLATX1 register_file_reg_7__12_ ( .G(N42), .D(n431), .Q(Reg_S7[12]) );
  TLATX1 register_file_reg_7__11_ ( .G(N42), .D(n430), .Q(Reg_S7[11]) );
  TLATX1 register_file_reg_7__10_ ( .G(N42), .D(n429), .Q(Reg_S7[10]) );
  TLATX1 register_file_reg_7__9_ ( .G(N42), .D(n428), .Q(Reg_S7[9]) );
  TLATX1 register_file_reg_7__8_ ( .G(N42), .D(n427), .Q(Reg_S7[8]) );
  TLATX1 register_file_reg_7__7_ ( .G(N42), .D(n426), .Q(Reg_S7[7]) );
  TLATX1 register_file_reg_7__6_ ( .G(N42), .D(n425), .Q(Reg_S7[6]) );
  TLATX1 register_file_reg_7__5_ ( .G(N42), .D(n424), .Q(Reg_S7[5]) );
  TLATX1 register_file_reg_7__4_ ( .G(N42), .D(n423), .Q(Reg_S7[4]) );
  TLATX1 register_file_reg_7__3_ ( .G(N42), .D(n422), .Q(Reg_S7[3]) );
  TLATX1 register_file_reg_7__2_ ( .G(N42), .D(n421), .Q(Reg_S7[2]) );
  TLATX1 register_file_reg_7__1_ ( .G(N42), .D(n420), .Q(Reg_S7[1]) );
  TLATX1 register_file_reg_7__0_ ( .G(N42), .D(n419), .Q(Reg_S7[0]) );
  TLATX1 register_file_reg_3__15_ ( .G(N38), .D(n434), .Q(Reg_S3[15]) );
  TLATX1 register_file_reg_3__14_ ( .G(N38), .D(n433), .Q(Reg_S3[14]) );
  TLATX1 register_file_reg_3__13_ ( .G(N38), .D(n432), .Q(Reg_S3[13]) );
  TLATX1 register_file_reg_3__12_ ( .G(N38), .D(n431), .Q(Reg_S3[12]) );
  TLATX1 register_file_reg_3__11_ ( .G(N38), .D(n430), .Q(Reg_S3[11]) );
  TLATX1 register_file_reg_3__10_ ( .G(N38), .D(n429), .Q(Reg_S3[10]) );
  TLATX1 register_file_reg_3__9_ ( .G(N38), .D(n428), .Q(Reg_S3[9]) );
  TLATX1 register_file_reg_3__8_ ( .G(N38), .D(n427), .Q(Reg_S3[8]) );
  TLATX1 register_file_reg_3__7_ ( .G(N38), .D(n426), .Q(Reg_S3[7]) );
  TLATX1 register_file_reg_3__6_ ( .G(N38), .D(n425), .Q(Reg_S3[6]) );
  TLATX1 register_file_reg_3__5_ ( .G(N38), .D(n424), .Q(Reg_S3[5]) );
  TLATX1 register_file_reg_3__4_ ( .G(N38), .D(n423), .Q(Reg_S3[4]) );
  TLATX1 register_file_reg_3__3_ ( .G(N38), .D(n422), .Q(Reg_S3[3]) );
  TLATX1 register_file_reg_3__2_ ( .G(N38), .D(n421), .Q(Reg_S3[2]) );
  TLATX1 register_file_reg_3__1_ ( .G(N38), .D(n420), .Q(Reg_S3[1]) );
  TLATX1 register_file_reg_3__0_ ( .G(N38), .D(n419), .Q(Reg_S3[0]) );
  TLATX1 register_file_reg_12__15_ ( .G(N47), .D(n434), .Q(
        register_file_12__15_) );
  TLATX1 register_file_reg_12__14_ ( .G(N47), .D(n433), .Q(
        register_file_12__14_) );
  TLATX1 register_file_reg_12__13_ ( .G(N47), .D(n432), .Q(
        register_file_12__13_) );
  TLATX1 register_file_reg_12__12_ ( .G(N47), .D(n431), .Q(
        register_file_12__12_) );
  TLATX1 register_file_reg_12__11_ ( .G(N47), .D(n430), .Q(
        register_file_12__11_) );
  TLATX1 register_file_reg_12__10_ ( .G(N47), .D(n429), .Q(
        register_file_12__10_) );
  TLATX1 register_file_reg_12__9_ ( .G(N47), .D(n428), .Q(register_file_12__9_) );
  TLATX1 register_file_reg_12__8_ ( .G(N47), .D(n427), .Q(register_file_12__8_) );
  TLATX1 register_file_reg_12__7_ ( .G(N47), .D(n426), .Q(register_file_12__7_) );
  TLATX1 register_file_reg_12__6_ ( .G(N47), .D(n425), .Q(register_file_12__6_) );
  TLATX1 register_file_reg_12__5_ ( .G(N47), .D(n424), .Q(register_file_12__5_) );
  TLATX1 register_file_reg_12__4_ ( .G(N47), .D(n423), .Q(register_file_12__4_) );
  TLATX1 register_file_reg_12__3_ ( .G(N47), .D(n422), .Q(register_file_12__3_) );
  TLATX1 register_file_reg_12__2_ ( .G(N47), .D(n421), .Q(register_file_12__2_) );
  TLATX1 register_file_reg_12__1_ ( .G(N47), .D(n420), .Q(register_file_12__1_) );
  TLATX1 register_file_reg_12__0_ ( .G(N47), .D(n419), .Q(register_file_12__0_) );
  TLATX1 register_file_reg_8__15_ ( .G(N43), .D(n434), .Q(Reg_S8[15]) );
  TLATX1 register_file_reg_8__14_ ( .G(N43), .D(n433), .Q(Reg_S8[14]) );
  TLATX1 register_file_reg_8__13_ ( .G(N43), .D(n432), .Q(Reg_S8[13]) );
  TLATX1 register_file_reg_8__12_ ( .G(N43), .D(n431), .Q(Reg_S8[12]) );
  TLATX1 register_file_reg_8__11_ ( .G(N43), .D(n430), .Q(Reg_S8[11]) );
  TLATX1 register_file_reg_8__10_ ( .G(N43), .D(n429), .Q(Reg_S8[10]) );
  TLATX1 register_file_reg_8__9_ ( .G(N43), .D(n428), .Q(Reg_S8[9]) );
  TLATX1 register_file_reg_8__8_ ( .G(N43), .D(n427), .Q(Reg_S8[8]) );
  TLATX1 register_file_reg_8__7_ ( .G(N43), .D(n426), .Q(Reg_S8[7]) );
  TLATX1 register_file_reg_8__6_ ( .G(N43), .D(n425), .Q(Reg_S8[6]) );
  TLATX1 register_file_reg_8__5_ ( .G(N43), .D(n424), .Q(Reg_S8[5]) );
  TLATX1 register_file_reg_8__4_ ( .G(N43), .D(n423), .Q(Reg_S8[4]) );
  TLATX1 register_file_reg_8__3_ ( .G(N43), .D(n422), .Q(Reg_S8[3]) );
  TLATX1 register_file_reg_8__2_ ( .G(N43), .D(n421), .Q(Reg_S8[2]) );
  TLATX1 register_file_reg_8__1_ ( .G(N43), .D(n420), .Q(Reg_S8[1]) );
  TLATX1 register_file_reg_8__0_ ( .G(N43), .D(n419), .Q(Reg_S8[0]) );
  TLATX1 register_file_reg_4__15_ ( .G(N39), .D(n434), .Q(Reg_S4[15]) );
  TLATX1 register_file_reg_4__14_ ( .G(N39), .D(n433), .Q(Reg_S4[14]) );
  TLATX1 register_file_reg_4__13_ ( .G(N39), .D(n432), .Q(Reg_S4[13]) );
  TLATX1 register_file_reg_4__12_ ( .G(N39), .D(n431), .Q(Reg_S4[12]) );
  TLATX1 register_file_reg_4__11_ ( .G(N39), .D(n430), .Q(Reg_S4[11]) );
  TLATX1 register_file_reg_4__10_ ( .G(N39), .D(n429), .Q(Reg_S4[10]) );
  TLATX1 register_file_reg_4__9_ ( .G(N39), .D(n428), .Q(Reg_S4[9]) );
  TLATX1 register_file_reg_4__8_ ( .G(N39), .D(n427), .Q(Reg_S4[8]) );
  TLATX1 register_file_reg_4__7_ ( .G(N39), .D(n426), .Q(Reg_S4[7]) );
  TLATX1 register_file_reg_4__6_ ( .G(N39), .D(n425), .Q(Reg_S4[6]) );
  TLATX1 register_file_reg_4__5_ ( .G(N39), .D(n424), .Q(Reg_S4[5]) );
  TLATX1 register_file_reg_4__4_ ( .G(N39), .D(n423), .Q(Reg_S4[4]) );
  TLATX1 register_file_reg_4__3_ ( .G(N39), .D(n422), .Q(Reg_S4[3]) );
  TLATX1 register_file_reg_4__2_ ( .G(N39), .D(n421), .Q(Reg_S4[2]) );
  TLATX1 register_file_reg_4__1_ ( .G(N39), .D(n420), .Q(Reg_S4[1]) );
  TLATX1 register_file_reg_4__0_ ( .G(N39), .D(n419), .Q(Reg_S4[0]) );
  TLATX1 register_file_reg_0__15_ ( .G(N19), .D(n434), .Q(register_file_0__15_) );
  TLATX1 register_file_reg_0__14_ ( .G(N19), .D(n433), .Q(register_file_0__14_) );
  TLATX1 register_file_reg_0__13_ ( .G(N19), .D(n432), .Q(register_file_0__13_) );
  TLATX1 register_file_reg_0__12_ ( .G(N19), .D(n431), .Q(register_file_0__12_) );
  TLATX1 register_file_reg_0__11_ ( .G(N19), .D(n430), .Q(register_file_0__11_) );
  TLATX1 register_file_reg_0__10_ ( .G(N19), .D(n429), .Q(register_file_0__10_) );
  TLATX1 register_file_reg_0__9_ ( .G(N19), .D(n428), .Q(register_file_0__9_)
         );
  TLATX1 register_file_reg_0__8_ ( .G(N19), .D(n427), .Q(register_file_0__8_)
         );
  TLATX1 register_file_reg_0__7_ ( .G(N19), .D(n426), .Q(register_file_0__7_)
         );
  TLATX1 register_file_reg_0__6_ ( .G(N19), .D(n425), .Q(register_file_0__6_)
         );
  TLATX1 register_file_reg_0__5_ ( .G(N19), .D(n424), .Q(register_file_0__5_)
         );
  TLATX1 register_file_reg_0__4_ ( .G(N19), .D(n423), .Q(register_file_0__4_)
         );
  TLATX1 register_file_reg_0__3_ ( .G(N19), .D(n422), .Q(register_file_0__3_)
         );
  TLATX1 register_file_reg_0__2_ ( .G(N19), .D(n421), .Q(register_file_0__2_)
         );
  TLATX1 register_file_reg_0__1_ ( .G(N19), .D(n420), .Q(register_file_0__1_)
         );
  TLATX1 register_file_reg_0__0_ ( .G(N19), .D(n419), .Q(register_file_0__0_)
         );
  TLATX1 register_file_reg_14__15_ ( .G(N49), .D(n434), .Q(
        register_file_14__15_) );
  TLATX1 register_file_reg_14__14_ ( .G(N49), .D(n433), .Q(
        register_file_14__14_) );
  TLATX1 register_file_reg_14__13_ ( .G(N49), .D(n432), .Q(
        register_file_14__13_) );
  TLATX1 register_file_reg_14__12_ ( .G(N49), .D(n431), .Q(
        register_file_14__12_) );
  TLATX1 register_file_reg_14__11_ ( .G(N49), .D(n430), .Q(
        register_file_14__11_) );
  TLATX1 register_file_reg_14__10_ ( .G(N49), .D(n429), .Q(
        register_file_14__10_) );
  TLATX1 register_file_reg_14__9_ ( .G(N49), .D(n428), .Q(register_file_14__9_) );
  TLATX1 register_file_reg_14__8_ ( .G(N49), .D(n427), .Q(register_file_14__8_) );
  TLATX1 register_file_reg_14__7_ ( .G(N49), .D(n426), .Q(register_file_14__7_) );
  TLATX1 register_file_reg_14__6_ ( .G(N49), .D(n425), .Q(register_file_14__6_) );
  TLATX1 register_file_reg_14__5_ ( .G(N49), .D(n424), .Q(register_file_14__5_) );
  TLATX1 register_file_reg_14__4_ ( .G(N49), .D(n423), .Q(register_file_14__4_) );
  TLATX1 register_file_reg_14__3_ ( .G(N49), .D(n422), .Q(register_file_14__3_) );
  TLATX1 register_file_reg_14__2_ ( .G(N49), .D(n421), .Q(register_file_14__2_) );
  TLATX1 register_file_reg_14__1_ ( .G(N49), .D(n420), .Q(register_file_14__1_) );
  TLATX1 register_file_reg_14__0_ ( .G(N49), .D(n419), .Q(register_file_14__0_) );
  TLATX1 register_file_reg_10__15_ ( .G(N45), .D(n434), .Q(
        register_file_10__15_) );
  TLATX1 register_file_reg_10__14_ ( .G(N45), .D(n433), .Q(
        register_file_10__14_) );
  TLATX1 register_file_reg_10__13_ ( .G(N45), .D(n432), .Q(
        register_file_10__13_) );
  TLATX1 register_file_reg_10__12_ ( .G(N45), .D(n431), .Q(
        register_file_10__12_) );
  TLATX1 register_file_reg_10__11_ ( .G(N45), .D(n430), .Q(
        register_file_10__11_) );
  TLATX1 register_file_reg_10__10_ ( .G(N45), .D(n429), .Q(
        register_file_10__10_) );
  TLATX1 register_file_reg_10__9_ ( .G(N45), .D(n428), .Q(register_file_10__9_) );
  TLATX1 register_file_reg_10__8_ ( .G(N45), .D(n427), .Q(register_file_10__8_) );
  TLATX1 register_file_reg_10__7_ ( .G(N45), .D(n426), .Q(register_file_10__7_) );
  TLATX1 register_file_reg_10__6_ ( .G(N45), .D(n425), .Q(register_file_10__6_) );
  TLATX1 register_file_reg_10__5_ ( .G(N45), .D(n424), .Q(register_file_10__5_) );
  TLATX1 register_file_reg_10__4_ ( .G(N45), .D(n423), .Q(register_file_10__4_) );
  TLATX1 register_file_reg_10__3_ ( .G(N45), .D(n422), .Q(register_file_10__3_) );
  TLATX1 register_file_reg_10__2_ ( .G(N45), .D(n421), .Q(register_file_10__2_) );
  TLATX1 register_file_reg_10__1_ ( .G(N45), .D(n420), .Q(register_file_10__1_) );
  TLATX1 register_file_reg_10__0_ ( .G(N45), .D(n419), .Q(register_file_10__0_) );
  TLATX1 register_file_reg_6__15_ ( .G(N41), .D(n434), .Q(Reg_S6[15]) );
  TLATX1 register_file_reg_6__14_ ( .G(N41), .D(n433), .Q(Reg_S6[14]) );
  TLATX1 register_file_reg_6__13_ ( .G(N41), .D(n432), .Q(Reg_S6[13]) );
  TLATX1 register_file_reg_6__12_ ( .G(N41), .D(n431), .Q(Reg_S6[12]) );
  TLATX1 register_file_reg_6__11_ ( .G(N41), .D(n430), .Q(Reg_S6[11]) );
  TLATX1 register_file_reg_6__10_ ( .G(N41), .D(n429), .Q(Reg_S6[10]) );
  TLATX1 register_file_reg_6__9_ ( .G(N41), .D(n428), .Q(Reg_S6[9]) );
  TLATX1 register_file_reg_6__8_ ( .G(N41), .D(n427), .Q(Reg_S6[8]) );
  TLATX1 register_file_reg_6__7_ ( .G(N41), .D(n426), .Q(Reg_S6[7]) );
  TLATX1 register_file_reg_6__6_ ( .G(N41), .D(n425), .Q(Reg_S6[6]) );
  TLATX1 register_file_reg_6__5_ ( .G(N41), .D(n424), .Q(Reg_S6[5]) );
  TLATX1 register_file_reg_6__4_ ( .G(N41), .D(n423), .Q(Reg_S6[4]) );
  TLATX1 register_file_reg_6__3_ ( .G(N41), .D(n422), .Q(Reg_S6[3]) );
  TLATX1 register_file_reg_6__2_ ( .G(N41), .D(n421), .Q(Reg_S6[2]) );
  TLATX1 register_file_reg_6__1_ ( .G(N41), .D(n420), .Q(Reg_S6[1]) );
  TLATX1 register_file_reg_6__0_ ( .G(N41), .D(n419), .Q(Reg_S6[0]) );
  TLATX1 register_file_reg_2__15_ ( .G(N37), .D(n434), .Q(Reg_S2[15]) );
  TLATX1 register_file_reg_2__14_ ( .G(N37), .D(n433), .Q(Reg_S2[14]) );
  TLATX1 register_file_reg_2__13_ ( .G(N37), .D(n432), .Q(Reg_S2[13]) );
  TLATX1 register_file_reg_2__12_ ( .G(N37), .D(n431), .Q(Reg_S2[12]) );
  TLATX1 register_file_reg_2__11_ ( .G(N37), .D(n430), .Q(Reg_S2[11]) );
  TLATX1 register_file_reg_2__10_ ( .G(N37), .D(n429), .Q(Reg_S2[10]) );
  TLATX1 register_file_reg_2__9_ ( .G(N37), .D(n428), .Q(Reg_S2[9]) );
  TLATX1 register_file_reg_2__8_ ( .G(N37), .D(n427), .Q(Reg_S2[8]) );
  TLATX1 register_file_reg_2__7_ ( .G(N37), .D(n426), .Q(Reg_S2[7]) );
  TLATX1 register_file_reg_2__6_ ( .G(N37), .D(n425), .Q(Reg_S2[6]) );
  TLATX1 register_file_reg_2__5_ ( .G(N37), .D(n424), .Q(Reg_S2[5]) );
  TLATX1 register_file_reg_2__4_ ( .G(N37), .D(n423), .Q(Reg_S2[4]) );
  TLATX1 register_file_reg_2__3_ ( .G(N37), .D(n422), .Q(Reg_S2[3]) );
  TLATX1 register_file_reg_2__2_ ( .G(N37), .D(n421), .Q(Reg_S2[2]) );
  TLATX1 register_file_reg_2__1_ ( .G(N37), .D(n420), .Q(Reg_S2[1]) );
  TLATX1 register_file_reg_2__0_ ( .G(N37), .D(n419), .Q(Reg_S2[0]) );
  INVX1 U3 ( .A(n412), .Y(n413) );
  INVX1 U4 ( .A(n412), .Y(n414) );
  INVX1 U5 ( .A(n412), .Y(n415) );
  INVX1 U6 ( .A(n412), .Y(n416) );
  INVX1 U7 ( .A(n337), .Y(n338) );
  INVX1 U8 ( .A(n337), .Y(n339) );
  INVX1 U9 ( .A(n337), .Y(n340) );
  INVX1 U10 ( .A(n337), .Y(n341) );
  INVX1 U11 ( .A(n408), .Y(n409) );
  INVX1 U12 ( .A(n408), .Y(n410) );
  INVX1 U13 ( .A(n408), .Y(n411) );
  INVX1 U14 ( .A(n333), .Y(n334) );
  INVX1 U15 ( .A(n333), .Y(n335) );
  INVX1 U16 ( .A(n333), .Y(n336) );
  INVX1 U17 ( .A(Read_register2[0]), .Y(n412) );
  INVX1 U18 ( .A(Read_register1[0]), .Y(n337) );
  INVX1 U19 ( .A(Read_register2[1]), .Y(n408) );
  INVX1 U20 ( .A(Read_register1[1]), .Y(n333) );
  OAI21XL U21 ( .A0(n261), .A1(n262), .B0(n438), .Y(N50) );
  OAI21XL U22 ( .A0(n263), .A1(n264), .B0(n438), .Y(N47) );
  OAI21XL U23 ( .A0(n261), .A1(n264), .B0(n438), .Y(N48) );
  OAI21XL U24 ( .A0(n263), .A1(n265), .B0(n438), .Y(N45) );
  OAI21XL U25 ( .A0(n261), .A1(n265), .B0(n438), .Y(N46) );
  OAI21XL U26 ( .A0(n266), .A1(n269), .B0(n438), .Y(N36) );
  OAI21XL U27 ( .A0(n265), .A1(n269), .B0(n438), .Y(N38) );
  OAI21XL U28 ( .A0(n264), .A1(n269), .B0(n438), .Y(N40) );
  OAI21XL U29 ( .A0(n262), .A1(n269), .B0(n438), .Y(N42) );
  OAI21XL U30 ( .A0(n262), .A1(n270), .B0(n438), .Y(N41) );
  OAI21XL U31 ( .A0(n261), .A1(n266), .B0(n438), .Y(N44) );
  OAI21XL U32 ( .A0(n262), .A1(n263), .B0(n438), .Y(N49) );
  OAI21XL U33 ( .A0(n264), .A1(n270), .B0(n438), .Y(N39) );
  OAI21XL U34 ( .A0(n265), .A1(n270), .B0(n438), .Y(N37) );
  OAI21XL U35 ( .A0(n266), .A1(n270), .B0(n438), .Y(N19) );
  OAI21XL U36 ( .A0(n263), .A1(n266), .B0(n438), .Y(N43) );
  NAND2X1 U37 ( .A(n267), .B(n437), .Y(n263) );
  NAND2X1 U38 ( .A(n436), .B(n435), .Y(n266) );
  NAND2X1 U39 ( .A(n271), .B(n437), .Y(n270) );
  MX4X1 U40 ( .A(n347), .B(n345), .C(n346), .D(n344), .S0(n418), .S1(n417), 
        .Y(Read_data2[0]) );
  MX4X1 U41 ( .A(register_file_0__0_), .B(Reg_S1[0]), .C(Reg_S2[0]), .D(
        Reg_S3[0]), .S0(Read_register2[0]), .S1(Read_register2[1]), .Y(n347)
         );
  MX4X1 U42 ( .A(Reg_S8[0]), .B(register_file_9__0_), .C(register_file_10__0_), 
        .D(register_file_11__0_), .S0(Read_register2[0]), .S1(
        Read_register2[1]), .Y(n345) );
  MX4X1 U43 ( .A(n351), .B(n349), .C(n350), .D(n348), .S0(n418), .S1(n417), 
        .Y(Read_data2[1]) );
  MX4X1 U44 ( .A(register_file_0__1_), .B(Reg_S1[1]), .C(Reg_S2[1]), .D(
        Reg_S3[1]), .S0(n413), .S1(n409), .Y(n351) );
  MX4X1 U45 ( .A(Reg_S8[1]), .B(register_file_9__1_), .C(register_file_10__1_), 
        .D(register_file_11__1_), .S0(n413), .S1(n409), .Y(n349) );
  MX4X1 U46 ( .A(n355), .B(n353), .C(n354), .D(n352), .S0(n418), .S1(n417), 
        .Y(Read_data2[2]) );
  MX4X1 U47 ( .A(register_file_0__2_), .B(Reg_S1[2]), .C(Reg_S2[2]), .D(
        Reg_S3[2]), .S0(n413), .S1(n409), .Y(n355) );
  MX4X1 U48 ( .A(Reg_S8[2]), .B(register_file_9__2_), .C(register_file_10__2_), 
        .D(register_file_11__2_), .S0(n413), .S1(n409), .Y(n353) );
  MX4X1 U49 ( .A(n359), .B(n357), .C(n358), .D(n356), .S0(n418), .S1(n417), 
        .Y(Read_data2[3]) );
  MX4X1 U50 ( .A(register_file_0__3_), .B(Reg_S1[3]), .C(Reg_S2[3]), .D(
        Reg_S3[3]), .S0(n413), .S1(n409), .Y(n359) );
  MX4X1 U51 ( .A(Reg_S8[3]), .B(register_file_9__3_), .C(register_file_10__3_), 
        .D(register_file_11__3_), .S0(n413), .S1(n409), .Y(n357) );
  MX4X1 U52 ( .A(n363), .B(n361), .C(n362), .D(n360), .S0(n418), .S1(n417), 
        .Y(Read_data2[4]) );
  MX4X1 U53 ( .A(register_file_0__4_), .B(Reg_S1[4]), .C(Reg_S2[4]), .D(
        Reg_S3[4]), .S0(n414), .S1(n410), .Y(n363) );
  MX4X1 U54 ( .A(Reg_S8[4]), .B(register_file_9__4_), .C(register_file_10__4_), 
        .D(register_file_11__4_), .S0(n414), .S1(n410), .Y(n361) );
  MX4X1 U55 ( .A(n367), .B(n365), .C(n366), .D(n364), .S0(n418), .S1(n417), 
        .Y(Read_data2[5]) );
  MX4X1 U56 ( .A(register_file_0__5_), .B(Reg_S1[5]), .C(Reg_S2[5]), .D(
        Reg_S3[5]), .S0(n414), .S1(n410), .Y(n367) );
  MX4X1 U57 ( .A(Reg_S8[5]), .B(register_file_9__5_), .C(register_file_10__5_), 
        .D(register_file_11__5_), .S0(n414), .S1(n410), .Y(n365) );
  MX4X1 U58 ( .A(n371), .B(n369), .C(n370), .D(n368), .S0(n418), .S1(n417), 
        .Y(Read_data2[6]) );
  MX4X1 U59 ( .A(register_file_0__6_), .B(Reg_S1[6]), .C(Reg_S2[6]), .D(
        Reg_S3[6]), .S0(n414), .S1(n410), .Y(n371) );
  MX4X1 U60 ( .A(Reg_S8[6]), .B(register_file_9__6_), .C(register_file_10__6_), 
        .D(register_file_11__6_), .S0(n414), .S1(n410), .Y(n369) );
  MX4X1 U61 ( .A(n375), .B(n373), .C(n374), .D(n372), .S0(n418), .S1(n417), 
        .Y(Read_data2[7]) );
  MX4X1 U62 ( .A(register_file_0__7_), .B(Reg_S1[7]), .C(Reg_S2[7]), .D(
        Reg_S3[7]), .S0(n415), .S1(n411), .Y(n375) );
  MX4X1 U63 ( .A(Reg_S8[7]), .B(register_file_9__7_), .C(register_file_10__7_), 
        .D(register_file_11__7_), .S0(n415), .S1(n411), .Y(n373) );
  MX4X1 U64 ( .A(n379), .B(n377), .C(n378), .D(n376), .S0(n418), .S1(n417), 
        .Y(Read_data2[8]) );
  MX4X1 U65 ( .A(register_file_0__8_), .B(Reg_S1[8]), .C(Reg_S2[8]), .D(
        Reg_S3[8]), .S0(n415), .S1(n411), .Y(n379) );
  MX4X1 U66 ( .A(Reg_S8[8]), .B(register_file_9__8_), .C(register_file_10__8_), 
        .D(register_file_11__8_), .S0(n415), .S1(n411), .Y(n377) );
  MX4X1 U67 ( .A(n383), .B(n381), .C(n382), .D(n380), .S0(n418), .S1(n417), 
        .Y(Read_data2[9]) );
  MX4X1 U68 ( .A(register_file_0__9_), .B(Reg_S1[9]), .C(Reg_S2[9]), .D(
        Reg_S3[9]), .S0(n415), .S1(n411), .Y(n383) );
  MX4X1 U69 ( .A(Reg_S8[9]), .B(register_file_9__9_), .C(register_file_10__9_), 
        .D(register_file_11__9_), .S0(n415), .S1(n411), .Y(n381) );
  MX4X1 U70 ( .A(n387), .B(n385), .C(n386), .D(n384), .S0(n418), .S1(n417), 
        .Y(Read_data2[10]) );
  MX4X1 U71 ( .A(register_file_0__10_), .B(Reg_S1[10]), .C(Reg_S2[10]), .D(
        Reg_S3[10]), .S0(Read_register2[0]), .S1(Read_register2[1]), .Y(n387)
         );
  MX4X1 U72 ( .A(Reg_S8[10]), .B(register_file_9__10_), .C(
        register_file_10__10_), .D(register_file_11__10_), .S0(n415), .S1(
        Read_register2[1]), .Y(n385) );
  MX4X1 U73 ( .A(n391), .B(n389), .C(n390), .D(n388), .S0(n418), .S1(n417), 
        .Y(Read_data2[11]) );
  MX4X1 U74 ( .A(register_file_0__11_), .B(Reg_S1[11]), .C(Reg_S2[11]), .D(
        Reg_S3[11]), .S0(Read_register2[0]), .S1(Read_register2[1]), .Y(n391)
         );
  MX4X1 U75 ( .A(Reg_S8[11]), .B(register_file_9__11_), .C(
        register_file_10__11_), .D(register_file_11__11_), .S0(
        Read_register2[0]), .S1(Read_register2[1]), .Y(n389) );
  MX4X1 U76 ( .A(n395), .B(n393), .C(n394), .D(n392), .S0(n418), .S1(n417), 
        .Y(Read_data2[12]) );
  MX4X1 U77 ( .A(register_file_0__12_), .B(Reg_S1[12]), .C(Reg_S2[12]), .D(
        Reg_S3[12]), .S0(Read_register2[0]), .S1(Read_register2[1]), .Y(n395)
         );
  MX4X1 U78 ( .A(Reg_S8[12]), .B(register_file_9__12_), .C(
        register_file_10__12_), .D(register_file_11__12_), .S0(
        Read_register2[0]), .S1(Read_register2[1]), .Y(n393) );
  MX4X1 U79 ( .A(n399), .B(n397), .C(n398), .D(n396), .S0(n418), .S1(n417), 
        .Y(Read_data2[13]) );
  MX4X1 U80 ( .A(register_file_0__13_), .B(Reg_S1[13]), .C(Reg_S2[13]), .D(
        Reg_S3[13]), .S0(n416), .S1(Read_register2[1]), .Y(n399) );
  MX4X1 U81 ( .A(Reg_S8[13]), .B(register_file_9__13_), .C(
        register_file_10__13_), .D(register_file_11__13_), .S0(n416), .S1(
        Read_register2[1]), .Y(n397) );
  MX4X1 U82 ( .A(n403), .B(n401), .C(n402), .D(n400), .S0(n418), .S1(n417), 
        .Y(Read_data2[14]) );
  MX4X1 U83 ( .A(register_file_0__14_), .B(Reg_S1[14]), .C(Reg_S2[14]), .D(
        Reg_S3[14]), .S0(n416), .S1(Read_register2[1]), .Y(n403) );
  MX4X1 U84 ( .A(Reg_S8[14]), .B(register_file_9__14_), .C(
        register_file_10__14_), .D(register_file_11__14_), .S0(n416), .S1(
        Read_register2[1]), .Y(n401) );
  MX4X1 U85 ( .A(n407), .B(n405), .C(n406), .D(n404), .S0(n418), .S1(n417), 
        .Y(Read_data2[15]) );
  MX4X1 U86 ( .A(register_file_0__15_), .B(Reg_S1[15]), .C(Reg_S2[15]), .D(
        Reg_S3[15]), .S0(n416), .S1(Read_register2[1]), .Y(n407) );
  MX4X1 U87 ( .A(Reg_S8[15]), .B(register_file_9__15_), .C(
        register_file_10__15_), .D(register_file_11__15_), .S0(n416), .S1(
        Read_register2[1]), .Y(n405) );
  MX4X1 U88 ( .A(n260), .B(n258), .C(n259), .D(n257), .S0(n343), .S1(n342), 
        .Y(Read_data1[0]) );
  MX4X1 U89 ( .A(register_file_0__0_), .B(Reg_S1[0]), .C(Reg_S2[0]), .D(
        Reg_S3[0]), .S0(Read_register1[0]), .S1(Read_register1[1]), .Y(n260)
         );
  MX4X1 U90 ( .A(Reg_S8[0]), .B(register_file_9__0_), .C(register_file_10__0_), 
        .D(register_file_11__0_), .S0(Read_register1[0]), .S1(
        Read_register1[1]), .Y(n258) );
  MX4X1 U91 ( .A(n276), .B(n274), .C(n275), .D(n273), .S0(n343), .S1(n342), 
        .Y(Read_data1[1]) );
  MX4X1 U92 ( .A(register_file_0__1_), .B(Reg_S1[1]), .C(Reg_S2[1]), .D(
        Reg_S3[1]), .S0(n338), .S1(n334), .Y(n276) );
  MX4X1 U93 ( .A(Reg_S8[1]), .B(register_file_9__1_), .C(register_file_10__1_), 
        .D(register_file_11__1_), .S0(n338), .S1(n334), .Y(n274) );
  MX4X1 U94 ( .A(n280), .B(n278), .C(n279), .D(n277), .S0(n343), .S1(n342), 
        .Y(Read_data1[2]) );
  MX4X1 U95 ( .A(register_file_0__2_), .B(Reg_S1[2]), .C(Reg_S2[2]), .D(
        Reg_S3[2]), .S0(n338), .S1(n334), .Y(n280) );
  MX4X1 U96 ( .A(Reg_S8[2]), .B(register_file_9__2_), .C(register_file_10__2_), 
        .D(register_file_11__2_), .S0(n338), .S1(n334), .Y(n278) );
  MX4X1 U97 ( .A(n284), .B(n282), .C(n283), .D(n281), .S0(n343), .S1(n342), 
        .Y(Read_data1[3]) );
  MX4X1 U98 ( .A(register_file_0__3_), .B(Reg_S1[3]), .C(Reg_S2[3]), .D(
        Reg_S3[3]), .S0(n338), .S1(n334), .Y(n284) );
  MX4X1 U99 ( .A(Reg_S8[3]), .B(register_file_9__3_), .C(register_file_10__3_), 
        .D(register_file_11__3_), .S0(n338), .S1(n334), .Y(n282) );
  MX4X1 U100 ( .A(n288), .B(n286), .C(n287), .D(n285), .S0(n343), .S1(n342), 
        .Y(Read_data1[4]) );
  MX4X1 U101 ( .A(register_file_0__4_), .B(Reg_S1[4]), .C(Reg_S2[4]), .D(
        Reg_S3[4]), .S0(n339), .S1(n335), .Y(n288) );
  MX4X1 U102 ( .A(Reg_S8[4]), .B(register_file_9__4_), .C(register_file_10__4_), .D(register_file_11__4_), .S0(n339), .S1(n335), .Y(n286) );
  MX4X1 U103 ( .A(n292), .B(n290), .C(n291), .D(n289), .S0(n343), .S1(n342), 
        .Y(Read_data1[5]) );
  MX4X1 U104 ( .A(register_file_0__5_), .B(Reg_S1[5]), .C(Reg_S2[5]), .D(
        Reg_S3[5]), .S0(n339), .S1(n335), .Y(n292) );
  MX4X1 U105 ( .A(Reg_S8[5]), .B(register_file_9__5_), .C(register_file_10__5_), .D(register_file_11__5_), .S0(n339), .S1(n335), .Y(n290) );
  MX4X1 U106 ( .A(n296), .B(n294), .C(n295), .D(n293), .S0(n343), .S1(n342), 
        .Y(Read_data1[6]) );
  MX4X1 U107 ( .A(register_file_0__6_), .B(Reg_S1[6]), .C(Reg_S2[6]), .D(
        Reg_S3[6]), .S0(n339), .S1(n335), .Y(n296) );
  MX4X1 U108 ( .A(Reg_S8[6]), .B(register_file_9__6_), .C(register_file_10__6_), .D(register_file_11__6_), .S0(n339), .S1(n335), .Y(n294) );
  MX4X1 U109 ( .A(n300), .B(n298), .C(n299), .D(n297), .S0(n343), .S1(n342), 
        .Y(Read_data1[7]) );
  MX4X1 U110 ( .A(register_file_0__7_), .B(Reg_S1[7]), .C(Reg_S2[7]), .D(
        Reg_S3[7]), .S0(n340), .S1(n336), .Y(n300) );
  MX4X1 U111 ( .A(Reg_S8[7]), .B(register_file_9__7_), .C(register_file_10__7_), .D(register_file_11__7_), .S0(n340), .S1(n336), .Y(n298) );
  MX4X1 U112 ( .A(n304), .B(n302), .C(n303), .D(n301), .S0(n343), .S1(n342), 
        .Y(Read_data1[8]) );
  MX4X1 U113 ( .A(register_file_0__8_), .B(Reg_S1[8]), .C(Reg_S2[8]), .D(
        Reg_S3[8]), .S0(n340), .S1(n336), .Y(n304) );
  MX4X1 U114 ( .A(Reg_S8[8]), .B(register_file_9__8_), .C(register_file_10__8_), .D(register_file_11__8_), .S0(n340), .S1(n336), .Y(n302) );
  MX4X1 U115 ( .A(n308), .B(n306), .C(n307), .D(n305), .S0(n343), .S1(n342), 
        .Y(Read_data1[9]) );
  MX4X1 U116 ( .A(register_file_0__9_), .B(Reg_S1[9]), .C(Reg_S2[9]), .D(
        Reg_S3[9]), .S0(n340), .S1(n336), .Y(n308) );
  MX4X1 U117 ( .A(Reg_S8[9]), .B(register_file_9__9_), .C(register_file_10__9_), .D(register_file_11__9_), .S0(n340), .S1(n336), .Y(n306) );
  MX4X1 U118 ( .A(n312), .B(n310), .C(n311), .D(n309), .S0(n343), .S1(n342), 
        .Y(Read_data1[10]) );
  MX4X1 U119 ( .A(register_file_0__10_), .B(Reg_S1[10]), .C(Reg_S2[10]), .D(
        Reg_S3[10]), .S0(Read_register1[0]), .S1(Read_register1[1]), .Y(n312)
         );
  MX4X1 U120 ( .A(Reg_S8[10]), .B(register_file_9__10_), .C(
        register_file_10__10_), .D(register_file_11__10_), .S0(n340), .S1(
        Read_register1[1]), .Y(n310) );
  MX4X1 U121 ( .A(n316), .B(n314), .C(n315), .D(n313), .S0(n343), .S1(n342), 
        .Y(Read_data1[11]) );
  MX4X1 U122 ( .A(register_file_0__11_), .B(Reg_S1[11]), .C(Reg_S2[11]), .D(
        Reg_S3[11]), .S0(Read_register1[0]), .S1(Read_register1[1]), .Y(n316)
         );
  MX4X1 U123 ( .A(Reg_S8[11]), .B(register_file_9__11_), .C(
        register_file_10__11_), .D(register_file_11__11_), .S0(
        Read_register1[0]), .S1(Read_register1[1]), .Y(n314) );
  MX4X1 U124 ( .A(n320), .B(n318), .C(n319), .D(n317), .S0(n343), .S1(n342), 
        .Y(Read_data1[12]) );
  MX4X1 U125 ( .A(register_file_0__12_), .B(Reg_S1[12]), .C(Reg_S2[12]), .D(
        Reg_S3[12]), .S0(Read_register1[0]), .S1(Read_register1[1]), .Y(n320)
         );
  MX4X1 U126 ( .A(Reg_S8[12]), .B(register_file_9__12_), .C(
        register_file_10__12_), .D(register_file_11__12_), .S0(
        Read_register1[0]), .S1(Read_register1[1]), .Y(n318) );
  MX4X1 U127 ( .A(n324), .B(n322), .C(n323), .D(n321), .S0(n343), .S1(n342), 
        .Y(Read_data1[13]) );
  MX4X1 U128 ( .A(register_file_0__13_), .B(Reg_S1[13]), .C(Reg_S2[13]), .D(
        Reg_S3[13]), .S0(n341), .S1(Read_register1[1]), .Y(n324) );
  MX4X1 U129 ( .A(Reg_S8[13]), .B(register_file_9__13_), .C(
        register_file_10__13_), .D(register_file_11__13_), .S0(n341), .S1(
        Read_register1[1]), .Y(n322) );
  MX4X1 U130 ( .A(n328), .B(n326), .C(n327), .D(n325), .S0(n343), .S1(n342), 
        .Y(Read_data1[14]) );
  MX4X1 U131 ( .A(register_file_0__14_), .B(Reg_S1[14]), .C(Reg_S2[14]), .D(
        Reg_S3[14]), .S0(n341), .S1(Read_register1[1]), .Y(n328) );
  MX4X1 U132 ( .A(Reg_S8[14]), .B(register_file_9__14_), .C(
        register_file_10__14_), .D(register_file_11__14_), .S0(n341), .S1(
        Read_register1[1]), .Y(n326) );
  MX4X1 U133 ( .A(n332), .B(n330), .C(n331), .D(n329), .S0(n343), .S1(n342), 
        .Y(Read_data1[15]) );
  MX4X1 U134 ( .A(register_file_0__15_), .B(Reg_S1[15]), .C(Reg_S2[15]), .D(
        Reg_S3[15]), .S0(n341), .S1(Read_register1[1]), .Y(n332) );
  MX4X1 U135 ( .A(Reg_S8[15]), .B(register_file_9__15_), .C(
        register_file_10__15_), .D(register_file_11__15_), .S0(n341), .S1(
        Read_register1[1]), .Y(n330) );
  MX4X1 U136 ( .A(Reg_S4[1]), .B(Reg_S5[1]), .C(Reg_S6[1]), .D(Reg_S7[1]), 
        .S0(n413), .S1(n409), .Y(n350) );
  MX4X1 U137 ( .A(Reg_S4[2]), .B(Reg_S5[2]), .C(Reg_S6[2]), .D(Reg_S7[2]), 
        .S0(n413), .S1(n409), .Y(n354) );
  MX4X1 U138 ( .A(Reg_S4[3]), .B(Reg_S5[3]), .C(Reg_S6[3]), .D(Reg_S7[3]), 
        .S0(n413), .S1(n409), .Y(n358) );
  MX4X1 U139 ( .A(Reg_S4[4]), .B(Reg_S5[4]), .C(Reg_S6[4]), .D(Reg_S7[4]), 
        .S0(n414), .S1(n410), .Y(n362) );
  MX4X1 U140 ( .A(Reg_S4[5]), .B(Reg_S5[5]), .C(Reg_S6[5]), .D(Reg_S7[5]), 
        .S0(n414), .S1(n410), .Y(n366) );
  MX4X1 U141 ( .A(Reg_S4[6]), .B(Reg_S5[6]), .C(Reg_S6[6]), .D(Reg_S7[6]), 
        .S0(n414), .S1(n410), .Y(n370) );
  MX4X1 U142 ( .A(Reg_S4[7]), .B(Reg_S5[7]), .C(Reg_S6[7]), .D(Reg_S7[7]), 
        .S0(n415), .S1(n411), .Y(n374) );
  MX4X1 U143 ( .A(Reg_S4[8]), .B(Reg_S5[8]), .C(Reg_S6[8]), .D(Reg_S7[8]), 
        .S0(n415), .S1(n411), .Y(n378) );
  MX4X1 U144 ( .A(Reg_S4[9]), .B(Reg_S5[9]), .C(Reg_S6[9]), .D(Reg_S7[9]), 
        .S0(n415), .S1(n411), .Y(n382) );
  MX4X1 U145 ( .A(Reg_S4[10]), .B(Reg_S5[10]), .C(Reg_S6[10]), .D(Reg_S7[10]), 
        .S0(n416), .S1(Read_register2[1]), .Y(n386) );
  MX4X1 U146 ( .A(Reg_S4[11]), .B(Reg_S5[11]), .C(Reg_S6[11]), .D(Reg_S7[11]), 
        .S0(n413), .S1(Read_register2[1]), .Y(n390) );
  MX4X1 U147 ( .A(Reg_S4[12]), .B(Reg_S5[12]), .C(Reg_S6[12]), .D(Reg_S7[12]), 
        .S0(n414), .S1(Read_register2[1]), .Y(n394) );
  MX4X1 U148 ( .A(Reg_S4[13]), .B(Reg_S5[13]), .C(Reg_S6[13]), .D(Reg_S7[13]), 
        .S0(n416), .S1(Read_register2[1]), .Y(n398) );
  MX4X1 U149 ( .A(Reg_S4[14]), .B(Reg_S5[14]), .C(Reg_S6[14]), .D(Reg_S7[14]), 
        .S0(n416), .S1(Read_register2[1]), .Y(n402) );
  MX4X1 U150 ( .A(Reg_S4[15]), .B(Reg_S5[15]), .C(Reg_S6[15]), .D(Reg_S7[15]), 
        .S0(n416), .S1(Read_register2[1]), .Y(n406) );
  MX4X1 U151 ( .A(Reg_S4[1]), .B(Reg_S5[1]), .C(Reg_S6[1]), .D(Reg_S7[1]), 
        .S0(n338), .S1(n334), .Y(n275) );
  MX4X1 U152 ( .A(Reg_S4[2]), .B(Reg_S5[2]), .C(Reg_S6[2]), .D(Reg_S7[2]), 
        .S0(n338), .S1(n334), .Y(n279) );
  MX4X1 U153 ( .A(Reg_S4[3]), .B(Reg_S5[3]), .C(Reg_S6[3]), .D(Reg_S7[3]), 
        .S0(n338), .S1(n334), .Y(n283) );
  MX4X1 U154 ( .A(Reg_S4[4]), .B(Reg_S5[4]), .C(Reg_S6[4]), .D(Reg_S7[4]), 
        .S0(n339), .S1(n335), .Y(n287) );
  MX4X1 U155 ( .A(Reg_S4[5]), .B(Reg_S5[5]), .C(Reg_S6[5]), .D(Reg_S7[5]), 
        .S0(n339), .S1(n335), .Y(n291) );
  MX4X1 U156 ( .A(Reg_S4[6]), .B(Reg_S5[6]), .C(Reg_S6[6]), .D(Reg_S7[6]), 
        .S0(n339), .S1(n335), .Y(n295) );
  MX4X1 U157 ( .A(Reg_S4[7]), .B(Reg_S5[7]), .C(Reg_S6[7]), .D(Reg_S7[7]), 
        .S0(n340), .S1(n336), .Y(n299) );
  MX4X1 U158 ( .A(Reg_S4[8]), .B(Reg_S5[8]), .C(Reg_S6[8]), .D(Reg_S7[8]), 
        .S0(n340), .S1(n336), .Y(n303) );
  MX4X1 U159 ( .A(Reg_S4[9]), .B(Reg_S5[9]), .C(Reg_S6[9]), .D(Reg_S7[9]), 
        .S0(n340), .S1(n336), .Y(n307) );
  MX4X1 U160 ( .A(Reg_S4[10]), .B(Reg_S5[10]), .C(Reg_S6[10]), .D(Reg_S7[10]), 
        .S0(n341), .S1(Read_register1[1]), .Y(n311) );
  MX4X1 U161 ( .A(Reg_S4[11]), .B(Reg_S5[11]), .C(Reg_S6[11]), .D(Reg_S7[11]), 
        .S0(n338), .S1(Read_register1[1]), .Y(n315) );
  MX4X1 U162 ( .A(Reg_S4[12]), .B(Reg_S5[12]), .C(Reg_S6[12]), .D(Reg_S7[12]), 
        .S0(n339), .S1(Read_register1[1]), .Y(n319) );
  MX4X1 U163 ( .A(Reg_S4[13]), .B(Reg_S5[13]), .C(Reg_S6[13]), .D(Reg_S7[13]), 
        .S0(n341), .S1(Read_register1[1]), .Y(n323) );
  MX4X1 U164 ( .A(Reg_S4[14]), .B(Reg_S5[14]), .C(Reg_S6[14]), .D(Reg_S7[14]), 
        .S0(n341), .S1(Read_register1[1]), .Y(n327) );
  MX4X1 U165 ( .A(Reg_S4[15]), .B(Reg_S5[15]), .C(Reg_S6[15]), .D(Reg_S7[15]), 
        .S0(n341), .S1(Read_register1[1]), .Y(n331) );
  MX4X1 U166 ( .A(register_file_12__0_), .B(register_file_13__0_), .C(
        register_file_14__0_), .D(register_file_15__0_), .S0(Read_register2[0]), .S1(n409), .Y(n344) );
  MX4X1 U167 ( .A(register_file_12__1_), .B(register_file_13__1_), .C(
        register_file_14__1_), .D(register_file_15__1_), .S0(n413), .S1(n409), 
        .Y(n348) );
  MX4X1 U168 ( .A(register_file_12__2_), .B(register_file_13__2_), .C(
        register_file_14__2_), .D(register_file_15__2_), .S0(n413), .S1(n409), 
        .Y(n352) );
  MX4X1 U169 ( .A(register_file_12__3_), .B(register_file_13__3_), .C(
        register_file_14__3_), .D(register_file_15__3_), .S0(n413), .S1(n409), 
        .Y(n356) );
  MX4X1 U170 ( .A(register_file_12__4_), .B(register_file_13__4_), .C(
        register_file_14__4_), .D(register_file_15__4_), .S0(n414), .S1(n410), 
        .Y(n360) );
  MX4X1 U171 ( .A(register_file_12__5_), .B(register_file_13__5_), .C(
        register_file_14__5_), .D(register_file_15__5_), .S0(n414), .S1(n410), 
        .Y(n364) );
  MX4X1 U172 ( .A(register_file_12__6_), .B(register_file_13__6_), .C(
        register_file_14__6_), .D(register_file_15__6_), .S0(n414), .S1(n410), 
        .Y(n368) );
  MX4X1 U173 ( .A(register_file_12__7_), .B(register_file_13__7_), .C(
        register_file_14__7_), .D(register_file_15__7_), .S0(n415), .S1(n411), 
        .Y(n372) );
  MX4X1 U174 ( .A(register_file_12__8_), .B(register_file_13__8_), .C(
        register_file_14__8_), .D(register_file_15__8_), .S0(n415), .S1(n411), 
        .Y(n376) );
  MX4X1 U175 ( .A(register_file_12__9_), .B(register_file_13__9_), .C(
        register_file_14__9_), .D(register_file_15__9_), .S0(n415), .S1(n411), 
        .Y(n380) );
  MX4X1 U176 ( .A(register_file_12__10_), .B(register_file_13__10_), .C(
        register_file_14__10_), .D(register_file_15__10_), .S0(
        Read_register2[0]), .S1(n411), .Y(n384) );
  MX4X1 U177 ( .A(register_file_12__11_), .B(register_file_13__11_), .C(
        register_file_14__11_), .D(register_file_15__11_), .S0(
        Read_register2[0]), .S1(n409), .Y(n388) );
  MX4X1 U178 ( .A(register_file_12__12_), .B(register_file_13__12_), .C(
        register_file_14__12_), .D(register_file_15__12_), .S0(
        Read_register2[0]), .S1(Read_register2[1]), .Y(n392) );
  MX4X1 U179 ( .A(register_file_12__13_), .B(register_file_13__13_), .C(
        register_file_14__13_), .D(register_file_15__13_), .S0(n416), .S1(n410), .Y(n396) );
  MX4X1 U180 ( .A(register_file_12__14_), .B(register_file_13__14_), .C(
        register_file_14__14_), .D(register_file_15__14_), .S0(n416), .S1(n410), .Y(n400) );
  MX4X1 U181 ( .A(register_file_12__15_), .B(register_file_13__15_), .C(
        register_file_14__15_), .D(register_file_15__15_), .S0(n416), .S1(n411), .Y(n404) );
  MX4X1 U182 ( .A(register_file_12__0_), .B(register_file_13__0_), .C(
        register_file_14__0_), .D(register_file_15__0_), .S0(Read_register1[0]), .S1(n334), .Y(n257) );
  MX4X1 U183 ( .A(register_file_12__1_), .B(register_file_13__1_), .C(
        register_file_14__1_), .D(register_file_15__1_), .S0(n338), .S1(n334), 
        .Y(n273) );
  MX4X1 U184 ( .A(register_file_12__2_), .B(register_file_13__2_), .C(
        register_file_14__2_), .D(register_file_15__2_), .S0(n338), .S1(n334), 
        .Y(n277) );
  MX4X1 U185 ( .A(register_file_12__3_), .B(register_file_13__3_), .C(
        register_file_14__3_), .D(register_file_15__3_), .S0(n338), .S1(n334), 
        .Y(n281) );
  MX4X1 U186 ( .A(register_file_12__4_), .B(register_file_13__4_), .C(
        register_file_14__4_), .D(register_file_15__4_), .S0(n339), .S1(n335), 
        .Y(n285) );
  MX4X1 U187 ( .A(register_file_12__5_), .B(register_file_13__5_), .C(
        register_file_14__5_), .D(register_file_15__5_), .S0(n339), .S1(n335), 
        .Y(n289) );
  MX4X1 U188 ( .A(register_file_12__6_), .B(register_file_13__6_), .C(
        register_file_14__6_), .D(register_file_15__6_), .S0(n339), .S1(n335), 
        .Y(n293) );
  MX4X1 U189 ( .A(register_file_12__7_), .B(register_file_13__7_), .C(
        register_file_14__7_), .D(register_file_15__7_), .S0(n340), .S1(n336), 
        .Y(n297) );
  MX4X1 U190 ( .A(register_file_12__8_), .B(register_file_13__8_), .C(
        register_file_14__8_), .D(register_file_15__8_), .S0(n340), .S1(n336), 
        .Y(n301) );
  MX4X1 U191 ( .A(register_file_12__9_), .B(register_file_13__9_), .C(
        register_file_14__9_), .D(register_file_15__9_), .S0(n340), .S1(n336), 
        .Y(n305) );
  MX4X1 U192 ( .A(register_file_12__10_), .B(register_file_13__10_), .C(
        register_file_14__10_), .D(register_file_15__10_), .S0(
        Read_register1[0]), .S1(n336), .Y(n309) );
  MX4X1 U193 ( .A(register_file_12__11_), .B(register_file_13__11_), .C(
        register_file_14__11_), .D(register_file_15__11_), .S0(
        Read_register1[0]), .S1(n334), .Y(n313) );
  MX4X1 U194 ( .A(register_file_12__12_), .B(register_file_13__12_), .C(
        register_file_14__12_), .D(register_file_15__12_), .S0(
        Read_register1[0]), .S1(Read_register1[1]), .Y(n317) );
  MX4X1 U195 ( .A(register_file_12__13_), .B(register_file_13__13_), .C(
        register_file_14__13_), .D(register_file_15__13_), .S0(n341), .S1(n335), .Y(n321) );
  MX4X1 U196 ( .A(register_file_12__14_), .B(register_file_13__14_), .C(
        register_file_14__14_), .D(register_file_15__14_), .S0(n341), .S1(n335), .Y(n325) );
  MX4X1 U197 ( .A(register_file_12__15_), .B(register_file_13__15_), .C(
        register_file_14__15_), .D(register_file_15__15_), .S0(n341), .S1(n336), .Y(n329) );
  BUFX3 U198 ( .A(Read_register2[3]), .Y(n418) );
  BUFX3 U199 ( .A(Read_register1[3]), .Y(n343) );
  BUFX3 U200 ( .A(Read_register2[2]), .Y(n417) );
  BUFX3 U201 ( .A(Read_register1[2]), .Y(n342) );
  MX4X1 U202 ( .A(Reg_S4[0]), .B(Reg_S5[0]), .C(Reg_S6[0]), .D(Reg_S7[0]), 
        .S0(Read_register2[0]), .S1(Read_register2[1]), .Y(n346) );
  MX4X1 U203 ( .A(Reg_S4[0]), .B(Reg_S5[0]), .C(Reg_S6[0]), .D(Reg_S7[0]), 
        .S0(Read_register1[0]), .S1(Read_register1[1]), .Y(n259) );
  AND2X2 U204 ( .A(RegWrite), .B(n438), .Y(n272) );
  NAND2X1 U205 ( .A(Write_register[2]), .B(Write_register[1]), .Y(n262) );
  NAND2X1 U206 ( .A(Write_register[0]), .B(n267), .Y(n261) );
  NAND2X1 U207 ( .A(n271), .B(Write_register[0]), .Y(n269) );
  NAND2X1 U208 ( .A(Write_register[1]), .B(n435), .Y(n265) );
  NAND2X1 U209 ( .A(Write_register[2]), .B(n436), .Y(n264) );
  NOR2BX1 U210 ( .AN(n268), .B(Write_register[3]), .Y(n271) );
  INVX1 U211 ( .A(Write_register[2]), .Y(n435) );
  INVX1 U212 ( .A(Write_register[1]), .Y(n436) );
  INVX1 U213 ( .A(Write_register[0]), .Y(n437) );
  NOR2BX1 U214 ( .AN(n272), .B(Write_register[4]), .Y(n268) );
  AND2X2 U215 ( .A(Write_register[3]), .B(n268), .Y(n267) );
  INVX1 U216 ( .A(rst), .Y(n438) );
  BUFX3 U217 ( .A(N20), .Y(n419) );
  AND2X2 U218 ( .A(Write_data[0]), .B(n272), .Y(N20) );
  BUFX3 U219 ( .A(N21), .Y(n420) );
  AND2X2 U220 ( .A(Write_data[1]), .B(n272), .Y(N21) );
  BUFX3 U221 ( .A(N22), .Y(n421) );
  AND2X2 U222 ( .A(Write_data[2]), .B(n272), .Y(N22) );
  BUFX3 U223 ( .A(N23), .Y(n422) );
  AND2X2 U224 ( .A(Write_data[3]), .B(n272), .Y(N23) );
  BUFX3 U225 ( .A(N24), .Y(n423) );
  AND2X2 U226 ( .A(Write_data[4]), .B(n272), .Y(N24) );
  BUFX3 U227 ( .A(N25), .Y(n424) );
  AND2X2 U228 ( .A(Write_data[5]), .B(n272), .Y(N25) );
  BUFX3 U229 ( .A(N26), .Y(n425) );
  AND2X2 U230 ( .A(Write_data[6]), .B(n272), .Y(N26) );
  BUFX3 U231 ( .A(N27), .Y(n426) );
  AND2X2 U232 ( .A(Write_data[7]), .B(n272), .Y(N27) );
  BUFX3 U233 ( .A(N28), .Y(n427) );
  AND2X2 U234 ( .A(Write_data[8]), .B(n272), .Y(N28) );
  BUFX3 U235 ( .A(N29), .Y(n428) );
  AND2X2 U236 ( .A(Write_data[9]), .B(n272), .Y(N29) );
  BUFX3 U237 ( .A(N30), .Y(n429) );
  AND2X2 U238 ( .A(Write_data[10]), .B(n272), .Y(N30) );
  BUFX3 U239 ( .A(N31), .Y(n430) );
  AND2X2 U240 ( .A(Write_data[11]), .B(n272), .Y(N31) );
  BUFX3 U241 ( .A(N32), .Y(n431) );
  AND2X2 U242 ( .A(Write_data[12]), .B(n272), .Y(N32) );
  BUFX3 U243 ( .A(N33), .Y(n432) );
  AND2X2 U244 ( .A(Write_data[13]), .B(n272), .Y(N33) );
  BUFX3 U245 ( .A(N34), .Y(n433) );
  AND2X2 U246 ( .A(Write_data[14]), .B(n272), .Y(N34) );
  BUFX3 U247 ( .A(N35), .Y(n434) );
  AND2X2 U248 ( .A(Write_data[15]), .B(n272), .Y(N35) );
endmodule


module ID_MUX ( stall, RegWrite_in, MemtoReg_in, Branch_in, MemRead_in, 
        MemWrite_in, ALUSrc_in, ALUop_in, RegDst_in, RegWrite_out, 
        MemtoReg_out, Branch_out, MemRead_out, MemWrite_out, ALUSrc_out, 
        ALUop_out, RegDst_out );
  input [1:0] ALUop_in;
  output [1:0] ALUop_out;
  input stall, RegWrite_in, MemtoReg_in, Branch_in, MemRead_in, MemWrite_in,
         ALUSrc_in, RegDst_in;
  output RegWrite_out, MemtoReg_out, Branch_out, MemRead_out, MemWrite_out,
         ALUSrc_out, RegDst_out;
  wire   n1;

  NOR2BX1 U3 ( .AN(MemRead_in), .B(n1), .Y(MemRead_out) );
  NOR2BX1 U4 ( .AN(ALUop_in[0]), .B(n1), .Y(ALUop_out[0]) );
  OR2X2 U5 ( .A(ALUop_in[1]), .B(n1), .Y(ALUop_out[1]) );
  NOR2BX1 U6 ( .AN(ALUSrc_in), .B(n1), .Y(ALUSrc_out) );
  NOR2BX1 U7 ( .AN(RegDst_in), .B(n1), .Y(RegDst_out) );
  NOR2BX1 U8 ( .AN(Branch_in), .B(n1), .Y(Branch_out) );
  NOR2BX1 U9 ( .AN(MemtoReg_in), .B(n1), .Y(MemtoReg_out) );
  NOR2BX1 U10 ( .AN(RegWrite_in), .B(n1), .Y(RegWrite_out) );
  BUFX3 U11 ( .A(stall), .Y(n1) );
  OR2X2 U12 ( .A(n1), .B(MemWrite_in), .Y(MemWrite_out) );
endmodule


module Idecode ( clk, rst, WRITE_RegADDR, Instruction, MemtoReg_in, 
        RegWrite_in, ALU_result, read_datain, Reg_S1, Reg_S2, Reg_S3, Reg_S4, 
        Reg_S5, Reg_S6, Reg_S7, Reg_S8, RegWrite, MemtoReg, Branch, MemRead, 
        MemWrite, RegDst, ALUop, ALUSrc, Jump, read_data1, read_data2, 
        Sign_extend, INS_25to21, INS_20to16, INS_15to11, INS_10to6, stall, 
        branch_taken, Opcode );
  input [4:0] WRITE_RegADDR;
  input [31:0] Instruction;
  input [15:0] ALU_result;
  input [15:0] read_datain;
  output [15:0] Reg_S1;
  output [15:0] Reg_S2;
  output [15:0] Reg_S3;
  output [15:0] Reg_S4;
  output [15:0] Reg_S5;
  output [15:0] Reg_S6;
  output [15:0] Reg_S7;
  output [15:0] Reg_S8;
  output [1:0] ALUop;
  output [15:0] read_data1;
  output [15:0] read_data2;
  output [31:0] Sign_extend;
  output [4:0] INS_25to21;
  output [4:0] INS_20to16;
  output [4:0] INS_15to11;
  output [4:0] INS_10to6;
  output [5:0] Opcode;
  input clk, rst, MemtoReg_in, RegWrite_in, stall, branch_taken;
  output RegWrite, MemtoReg, Branch, MemRead, MemWrite, RegDst, ALUSrc, Jump;
  wire   Branch_muxin, RegDst_muxin, ALUSrc_muxin, MemtoReg_muxin,
         RegWrite_muxin, MemRead_muxin, MemWrite_muxin, n1, n2, n3, n4, n5, n6,
         n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n91, n92,
         n93, n94, n95, n96, n97, n98, n99, n100, n101;
  wire   [1:0] ALUop_muxin;

  control CTRL ( .clk(clk), .rst(rst), .Opcode(Instruction[31:26]), .ALUop(
        ALUop_muxin), .Branch(Branch_muxin), .Jump(Jump), .RegDst(RegDst_muxin), .ALUSrc(ALUSrc_muxin), .MemtoReg(MemtoReg_muxin), .RegWrite(RegWrite_muxin), 
        .MemRead(MemRead_muxin), .MemWrite(MemWrite_muxin) );
  Registers u_register ( .Read_register1(Instruction[25:21]), .Read_register2(
        Instruction[20:16]), .Write_register(WRITE_RegADDR), .Write_data({n10, 
        n11, n12, n13, n14, n15, n1, n2, n3, n4, n5, n6, n7, n8, n9, n16}), 
        .Read_data1(read_data1), .Read_data2(read_data2), .RegWrite(
        RegWrite_in), .Reg_S1(Reg_S1), .Reg_S2(Reg_S2), .Reg_S3(Reg_S3), 
        .Reg_S4(Reg_S4), .Reg_S5(Reg_S5), .Reg_S6(Reg_S6), .Reg_S7(Reg_S7), 
        .Reg_S8(Reg_S8), .rst(rst) );
  ID_MUX u_IDMUX ( .stall(stall), .RegWrite_in(RegWrite_muxin), .MemtoReg_in(
        MemtoReg_muxin), .Branch_in(Branch_muxin), .MemRead_in(MemRead_muxin), 
        .MemWrite_in(MemWrite_muxin), .ALUSrc_in(ALUSrc_muxin), .ALUop_in(
        ALUop_muxin), .RegDst_in(RegDst_muxin), .RegWrite_out(RegWrite), 
        .MemtoReg_out(MemtoReg), .Branch_out(Branch), .MemRead_out(MemRead), 
        .MemWrite_out(MemWrite), .ALUSrc_out(ALUSrc), .ALUop_out(ALUop), 
        .RegDst_out(RegDst) );
  INVX1 U1 ( .A(n91), .Y(n100) );
  INVX1 U2 ( .A(n93), .Y(n101) );
  INVX1 U3 ( .A(n99), .Y(n94) );
  INVX1 U4 ( .A(n98), .Y(n93) );
  INVX1 U5 ( .A(n98), .Y(n92) );
  INVX1 U6 ( .A(n99), .Y(n97) );
  INVX1 U7 ( .A(n99), .Y(n96) );
  INVX1 U8 ( .A(n98), .Y(n95) );
  INVX1 U9 ( .A(n99), .Y(n91) );
  INVX1 U10 ( .A(MemtoReg_in), .Y(n99) );
  INVX1 U11 ( .A(MemtoReg_in), .Y(n98) );
  BUFX3 U12 ( .A(Instruction[16]), .Y(INS_20to16[0]) );
  BUFX3 U13 ( .A(Instruction[17]), .Y(INS_20to16[1]) );
  BUFX3 U14 ( .A(Instruction[21]), .Y(INS_25to21[0]) );
  BUFX3 U15 ( .A(Instruction[22]), .Y(INS_25to21[1]) );
  BUFX3 U16 ( .A(Instruction[6]), .Y(INS_10to6[0]) );
  BUFX3 U17 ( .A(Instruction[18]), .Y(INS_20to16[2]) );
  BUFX3 U18 ( .A(Instruction[19]), .Y(INS_20to16[3]) );
  BUFX3 U19 ( .A(Instruction[20]), .Y(INS_20to16[4]) );
  BUFX3 U20 ( .A(Instruction[0]), .Y(Sign_extend[0]) );
  BUFX3 U21 ( .A(Instruction[1]), .Y(Sign_extend[1]) );
  BUFX3 U22 ( .A(Instruction[2]), .Y(Sign_extend[2]) );
  BUFX3 U23 ( .A(Instruction[3]), .Y(Sign_extend[3]) );
  BUFX3 U24 ( .A(Instruction[4]), .Y(Sign_extend[4]) );
  BUFX3 U25 ( .A(Instruction[5]), .Y(Sign_extend[5]) );
  BUFX3 U26 ( .A(Instruction[6]), .Y(Sign_extend[6]) );
  BUFX3 U27 ( .A(Instruction[30]), .Y(Opcode[4]) );
  BUFX3 U28 ( .A(Instruction[31]), .Y(Opcode[5]) );
  BUFX3 U29 ( .A(Instruction[26]), .Y(Opcode[0]) );
  BUFX3 U30 ( .A(Instruction[27]), .Y(Opcode[1]) );
  BUFX3 U31 ( .A(Instruction[28]), .Y(Opcode[2]) );
  BUFX3 U32 ( .A(Instruction[29]), .Y(Opcode[3]) );
  BUFX3 U33 ( .A(Instruction[23]), .Y(INS_25to21[2]) );
  BUFX3 U34 ( .A(Instruction[24]), .Y(INS_25to21[3]) );
  BUFX3 U35 ( .A(Instruction[25]), .Y(INS_25to21[4]) );
  INVX1 U36 ( .A(n33), .Y(n16) );
  AOI22X1 U37 ( .A0(ALU_result[0]), .A1(n100), .B0(read_datain[0]), .B1(n97), 
        .Y(n33) );
  INVX1 U38 ( .A(n26), .Y(n9) );
  AOI22X1 U39 ( .A0(ALU_result[1]), .A1(n100), .B0(read_datain[1]), .B1(
        MemtoReg_in), .Y(n26) );
  INVX1 U40 ( .A(n25), .Y(n8) );
  AOI22X1 U41 ( .A0(ALU_result[2]), .A1(n100), .B0(read_datain[2]), .B1(n94), 
        .Y(n25) );
  INVX1 U42 ( .A(n24), .Y(n7) );
  AOI22X1 U43 ( .A0(ALU_result[3]), .A1(n100), .B0(read_datain[3]), .B1(n94), 
        .Y(n24) );
  INVX1 U44 ( .A(n23), .Y(n6) );
  AOI22X1 U45 ( .A0(ALU_result[4]), .A1(n100), .B0(read_datain[4]), .B1(n93), 
        .Y(n23) );
  INVX1 U46 ( .A(n22), .Y(n5) );
  AOI22X1 U47 ( .A0(ALU_result[5]), .A1(n100), .B0(read_datain[5]), .B1(n93), 
        .Y(n22) );
  INVX1 U48 ( .A(n21), .Y(n4) );
  AOI22X1 U49 ( .A0(ALU_result[6]), .A1(n101), .B0(read_datain[6]), .B1(n92), 
        .Y(n21) );
  INVX1 U50 ( .A(n20), .Y(n3) );
  AOI22X1 U51 ( .A0(ALU_result[7]), .A1(n101), .B0(read_datain[7]), .B1(n92), 
        .Y(n20) );
  INVX1 U52 ( .A(n19), .Y(n2) );
  AOI22X1 U53 ( .A0(ALU_result[8]), .A1(n101), .B0(read_datain[8]), .B1(n91), 
        .Y(n19) );
  INVX1 U54 ( .A(n18), .Y(n1) );
  AOI22X1 U55 ( .A0(ALU_result[9]), .A1(n101), .B0(read_datain[9]), .B1(n91), 
        .Y(n18) );
  INVX1 U56 ( .A(n32), .Y(n15) );
  AOI22X1 U57 ( .A0(ALU_result[10]), .A1(n100), .B0(read_datain[10]), .B1(n97), 
        .Y(n32) );
  INVX1 U58 ( .A(n31), .Y(n14) );
  AOI22X1 U59 ( .A0(ALU_result[11]), .A1(n100), .B0(read_datain[11]), .B1(n96), 
        .Y(n31) );
  INVX1 U60 ( .A(n30), .Y(n13) );
  AOI22X1 U61 ( .A0(ALU_result[12]), .A1(n100), .B0(read_datain[12]), .B1(n96), 
        .Y(n30) );
  INVX1 U62 ( .A(n29), .Y(n12) );
  AOI22X1 U63 ( .A0(ALU_result[13]), .A1(n100), .B0(read_datain[13]), .B1(n95), 
        .Y(n29) );
  INVX1 U64 ( .A(n28), .Y(n11) );
  AOI22X1 U65 ( .A0(ALU_result[14]), .A1(n100), .B0(read_datain[14]), .B1(n95), 
        .Y(n28) );
  INVX1 U66 ( .A(n27), .Y(n10) );
  AOI22X1 U67 ( .A0(ALU_result[15]), .A1(n100), .B0(read_datain[15]), .B1(n96), 
        .Y(n27) );
  BUFX3 U68 ( .A(Sign_extend[31]), .Y(Sign_extend[30]) );
  BUFX3 U69 ( .A(Sign_extend[31]), .Y(Sign_extend[29]) );
  BUFX3 U70 ( .A(Sign_extend[31]), .Y(Sign_extend[28]) );
  BUFX3 U71 ( .A(Sign_extend[31]), .Y(Sign_extend[27]) );
  BUFX3 U72 ( .A(Sign_extend[31]), .Y(Sign_extend[26]) );
  BUFX3 U73 ( .A(Sign_extend[31]), .Y(Sign_extend[25]) );
  BUFX3 U74 ( .A(Sign_extend[31]), .Y(Sign_extend[24]) );
  BUFX3 U75 ( .A(Sign_extend[31]), .Y(Sign_extend[23]) );
  BUFX3 U76 ( .A(Sign_extend[31]), .Y(Sign_extend[22]) );
  BUFX3 U77 ( .A(Sign_extend[31]), .Y(Sign_extend[21]) );
  BUFX3 U78 ( .A(Sign_extend[31]), .Y(Sign_extend[20]) );
  BUFX3 U79 ( .A(Sign_extend[31]), .Y(Sign_extend[19]) );
  BUFX3 U80 ( .A(Sign_extend[31]), .Y(Sign_extend[18]) );
  BUFX3 U81 ( .A(Sign_extend[31]), .Y(Sign_extend[17]) );
  BUFX3 U82 ( .A(Sign_extend[31]), .Y(Sign_extend[16]) );
  BUFX3 U83 ( .A(Sign_extend[31]), .Y(Sign_extend[15]) );
  BUFX3 U84 ( .A(Sign_extend[31]), .Y(INS_15to11[4]) );
  BUFX3 U85 ( .A(Instruction[15]), .Y(Sign_extend[31]) );
  BUFX3 U86 ( .A(Instruction[14]), .Y(Sign_extend[14]) );
  BUFX3 U87 ( .A(Instruction[14]), .Y(INS_15to11[3]) );
  BUFX3 U88 ( .A(Instruction[13]), .Y(Sign_extend[13]) );
  BUFX3 U89 ( .A(Instruction[13]), .Y(INS_15to11[2]) );
  BUFX3 U90 ( .A(Instruction[12]), .Y(Sign_extend[12]) );
  BUFX3 U91 ( .A(Instruction[12]), .Y(INS_15to11[1]) );
  BUFX3 U92 ( .A(Instruction[11]), .Y(Sign_extend[11]) );
  BUFX3 U93 ( .A(Instruction[11]), .Y(INS_15to11[0]) );
  BUFX3 U94 ( .A(Instruction[10]), .Y(Sign_extend[10]) );
  BUFX3 U95 ( .A(Instruction[10]), .Y(INS_10to6[4]) );
  BUFX3 U96 ( .A(Instruction[9]), .Y(Sign_extend[9]) );
  BUFX3 U97 ( .A(Instruction[9]), .Y(INS_10to6[3]) );
  BUFX3 U98 ( .A(Instruction[8]), .Y(Sign_extend[8]) );
  BUFX3 U99 ( .A(Instruction[8]), .Y(INS_10to6[2]) );
  BUFX3 U100 ( .A(Instruction[7]), .Y(Sign_extend[7]) );
  BUFX3 U101 ( .A(Instruction[7]), .Y(INS_10to6[1]) );
endmodule


module ID_EXreg ( clk, rst, RS_ADDRIN, RT_ADDRIN, RD_ADDRIN, SHAME_ADDRIN, 
        RS_IN, RT_IN, OFFSET_IN, RegWrite, MemtoReg, Branch, MemRead, MemWrite, 
        RegDst, ALUSrc, ALUop, RS_ADDROUT, RT_ADDROUT, RD_ADDROUT, 
        SHAMT_ADDROUT, RS_OUT, RT_OUT, OFFSET_OUT, ALUop_out, RegWrite_out, 
        MemtoReg_out, Branch_out, MemRead_out, MemWrite_out, RegDst_out, 
        ALUSrc_out, Opcode_in, Opcode_out, stall, branch_taken );
  input [4:0] RS_ADDRIN;
  input [4:0] RT_ADDRIN;
  input [4:0] RD_ADDRIN;
  input [4:0] SHAME_ADDRIN;
  input [15:0] RS_IN;
  input [15:0] RT_IN;
  input [31:0] OFFSET_IN;
  input [1:0] ALUop;
  output [4:0] RS_ADDROUT;
  output [4:0] RT_ADDROUT;
  output [4:0] RD_ADDROUT;
  output [4:0] SHAMT_ADDROUT;
  output [15:0] RS_OUT;
  output [15:0] RT_OUT;
  output [31:0] OFFSET_OUT;
  output [1:0] ALUop_out;
  input [5:0] Opcode_in;
  output [5:0] Opcode_out;
  input clk, rst, RegWrite, MemtoReg, Branch, MemRead, MemWrite, RegDst,
         ALUSrc, stall, branch_taken;
  output RegWrite_out, MemtoReg_out, Branch_out, MemRead_out, MemWrite_out,
         RegDst_out, ALUSrc_out;
  wire   N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17,
         N18, N19, N20, N21, N22, N23, N24, N25, N26, N27, N28, N29, N30, N31,
         N32, N33, N34, N35, N36, N37, N38, N39, N40, N41, N42, N43, N44, N45,
         N46, N47, N48, N49, N50, N51, N52, N53, N54, N55, N56, N57, N58, N59,
         N60, N61, N62, N63, N64, N65, N66, N67, N68, N69, N70, N71, N72, N73,
         N74, N75, N76, N77, N78, N79, N80, N81, N82, N83, N84, N85, N86, N87,
         N88, N89, N90, N91, N92, N93, N94, N95, N96, N97, N98, N99, N100,
         N101, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n18;

  DFFRHQX1 ALUop_out_reg_0_ ( .D(N84), .CK(clk), .RN(n9), .Q(ALUop_out[0]) );
  DFFRHQX1 ALUop_out_reg_1_ ( .D(N85), .CK(clk), .RN(n9), .Q(ALUop_out[1]) );
  DFFRHQX1 Opcode_out_reg_2_ ( .D(N98), .CK(clk), .RN(n2), .Q(Opcode_out[2])
         );
  DFFRHQX1 MemRead_out_reg ( .D(N80), .CK(clk), .RN(n9), .Q(MemRead_out) );
  DFFRHQX1 Branch_out_reg ( .D(N79), .CK(clk), .RN(n9), .Q(Branch_out) );
  DFFRHQX1 Opcode_out_reg_0_ ( .D(N96), .CK(clk), .RN(n2), .Q(Opcode_out[0])
         );
  DFFRHQX1 SHAMT_ADDROUT_reg_4_ ( .D(N90), .CK(clk), .RN(n9), .Q(
        SHAMT_ADDROUT[4]) );
  DFFRHQX1 RD_ADDROUT_reg_3_ ( .D(N43), .CK(clk), .RN(n6), .Q(RD_ADDROUT[3])
         );
  DFFRHQX1 RD_ADDROUT_reg_2_ ( .D(N42), .CK(clk), .RN(n6), .Q(RD_ADDROUT[2])
         );
  DFFRHQX1 RD_ADDROUT_reg_1_ ( .D(N41), .CK(clk), .RN(n6), .Q(RD_ADDROUT[1])
         );
  DFFRHQX1 RD_ADDROUT_reg_0_ ( .D(N40), .CK(clk), .RN(n6), .Q(RD_ADDROUT[0])
         );
  DFFRHQX1 RD_ADDROUT_reg_4_ ( .D(N44), .CK(clk), .RN(n6), .Q(RD_ADDROUT[4])
         );
  DFFRHQX1 Opcode_out_reg_5_ ( .D(N101), .CK(clk), .RN(n2), .Q(Opcode_out[5])
         );
  DFFRHQX1 Opcode_out_reg_3_ ( .D(N99), .CK(clk), .RN(n2), .Q(Opcode_out[3])
         );
  DFFRHQX1 Opcode_out_reg_4_ ( .D(N100), .CK(clk), .RN(n2), .Q(Opcode_out[4])
         );
  DFFRHQX1 Opcode_out_reg_1_ ( .D(N97), .CK(clk), .RN(n2), .Q(Opcode_out[1])
         );
  DFFRHQX1 RegDst_out_reg ( .D(N82), .CK(clk), .RN(n9), .Q(RegDst_out) );
  DFFRHQX1 SHAMT_ADDROUT_reg_0_ ( .D(N86), .CK(clk), .RN(n18), .Q(
        SHAMT_ADDROUT[0]) );
  DFFRHQX1 SHAMT_ADDROUT_reg_3_ ( .D(N89), .CK(clk), .RN(n9), .Q(
        SHAMT_ADDROUT[3]) );
  DFFRHQX1 RS_OUT_reg_15_ ( .D(N60), .CK(clk), .RN(n6), .Q(RS_OUT[15]) );
  DFFRHQX1 RS_OUT_reg_14_ ( .D(N59), .CK(clk), .RN(n6), .Q(RS_OUT[14]) );
  DFFRHQX1 RS_OUT_reg_13_ ( .D(N58), .CK(clk), .RN(n6), .Q(RS_OUT[13]) );
  DFFRHQX1 RS_OUT_reg_12_ ( .D(N57), .CK(clk), .RN(n6), .Q(RS_OUT[12]) );
  DFFRHQX1 RS_OUT_reg_11_ ( .D(N56), .CK(clk), .RN(n6), .Q(RS_OUT[11]) );
  DFFRHQX1 RT_OUT_reg_15_ ( .D(N76), .CK(clk), .RN(n7), .Q(RT_OUT[15]) );
  DFFRHQX1 RT_OUT_reg_14_ ( .D(N75), .CK(clk), .RN(n7), .Q(RT_OUT[14]) );
  DFFRHQX1 RT_OUT_reg_13_ ( .D(N74), .CK(clk), .RN(n7), .Q(RT_OUT[13]) );
  DFFRHQX1 SHAMT_ADDROUT_reg_2_ ( .D(N88), .CK(clk), .RN(n18), .Q(
        SHAMT_ADDROUT[2]) );
  DFFRHQX1 OFFSET_OUT_reg_15_ ( .D(N18), .CK(clk), .RN(n4), .Q(OFFSET_OUT[15])
         );
  DFFRHQX1 OFFSET_OUT_reg_14_ ( .D(N17), .CK(clk), .RN(n4), .Q(OFFSET_OUT[14])
         );
  DFFRHQX1 OFFSET_OUT_reg_13_ ( .D(N16), .CK(clk), .RN(n4), .Q(OFFSET_OUT[13])
         );
  DFFRHQX1 OFFSET_OUT_reg_12_ ( .D(N15), .CK(clk), .RN(n4), .Q(OFFSET_OUT[12])
         );
  DFFRHQX1 OFFSET_OUT_reg_11_ ( .D(N14), .CK(clk), .RN(n4), .Q(OFFSET_OUT[11])
         );
  DFFRHQX1 SHAMT_ADDROUT_reg_1_ ( .D(N87), .CK(clk), .RN(n18), .Q(
        SHAMT_ADDROUT[1]) );
  DFFRHQX1 RS_OUT_reg_10_ ( .D(N55), .CK(clk), .RN(n6), .Q(RS_OUT[10]) );
  DFFRHQX1 RS_OUT_reg_9_ ( .D(N54), .CK(clk), .RN(n6), .Q(RS_OUT[9]) );
  DFFRHQX1 RS_OUT_reg_8_ ( .D(N53), .CK(clk), .RN(n7), .Q(RS_OUT[8]) );
  DFFRHQX1 RS_OUT_reg_7_ ( .D(N52), .CK(clk), .RN(n7), .Q(RS_OUT[7]) );
  DFFRHQX1 RS_OUT_reg_6_ ( .D(N51), .CK(clk), .RN(n7), .Q(RS_OUT[6]) );
  DFFRHQX1 RS_OUT_reg_5_ ( .D(N50), .CK(clk), .RN(n7), .Q(RS_OUT[5]) );
  DFFRHQX1 RS_OUT_reg_4_ ( .D(N49), .CK(clk), .RN(n7), .Q(RS_OUT[4]) );
  DFFRHQX1 RS_OUT_reg_3_ ( .D(N48), .CK(clk), .RN(n7), .Q(RS_OUT[3]) );
  DFFRHQX1 RS_OUT_reg_2_ ( .D(N47), .CK(clk), .RN(n7), .Q(RS_OUT[2]) );
  DFFRHQX1 RS_OUT_reg_1_ ( .D(N46), .CK(clk), .RN(n7), .Q(RS_OUT[1]) );
  DFFRHQX1 RS_OUT_reg_0_ ( .D(N45), .CK(clk), .RN(n7), .Q(RS_OUT[0]) );
  DFFRHQX1 RT_OUT_reg_12_ ( .D(N73), .CK(clk), .RN(n8), .Q(RT_OUT[12]) );
  DFFRHQX1 RT_OUT_reg_11_ ( .D(N72), .CK(clk), .RN(n8), .Q(RT_OUT[11]) );
  DFFRHQX1 RT_OUT_reg_10_ ( .D(N71), .CK(clk), .RN(n8), .Q(RT_OUT[10]) );
  DFFRHQX1 RT_OUT_reg_9_ ( .D(N70), .CK(clk), .RN(n8), .Q(RT_OUT[9]) );
  DFFRHQX1 RT_OUT_reg_8_ ( .D(N69), .CK(clk), .RN(n8), .Q(RT_OUT[8]) );
  DFFRHQX1 RT_OUT_reg_7_ ( .D(N68), .CK(clk), .RN(n8), .Q(RT_OUT[7]) );
  DFFRHQX1 RT_OUT_reg_6_ ( .D(N67), .CK(clk), .RN(n8), .Q(RT_OUT[6]) );
  DFFRHQX1 RT_OUT_reg_5_ ( .D(N66), .CK(clk), .RN(n8), .Q(RT_OUT[5]) );
  DFFRHQX1 RT_OUT_reg_4_ ( .D(N65), .CK(clk), .RN(n8), .Q(RT_OUT[4]) );
  DFFRHQX1 RT_OUT_reg_3_ ( .D(N64), .CK(clk), .RN(n8), .Q(RT_OUT[3]) );
  DFFRHQX1 RT_OUT_reg_2_ ( .D(N63), .CK(clk), .RN(n8), .Q(RT_OUT[2]) );
  DFFRHQX1 RT_OUT_reg_1_ ( .D(N62), .CK(clk), .RN(n8), .Q(RT_OUT[1]) );
  DFFRHQX1 RT_OUT_reg_0_ ( .D(N61), .CK(clk), .RN(n9), .Q(RT_OUT[0]) );
  DFFRHQX1 ALUSrc_out_reg ( .D(N83), .CK(clk), .RN(n9), .Q(ALUSrc_out) );
  DFFRHQX1 OFFSET_OUT_reg_10_ ( .D(N13), .CK(clk), .RN(n4), .Q(OFFSET_OUT[10])
         );
  DFFRHQX1 OFFSET_OUT_reg_9_ ( .D(N12), .CK(clk), .RN(n4), .Q(OFFSET_OUT[9])
         );
  DFFRHQX1 OFFSET_OUT_reg_8_ ( .D(N11), .CK(clk), .RN(n4), .Q(OFFSET_OUT[8])
         );
  DFFRHQX1 OFFSET_OUT_reg_7_ ( .D(N10), .CK(clk), .RN(n4), .Q(OFFSET_OUT[7])
         );
  DFFRHQX1 OFFSET_OUT_reg_6_ ( .D(N9), .CK(clk), .RN(n5), .Q(OFFSET_OUT[6]) );
  DFFRHQX1 OFFSET_OUT_reg_4_ ( .D(N7), .CK(clk), .RN(n5), .Q(OFFSET_OUT[4]) );
  DFFRHQX1 OFFSET_OUT_reg_0_ ( .D(N3), .CK(clk), .RN(n5), .Q(OFFSET_OUT[0]) );
  DFFRHQX1 OFFSET_OUT_reg_3_ ( .D(N6), .CK(clk), .RN(n5), .Q(OFFSET_OUT[3]) );
  DFFRHQX1 OFFSET_OUT_reg_2_ ( .D(N5), .CK(clk), .RN(n5), .Q(OFFSET_OUT[2]) );
  DFFRHQX1 OFFSET_OUT_reg_1_ ( .D(N4), .CK(clk), .RN(n5), .Q(OFFSET_OUT[1]) );
  DFFRHQX1 OFFSET_OUT_reg_5_ ( .D(N8), .CK(clk), .RN(n5), .Q(OFFSET_OUT[5]) );
  DFFRHQX1 RS_ADDROUT_reg_4_ ( .D(N95), .CK(clk), .RN(n2), .Q(RS_ADDROUT[4])
         );
  DFFRHQX1 RS_ADDROUT_reg_0_ ( .D(N91), .CK(clk), .RN(n2), .Q(RS_ADDROUT[0])
         );
  DFFRHQX1 RS_ADDROUT_reg_3_ ( .D(N94), .CK(clk), .RN(n2), .Q(RS_ADDROUT[3])
         );
  DFFRHQX1 RS_ADDROUT_reg_2_ ( .D(N93), .CK(clk), .RN(n2), .Q(RS_ADDROUT[2])
         );
  DFFRHQX1 RS_ADDROUT_reg_1_ ( .D(N92), .CK(clk), .RN(n2), .Q(RS_ADDROUT[1])
         );
  DFFRHQX1 RT_ADDROUT_reg_3_ ( .D(N38), .CK(clk), .RN(n5), .Q(RT_ADDROUT[3])
         );
  DFFRHQX1 RT_ADDROUT_reg_2_ ( .D(N37), .CK(clk), .RN(n5), .Q(RT_ADDROUT[2])
         );
  DFFRHQX1 RT_ADDROUT_reg_4_ ( .D(N39), .CK(clk), .RN(n5), .Q(RT_ADDROUT[4])
         );
  DFFRHQX1 RT_ADDROUT_reg_0_ ( .D(N35), .CK(clk), .RN(n5), .Q(RT_ADDROUT[0])
         );
  DFFRHQX1 RT_ADDROUT_reg_1_ ( .D(N36), .CK(clk), .RN(n5), .Q(RT_ADDROUT[1])
         );
  DFFRHQX1 MemWrite_out_reg ( .D(N81), .CK(clk), .RN(n9), .Q(MemWrite_out) );
  DFFRHQX1 OFFSET_OUT_reg_31_ ( .D(N34), .CK(clk), .RN(n2), .Q(OFFSET_OUT[31])
         );
  DFFRHQX1 OFFSET_OUT_reg_30_ ( .D(N33), .CK(clk), .RN(n3), .Q(OFFSET_OUT[30])
         );
  DFFRHQX1 OFFSET_OUT_reg_29_ ( .D(N32), .CK(clk), .RN(n3), .Q(OFFSET_OUT[29])
         );
  DFFRHQX1 OFFSET_OUT_reg_28_ ( .D(N31), .CK(clk), .RN(n3), .Q(OFFSET_OUT[28])
         );
  DFFRHQX1 OFFSET_OUT_reg_27_ ( .D(N30), .CK(clk), .RN(n3), .Q(OFFSET_OUT[27])
         );
  DFFRHQX1 OFFSET_OUT_reg_26_ ( .D(N29), .CK(clk), .RN(n3), .Q(OFFSET_OUT[26])
         );
  DFFRHQX1 OFFSET_OUT_reg_25_ ( .D(N28), .CK(clk), .RN(n3), .Q(OFFSET_OUT[25])
         );
  DFFRHQX1 OFFSET_OUT_reg_24_ ( .D(N27), .CK(clk), .RN(n3), .Q(OFFSET_OUT[24])
         );
  DFFRHQX1 OFFSET_OUT_reg_23_ ( .D(N26), .CK(clk), .RN(n3), .Q(OFFSET_OUT[23])
         );
  DFFRHQX1 OFFSET_OUT_reg_22_ ( .D(N25), .CK(clk), .RN(n3), .Q(OFFSET_OUT[22])
         );
  DFFRHQX1 OFFSET_OUT_reg_21_ ( .D(N24), .CK(clk), .RN(n3), .Q(OFFSET_OUT[21])
         );
  DFFRHQX1 OFFSET_OUT_reg_20_ ( .D(N23), .CK(clk), .RN(n3), .Q(OFFSET_OUT[20])
         );
  DFFRHQX1 OFFSET_OUT_reg_19_ ( .D(N22), .CK(clk), .RN(n3), .Q(OFFSET_OUT[19])
         );
  DFFRHQX1 OFFSET_OUT_reg_18_ ( .D(N21), .CK(clk), .RN(n4), .Q(OFFSET_OUT[18])
         );
  DFFRHQX1 OFFSET_OUT_reg_17_ ( .D(N20), .CK(clk), .RN(n4), .Q(OFFSET_OUT[17])
         );
  DFFRHQX1 OFFSET_OUT_reg_16_ ( .D(N19), .CK(clk), .RN(n4), .Q(OFFSET_OUT[16])
         );
  DFFRHQX1 RegWrite_out_reg ( .D(N77), .CK(clk), .RN(n9), .Q(RegWrite_out) );
  DFFRHQX1 MemtoReg_out_reg ( .D(N78), .CK(clk), .RN(n9), .Q(MemtoReg_out) );
  NOR2X1 U3 ( .A(branch_taken), .B(stall), .Y(n1) );
  INVX1 U4 ( .A(n1), .Y(n14) );
  INVX1 U5 ( .A(n1), .Y(n15) );
  INVX1 U6 ( .A(n1), .Y(n16) );
  INVX1 U7 ( .A(n1), .Y(n12) );
  INVX1 U8 ( .A(n1), .Y(n13) );
  INVX1 U9 ( .A(n1), .Y(n11) );
  INVX1 U10 ( .A(n1), .Y(n17) );
  NOR2BX1 U11 ( .AN(MemRead), .B(n17), .Y(N80) );
  INVX1 U12 ( .A(n10), .Y(n9) );
  INVX1 U13 ( .A(n10), .Y(n8) );
  INVX1 U14 ( .A(n10), .Y(n7) );
  INVX1 U15 ( .A(n10), .Y(n6) );
  INVX1 U16 ( .A(n10), .Y(n5) );
  INVX1 U17 ( .A(n10), .Y(n4) );
  INVX1 U18 ( .A(n10), .Y(n3) );
  NOR2BX1 U19 ( .AN(ALUop[0]), .B(n17), .Y(N84) );
  NOR2BX1 U20 ( .AN(ALUop[1]), .B(n17), .Y(N85) );
  NOR2BX1 U21 ( .AN(ALUSrc), .B(n17), .Y(N83) );
  NOR2BX1 U22 ( .AN(RegDst), .B(n17), .Y(N82) );
  NOR2BX1 U23 ( .AN(Branch), .B(n16), .Y(N79) );
  NOR2BX1 U24 ( .AN(MemtoReg), .B(n16), .Y(N78) );
  NOR2BX1 U25 ( .AN(RegWrite), .B(n16), .Y(N77) );
  NOR2BX1 U26 ( .AN(RD_ADDRIN[4]), .B(n13), .Y(N44) );
  NOR2BX1 U27 ( .AN(RT_ADDRIN[0]), .B(n13), .Y(N35) );
  NOR2BX1 U28 ( .AN(RT_ADDRIN[1]), .B(n13), .Y(N36) );
  NOR2BX1 U29 ( .AN(OFFSET_IN[15]), .B(n11), .Y(N18) );
  NOR2BX1 U30 ( .AN(OFFSET_IN[16]), .B(n11), .Y(N19) );
  NOR2BX1 U31 ( .AN(OFFSET_IN[17]), .B(n11), .Y(N20) );
  NOR2BX1 U32 ( .AN(OFFSET_IN[18]), .B(n12), .Y(N21) );
  NOR2BX1 U33 ( .AN(OFFSET_IN[19]), .B(n12), .Y(N22) );
  NOR2BX1 U34 ( .AN(OFFSET_IN[20]), .B(n12), .Y(N23) );
  NOR2BX1 U35 ( .AN(OFFSET_IN[21]), .B(n12), .Y(N24) );
  NOR2BX1 U36 ( .AN(OFFSET_IN[22]), .B(n12), .Y(N25) );
  NOR2BX1 U37 ( .AN(OFFSET_IN[23]), .B(n12), .Y(N26) );
  NOR2BX1 U38 ( .AN(OFFSET_IN[24]), .B(n12), .Y(N27) );
  NOR2BX1 U39 ( .AN(OFFSET_IN[25]), .B(n12), .Y(N28) );
  NOR2BX1 U40 ( .AN(OFFSET_IN[26]), .B(n12), .Y(N29) );
  NOR2BX1 U41 ( .AN(OFFSET_IN[27]), .B(n12), .Y(N30) );
  NOR2BX1 U42 ( .AN(OFFSET_IN[28]), .B(n12), .Y(N31) );
  NOR2BX1 U43 ( .AN(OFFSET_IN[29]), .B(n12), .Y(N32) );
  NOR2BX1 U44 ( .AN(OFFSET_IN[30]), .B(n13), .Y(N33) );
  NOR2BX1 U45 ( .AN(OFFSET_IN[31]), .B(n13), .Y(N34) );
  NOR2BX1 U46 ( .AN(RS_ADDRIN[0]), .B(n17), .Y(N91) );
  NOR2BX1 U47 ( .AN(RS_ADDRIN[1]), .B(n12), .Y(N92) );
  INVX1 U48 ( .A(n10), .Y(n2) );
  INVX1 U49 ( .A(n18), .Y(n10) );
  NOR2BX1 U50 ( .AN(SHAME_ADDRIN[0]), .B(n17), .Y(N86) );
  NOR2BX1 U51 ( .AN(SHAME_ADDRIN[1]), .B(n17), .Y(N87) );
  NOR2BX1 U52 ( .AN(SHAME_ADDRIN[2]), .B(n17), .Y(N88) );
  NOR2BX1 U53 ( .AN(SHAME_ADDRIN[3]), .B(n17), .Y(N89) );
  NOR2BX1 U54 ( .AN(SHAME_ADDRIN[4]), .B(n17), .Y(N90) );
  NOR2BX1 U55 ( .AN(MemWrite), .B(n17), .Y(N81) );
  NOR2BX1 U56 ( .AN(RT_IN[0]), .B(n15), .Y(N61) );
  NOR2BX1 U57 ( .AN(RT_IN[1]), .B(n15), .Y(N62) );
  NOR2BX1 U58 ( .AN(RT_IN[2]), .B(n15), .Y(N63) );
  NOR2BX1 U59 ( .AN(RT_IN[3]), .B(n15), .Y(N64) );
  NOR2BX1 U60 ( .AN(RT_IN[4]), .B(n15), .Y(N65) );
  NOR2BX1 U61 ( .AN(RT_IN[5]), .B(n15), .Y(N66) );
  NOR2BX1 U62 ( .AN(RT_IN[6]), .B(n15), .Y(N67) );
  NOR2BX1 U63 ( .AN(RT_IN[7]), .B(n15), .Y(N68) );
  NOR2BX1 U64 ( .AN(RT_IN[8]), .B(n16), .Y(N69) );
  NOR2BX1 U65 ( .AN(RT_IN[9]), .B(n16), .Y(N70) );
  NOR2BX1 U66 ( .AN(RT_IN[10]), .B(n16), .Y(N71) );
  NOR2BX1 U67 ( .AN(RT_IN[11]), .B(n16), .Y(N72) );
  NOR2BX1 U68 ( .AN(RT_IN[12]), .B(n16), .Y(N73) );
  NOR2BX1 U69 ( .AN(RT_IN[13]), .B(n16), .Y(N74) );
  NOR2BX1 U70 ( .AN(RT_IN[14]), .B(n16), .Y(N75) );
  NOR2BX1 U71 ( .AN(RT_IN[15]), .B(n16), .Y(N76) );
  NOR2BX1 U72 ( .AN(RS_IN[0]), .B(n14), .Y(N45) );
  NOR2BX1 U73 ( .AN(RS_IN[1]), .B(n14), .Y(N46) );
  NOR2BX1 U74 ( .AN(RS_IN[2]), .B(n14), .Y(N47) );
  NOR2BX1 U75 ( .AN(RS_IN[3]), .B(n14), .Y(N48) );
  NOR2BX1 U76 ( .AN(RS_IN[4]), .B(n14), .Y(N49) );
  NOR2BX1 U77 ( .AN(RS_IN[5]), .B(n14), .Y(N50) );
  NOR2BX1 U78 ( .AN(RS_IN[6]), .B(n14), .Y(N51) );
  NOR2BX1 U79 ( .AN(RS_IN[7]), .B(n14), .Y(N52) );
  NOR2BX1 U80 ( .AN(RS_IN[8]), .B(n14), .Y(N53) );
  NOR2BX1 U81 ( .AN(RS_IN[9]), .B(n14), .Y(N54) );
  NOR2BX1 U82 ( .AN(RS_IN[10]), .B(n14), .Y(N55) );
  NOR2BX1 U83 ( .AN(RS_IN[11]), .B(n14), .Y(N56) );
  NOR2BX1 U84 ( .AN(RS_IN[12]), .B(n15), .Y(N57) );
  NOR2BX1 U85 ( .AN(RS_IN[13]), .B(n15), .Y(N58) );
  NOR2BX1 U86 ( .AN(RS_IN[14]), .B(n15), .Y(N59) );
  NOR2BX1 U87 ( .AN(RS_IN[15]), .B(n15), .Y(N60) );
  NOR2BX1 U88 ( .AN(RD_ADDRIN[0]), .B(n13), .Y(N40) );
  NOR2BX1 U89 ( .AN(RD_ADDRIN[1]), .B(n13), .Y(N41) );
  NOR2BX1 U90 ( .AN(RD_ADDRIN[2]), .B(n13), .Y(N42) );
  NOR2BX1 U91 ( .AN(RD_ADDRIN[3]), .B(n13), .Y(N43) );
  NOR2BX1 U92 ( .AN(RT_ADDRIN[2]), .B(n13), .Y(N37) );
  NOR2BX1 U93 ( .AN(RT_ADDRIN[3]), .B(n13), .Y(N38) );
  NOR2BX1 U94 ( .AN(RT_ADDRIN[4]), .B(n13), .Y(N39) );
  NOR2BX1 U95 ( .AN(OFFSET_IN[0]), .B(n12), .Y(N3) );
  NOR2BX1 U96 ( .AN(OFFSET_IN[1]), .B(n13), .Y(N4) );
  NOR2BX1 U97 ( .AN(OFFSET_IN[2]), .B(n14), .Y(N5) );
  NOR2BX1 U98 ( .AN(OFFSET_IN[3]), .B(n15), .Y(N6) );
  NOR2BX1 U99 ( .AN(OFFSET_IN[4]), .B(n16), .Y(N7) );
  NOR2BX1 U100 ( .AN(OFFSET_IN[5]), .B(n16), .Y(N8) );
  NOR2BX1 U101 ( .AN(OFFSET_IN[6]), .B(n17), .Y(N9) );
  NOR2BX1 U102 ( .AN(OFFSET_IN[7]), .B(n11), .Y(N10) );
  NOR2BX1 U103 ( .AN(OFFSET_IN[8]), .B(n11), .Y(N11) );
  NOR2BX1 U104 ( .AN(OFFSET_IN[9]), .B(n11), .Y(N12) );
  NOR2BX1 U105 ( .AN(OFFSET_IN[10]), .B(n11), .Y(N13) );
  NOR2BX1 U106 ( .AN(OFFSET_IN[11]), .B(n11), .Y(N14) );
  NOR2BX1 U107 ( .AN(OFFSET_IN[12]), .B(n11), .Y(N15) );
  NOR2BX1 U108 ( .AN(OFFSET_IN[13]), .B(n11), .Y(N16) );
  NOR2BX1 U109 ( .AN(OFFSET_IN[14]), .B(n11), .Y(N17) );
  NOR2BX1 U110 ( .AN(Opcode_in[4]), .B(n11), .Y(N100) );
  NOR2BX1 U111 ( .AN(Opcode_in[5]), .B(n11), .Y(N101) );
  NOR2BX1 U112 ( .AN(Opcode_in[0]), .B(n17), .Y(N96) );
  NOR2BX1 U113 ( .AN(Opcode_in[1]), .B(n15), .Y(N97) );
  NOR2BX1 U114 ( .AN(Opcode_in[2]), .B(n16), .Y(N98) );
  NOR2BX1 U115 ( .AN(Opcode_in[3]), .B(n11), .Y(N99) );
  NOR2BX1 U116 ( .AN(RS_ADDRIN[2]), .B(n14), .Y(N93) );
  NOR2BX1 U117 ( .AN(RS_ADDRIN[3]), .B(n13), .Y(N94) );
  NOR2BX1 U118 ( .AN(RS_ADDRIN[4]), .B(n12), .Y(N95) );
  INVX1 U119 ( .A(rst), .Y(n18) );
endmodule


module Execute_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [15:0] A;
  input [15:0] B;
  output [15:0] DIFF;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17;
  wire   [15:1] carry;

  XOR3X2 U2_15 ( .A(A[15]), .B(n8), .C(carry[15]), .Y(DIFF[15]) );
  ADDFX2 U2_14 ( .A(A[14]), .B(n7), .CI(carry[14]), .CO(carry[15]), .S(
        DIFF[14]) );
  ADDFX2 U2_11 ( .A(A[11]), .B(n4), .CI(carry[11]), .CO(carry[12]), .S(
        DIFF[11]) );
  ADDFX2 U2_10 ( .A(A[10]), .B(n3), .CI(carry[10]), .CO(carry[11]), .S(
        DIFF[10]) );
  ADDFX2 U2_7 ( .A(A[7]), .B(n15), .CI(carry[7]), .CO(carry[8]), .S(DIFF[7])
         );
  ADDFX2 U2_6 ( .A(A[6]), .B(n14), .CI(carry[6]), .CO(carry[7]), .S(DIFF[6])
         );
  ADDFX2 U2_3 ( .A(A[3]), .B(n11), .CI(carry[3]), .CO(carry[4]), .S(DIFF[3])
         );
  ADDFX2 U2_2 ( .A(A[2]), .B(n10), .CI(carry[2]), .CO(carry[3]), .S(DIFF[2])
         );
  ADDFX2 U2_13 ( .A(A[13]), .B(n6), .CI(carry[13]), .CO(carry[14]), .S(
        DIFF[13]) );
  ADDFX2 U2_12 ( .A(A[12]), .B(n5), .CI(carry[12]), .CO(carry[13]), .S(
        DIFF[12]) );
  ADDFX2 U2_9 ( .A(A[9]), .B(n17), .CI(carry[9]), .CO(carry[10]), .S(DIFF[9])
         );
  ADDFX2 U2_8 ( .A(A[8]), .B(n16), .CI(carry[8]), .CO(carry[9]), .S(DIFF[8])
         );
  ADDFX2 U2_5 ( .A(A[5]), .B(n13), .CI(carry[5]), .CO(carry[6]), .S(DIFF[5])
         );
  ADDFX2 U2_4 ( .A(A[4]), .B(n12), .CI(carry[4]), .CO(carry[5]), .S(DIFF[4])
         );
  ADDFX2 U2_1 ( .A(A[1]), .B(n9), .CI(carry[1]), .CO(carry[2]), .S(DIFF[1]) );
  INVX1 U1 ( .A(B[0]), .Y(n2) );
  XNOR2X1 U2 ( .A(n2), .B(A[0]), .Y(DIFF[0]) );
  NAND2X1 U3 ( .A(B[0]), .B(n1), .Y(carry[1]) );
  INVX1 U4 ( .A(B[1]), .Y(n9) );
  INVX1 U5 ( .A(A[0]), .Y(n1) );
  INVX1 U6 ( .A(B[4]), .Y(n12) );
  INVX1 U7 ( .A(B[5]), .Y(n13) );
  INVX1 U8 ( .A(B[8]), .Y(n16) );
  INVX1 U9 ( .A(B[9]), .Y(n17) );
  INVX1 U10 ( .A(B[12]), .Y(n5) );
  INVX1 U11 ( .A(B[13]), .Y(n6) );
  INVX1 U12 ( .A(B[2]), .Y(n10) );
  INVX1 U13 ( .A(B[3]), .Y(n11) );
  INVX1 U14 ( .A(B[6]), .Y(n14) );
  INVX1 U15 ( .A(B[7]), .Y(n15) );
  INVX1 U16 ( .A(B[10]), .Y(n3) );
  INVX1 U17 ( .A(B[11]), .Y(n4) );
  INVX1 U18 ( .A(B[14]), .Y(n7) );
  INVX1 U19 ( .A(B[15]), .Y(n8) );
endmodule


module Execute_DW01_add_0 ( A, B, CI, SUM, CO );
  input [15:0] A;
  input [15:0] B;
  output [15:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [15:2] carry;

  ADDFX2 U1_14 ( .A(A[14]), .B(B[14]), .CI(carry[14]), .CO(carry[15]), .S(
        SUM[14]) );
  ADDFX2 U1_11 ( .A(A[11]), .B(B[11]), .CI(carry[11]), .CO(carry[12]), .S(
        SUM[11]) );
  ADDFX2 U1_10 ( .A(A[10]), .B(B[10]), .CI(carry[10]), .CO(carry[11]), .S(
        SUM[10]) );
  ADDFX2 U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(carry[8]), .S(SUM[7])
         );
  ADDFX2 U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFX2 U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFX2 U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFX2 U1_13 ( .A(A[13]), .B(B[13]), .CI(carry[13]), .CO(carry[14]), .S(
        SUM[13]) );
  ADDFX2 U1_12 ( .A(A[12]), .B(B[12]), .CI(carry[12]), .CO(carry[13]), .S(
        SUM[12]) );
  ADDFX2 U1_9 ( .A(A[9]), .B(B[9]), .CI(carry[9]), .CO(carry[10]), .S(SUM[9])
         );
  ADDFX2 U1_8 ( .A(A[8]), .B(B[8]), .CI(carry[8]), .CO(carry[9]), .S(SUM[8])
         );
  ADDFX2 U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFX2 U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFX2 U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  XOR3X2 U1_15 ( .A(A[15]), .B(B[15]), .C(carry[15]), .Y(SUM[15]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module Execute ( Read_data1, Read_data2, Sign_extend, RT_IN, RD_IN, ALUop, 
        ALUSrc, RegDst, clk, rst, Zero, ALU_Result, Write_RegOUT, 
        Write_DataOUT, EX_MEMALUResult, MEM_WBWriteDATA, EXE_RS, EXE_SHAMT, Ai, 
        Bi, Opcode, branch_taken, Last_inst, Branch );
  input [15:0] Read_data1;
  input [15:0] Read_data2;
  input [31:0] Sign_extend;
  input [4:0] RT_IN;
  input [4:0] RD_IN;
  input [1:0] ALUop;
  output [15:0] ALU_Result;
  output [4:0] Write_RegOUT;
  output [15:0] Write_DataOUT;
  input [15:0] EX_MEMALUResult;
  input [15:0] MEM_WBWriteDATA;
  input [4:0] EXE_RS;
  input [4:0] EXE_SHAMT;
  input [1:0] Ai;
  input [1:0] Bi;
  input [5:0] Opcode;
  output [15:0] Last_inst;
  input ALUSrc, RegDst, clk, rst, Branch;
  output Zero, branch_taken;
  wire   N66, N144, N145, N146, N147, N148, N233, N234, N235, N236, N237, N238,
         N239, N240, N241, N242, N243, N244, N245, N246, N247, N248, N281,
         N282, N283, N284, N285, N286, N287, N288, N289, N290, N291, N292,
         N293, N294, N295, N296, N298, N299, N300, N301, N302, N303, N304,
         N305, N306, N307, N308, N309, N310, N311, N312, N313, N314, N315,
         N316, N317, N318, N319, N320, N321, N322, N323, N324, N325, N326,
         N327, N328, N329, N349, n22, n23, n24, n135, n136, n137, n138, n139,
         n140, n141, n142, n143, n144, n145, n146, n147, n148, n149, n150,
         n151, n152, n153, n154, n155, n156, n157, n158, n159, n160, n161,
         n162, n163, n164, n165, n166, n167, n168, n169, n170, n171, n172,
         n173, n174, n176, n177, n178, n179, n181, n182, n183, n184, n185,
         n186, n187, n188, n189, n190, n191, n192, n193, n194, n195, n196,
         n197, n198, n199, n200, n201, n202, n203, n204, n205, n206, n207,
         n208, n209, n210, n211, n212, n213, n214, n215, n216, n217, n218,
         n219, n220, n221, n222, n223, n224, n225, n226, n227, n228, n229,
         n230, n231, n232, n233, n234, n235, n236, n237, n238, n239, n240,
         n241, n242, n243, n244, n245, n246, n247, n248, n249, n250, n251,
         n252, n253, n254, n255, n256, n257, n258, n259, n260, n261, n262,
         n263, n264, n265, n266, n267, n268, n269, n270, n271, n272, n273,
         n274, n275, n276, n277, n278, n279, n280, n281, n282, n283, n284,
         n285, srl_107_A_10_, srl_107_A_7_, srl_107_A_2_, srl_107_A_0_, n1, n4,
         n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52,
         n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66,
         n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80,
         n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94,
         n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, n105, n106,
         n107, n108, n109, n110, n111, n112, n113, n114, n115, n116, n117,
         n118, n119, n120, n121, n122, n123, n124, n125, n126, n127, n128,
         n129, n130, n131, n132, n133, n134, n175, n180, n286, n287, n288,
         n289, n290, n291, n292, n293, n294, n295, n296, n297, n298, n299,
         n300, n301, n302, n303, n304, n305, n306, n307, n308, n309, n310,
         n311, n312, n313, n314, n315, n316, n317, n318, n319, n320, n321,
         n322, n323, n324, n325, n326, n327, n328, n329, n330, n331, n332,
         n333, n334, n335, n336, n337, n338, n339, n340, n341, n342, n343,
         n344, n345, n346, n347, n348, n349, n350, n351, n352, n353, n354,
         n355, n356, n357, n358, n359, n360, n361, n362, n363, n364, n365,
         n366, n367, n368, n369, n370, n371, n372, n373, n374, n375, n376,
         n377, n378, n379, n380, n381, n382, n383, n384, n385, n386, n387,
         n388, n389, n390, n391, n392, n393, n394, n395, n396, n397, n398,
         n399, n400, n401, n402, n403, n404, n405, n406, n407, n408, n409,
         n410, n411, n412, n413, n414, n415, n416, n417, n418, n419, n420,
         n421, n422, n423, n424, n425, n426, n427, n428, n429, n430, n431,
         n432, n433, n434, n435, n436, n437, n438, n439, n440, n441, n442,
         n443, n444, n445, n446, n447, n448, n449, n450, n451, n452, n453,
         n454, n455, n456, n457, n458, n459, n460, n461;
  wire   [15:0] Ainput;
  wire   [3:0] ALU_ctl;

  Execute_DW01_sub_0 r326 ( .A(Ainput), .B({n109, n107, n105, n103, n100, 
        srl_107_A_10_, n122, n121, srl_107_A_7_, n120, n119, n118, n115, 
        srl_107_A_2_, n111, srl_107_A_0_}), .CI(1'b0), .DIFF({N296, N295, N294, 
        N293, N292, N291, N290, N289, N288, N287, N286, N285, N284, N283, N282, 
        N281}) );
  Execute_DW01_add_0 r325 ( .A(Ainput), .B({n109, n107, n105, n103, n100, 
        srl_107_A_10_, n122, n121, srl_107_A_7_, n120, n119, n118, n115, 
        srl_107_A_2_, n111, srl_107_A_0_}), .CI(1'b0), .SUM({N248, N247, N246, 
        N245, N244, N243, N242, N241, N240, N239, N238, N237, N236, N235, N234, 
        N233}) );
  TLATX1 ALU_ctl_reg_1_ ( .G(N144), .D(N146), .Q(ALU_ctl[1]), .QN(n23) );
  TLATX1 ALU_ctl_reg_0_ ( .G(N144), .D(N145), .Q(ALU_ctl[0]), .QN(n24) );
  TLATX1 ALU_ctl_reg_3_ ( .G(N144), .D(N148), .Q(ALU_ctl[3]), .QN(n22) );
  TLATX1 ALU_ctl_reg_2_ ( .G(N144), .D(N147), .Q(ALU_ctl[2]) );
  NAND2X1 U3 ( .A(n278), .B(n274), .Y(n1) );
  NAND4X1 U4 ( .A(ALU_ctl[2]), .B(n24), .C(n23), .D(n22), .Y(n4) );
  OAI222XL U5 ( .A0(n182), .A1(n287), .B0(n183), .B1(n303), .C0(n184), .C1(
        n329), .Y(Ainput[0]) );
  INVX1 U6 ( .A(n381), .Y(n92) );
  MXI2X1 U7 ( .A(n361), .B(n110), .S0(n349), .Y(n392) );
  INVX1 U10 ( .A(n397), .Y(n110) );
  MXI2X1 U11 ( .A(n389), .B(n112), .S0(n349), .Y(n393) );
  INVX1 U12 ( .A(n402), .Y(n112) );
  MXI2X1 U13 ( .A(n364), .B(n366), .S0(n29), .Y(n381) );
  MXI2X1 U14 ( .A(n360), .B(n359), .S0(n29), .Y(n397) );
  MXI2X1 U15 ( .A(n370), .B(n369), .S0(n29), .Y(n402) );
  MXI2X1 U16 ( .A(n359), .B(n356), .S0(n29), .Y(n377) );
  MXI2X1 U17 ( .A(n369), .B(n365), .S0(n29), .Y(n385) );
  MXI2X1 U18 ( .A(n356), .B(n355), .S0(n29), .Y(n396) );
  MXI2X1 U19 ( .A(n435), .B(n434), .S0(n29), .Y(n436) );
  AND2X2 U20 ( .A(n414), .B(n29), .Y(n417) );
  AND2X2 U21 ( .A(n350), .B(n29), .Y(n361) );
  AND2X2 U22 ( .A(n410), .B(n29), .Y(n416) );
  MXI2X1 U23 ( .A(n365), .B(n364), .S0(n29), .Y(n401) );
  MXI2X1 U24 ( .A(n355), .B(n357), .S0(n29), .Y(n376) );
  MXI2X1 U25 ( .A(n357), .B(n374), .S0(n29), .Y(n358) );
  MXI2X1 U26 ( .A(n366), .B(n101), .S0(n29), .Y(n367) );
  INVX1 U27 ( .A(n383), .Y(n101) );
  NAND2X1 U28 ( .A(n416), .B(n349), .Y(n452) );
  NAND2X1 U29 ( .A(n417), .B(n349), .Y(n457) );
  NAND2X1 U30 ( .A(n361), .B(n349), .Y(n398) );
  NAND2X1 U31 ( .A(n389), .B(n349), .Y(n403) );
  AND2X2 U32 ( .A(n368), .B(n29), .Y(n389) );
  INVX1 U33 ( .A(n440), .Y(n117) );
  INVX1 U34 ( .A(N349), .Y(n69) );
  NAND2X1 U35 ( .A(n178), .B(n179), .Y(n177) );
  NAND2X1 U36 ( .A(n183), .B(n184), .Y(n182) );
  NOR4X1 U37 ( .A(n137), .B(n138), .C(n139), .D(n140), .Y(Zero) );
  OR4X2 U38 ( .A(ALU_Result[6]), .B(ALU_Result[7]), .C(ALU_Result[8]), .D(
        ALU_Result[9]), .Y(n137) );
  OR4X2 U39 ( .A(ALU_Result[2]), .B(ALU_Result[3]), .C(ALU_Result[4]), .D(
        ALU_Result[5]), .Y(n138) );
  OR4X2 U40 ( .A(ALU_Result[13]), .B(ALU_Result[14]), .C(ALU_Result[15]), .D(
        ALU_Result[1]), .Y(n139) );
  OR4X2 U41 ( .A(ALU_Result[0]), .B(ALU_Result[10]), .C(ALU_Result[11]), .D(
        ALU_Result[12]), .Y(n140) );
  MXI2X1 U42 ( .A(n416), .B(n97), .S0(n349), .Y(n429) );
  INVX1 U43 ( .A(n451), .Y(n97) );
  MXI2X1 U44 ( .A(n417), .B(n99), .S0(n349), .Y(n437) );
  INVX1 U45 ( .A(n456), .Y(n99) );
  MXI2X1 U46 ( .A(n424), .B(n427), .S0(n29), .Y(n440) );
  MXI2X1 U47 ( .A(n411), .B(n425), .S0(n29), .Y(n441) );
  MXI2X1 U48 ( .A(n420), .B(n433), .S0(n29), .Y(n446) );
  MXI2X1 U49 ( .A(n412), .B(n411), .S0(n29), .Y(n451) );
  MXI2X1 U50 ( .A(n415), .B(n420), .S0(n29), .Y(n456) );
  MXI2X1 U51 ( .A(n432), .B(n435), .S0(n29), .Y(n445) );
  MXI2X1 U52 ( .A(n433), .B(n432), .S0(n29), .Y(n455) );
  MXI2X1 U53 ( .A(n434), .B(n418), .S0(n29), .Y(n419) );
  MX2X1 U54 ( .A(n111), .B(srl_107_A_2_), .S0(EXE_SHAMT[0]), .Y(n418) );
  NOR3X1 U55 ( .A(n461), .B(EXE_SHAMT[4]), .C(EXE_SHAMT[3]), .Y(N323) );
  NOR3X1 U56 ( .A(n429), .B(EXE_SHAMT[4]), .C(EXE_SHAMT[3]), .Y(N324) );
  NOR3X1 U57 ( .A(n437), .B(EXE_SHAMT[4]), .C(EXE_SHAMT[3]), .Y(N325) );
  NOR3X1 U58 ( .A(n442), .B(EXE_SHAMT[4]), .C(EXE_SHAMT[3]), .Y(N326) );
  NOR2BX1 U59 ( .AN(n109), .B(EXE_SHAMT[0]), .Y(n414) );
  NOR2BX1 U60 ( .AN(srl_107_A_0_), .B(EXE_SHAMT[0]), .Y(n350) );
  MX2X1 U61 ( .A(n115), .B(n118), .S0(EXE_SHAMT[0]), .Y(n434) );
  MX2X1 U62 ( .A(n118), .B(n119), .S0(EXE_SHAMT[0]), .Y(n427) );
  MX2X1 U63 ( .A(n119), .B(n120), .S0(EXE_SHAMT[0]), .Y(n435) );
  MX2X1 U64 ( .A(srl_107_A_10_), .B(n100), .S0(EXE_SHAMT[0]), .Y(n411) );
  MX2X1 U65 ( .A(n121), .B(n122), .S0(EXE_SHAMT[0]), .Y(n425) );
  MX2X1 U66 ( .A(n120), .B(srl_107_A_7_), .S0(EXE_SHAMT[0]), .Y(n424) );
  MX2X1 U67 ( .A(n100), .B(n103), .S0(EXE_SHAMT[0]), .Y(n420) );
  MX2X1 U68 ( .A(srl_107_A_7_), .B(n121), .S0(EXE_SHAMT[0]), .Y(n432) );
  MX2X1 U69 ( .A(n122), .B(srl_107_A_10_), .S0(EXE_SHAMT[0]), .Y(n433) );
  MX2X1 U70 ( .A(n118), .B(n115), .S0(EXE_SHAMT[0]), .Y(n359) );
  MX2X1 U71 ( .A(n119), .B(n118), .S0(EXE_SHAMT[0]), .Y(n369) );
  MX2X1 U72 ( .A(n120), .B(n119), .S0(EXE_SHAMT[0]), .Y(n356) );
  MX2X1 U73 ( .A(srl_107_A_7_), .B(n120), .S0(EXE_SHAMT[0]), .Y(n365) );
  MX2X1 U74 ( .A(n122), .B(n121), .S0(EXE_SHAMT[0]), .Y(n364) );
  MX2X1 U75 ( .A(n100), .B(srl_107_A_10_), .S0(EXE_SHAMT[0]), .Y(n366) );
  MX2X1 U76 ( .A(n103), .B(n105), .S0(EXE_SHAMT[0]), .Y(n412) );
  MX2X1 U77 ( .A(n105), .B(n107), .S0(EXE_SHAMT[0]), .Y(n415) );
  MX2X1 U78 ( .A(n115), .B(srl_107_A_2_), .S0(EXE_SHAMT[0]), .Y(n370) );
  MX2X1 U79 ( .A(srl_107_A_2_), .B(n111), .S0(EXE_SHAMT[0]), .Y(n360) );
  BUFX3 U80 ( .A(n70), .Y(n25) );
  BUFX3 U81 ( .A(n70), .Y(n26) );
  NOR2BX1 U82 ( .AN(n388), .B(EXE_SHAMT[4]), .Y(N313) );
  MXI2X1 U83 ( .A(n387), .B(n395), .S0(EXE_SHAMT[3]), .Y(n388) );
  MXI2X1 U84 ( .A(n92), .B(n384), .S0(n349), .Y(n387) );
  MXI2X1 U85 ( .A(n383), .B(n382), .S0(n29), .Y(n384) );
  MX2X1 U86 ( .A(n107), .B(n109), .S0(EXE_SHAMT[0]), .Y(n410) );
  MX2X1 U87 ( .A(n111), .B(srl_107_A_0_), .S0(EXE_SHAMT[0]), .Y(n368) );
  MXI2X1 U88 ( .A(srl_107_A_2_), .B(n115), .S0(EXE_SHAMT[0]), .Y(n426) );
  MXI2X1 U89 ( .A(n105), .B(n103), .S0(EXE_SHAMT[0]), .Y(n383) );
  MXI2X1 U90 ( .A(n425), .B(n424), .S0(n29), .Y(n450) );
  NOR3X1 U91 ( .A(n398), .B(EXE_SHAMT[4]), .C(EXE_SHAMT[3]), .Y(N298) );
  MXI2X1 U92 ( .A(n109), .B(n107), .S0(EXE_SHAMT[0]), .Y(n382) );
  MXI2X1 U93 ( .A(srl_107_A_0_), .B(n111), .S0(EXE_SHAMT[0]), .Y(n406) );
  MXI2X1 U94 ( .A(n374), .B(n373), .S0(n29), .Y(n375) );
  MX2X1 U95 ( .A(n107), .B(n105), .S0(EXE_SHAMT[0]), .Y(n373) );
  MXI2X1 U96 ( .A(n427), .B(n113), .S0(n29), .Y(n428) );
  INVX1 U97 ( .A(n426), .Y(n113) );
  NOR2BX1 U98 ( .AN(n409), .B(EXE_SHAMT[4]), .Y(N314) );
  MXI2X1 U99 ( .A(n408), .B(n460), .S0(EXE_SHAMT[3]), .Y(n409) );
  MXI2X1 U100 ( .A(n117), .B(n407), .S0(n349), .Y(n408) );
  MXI2X1 U101 ( .A(n426), .B(n406), .S0(n29), .Y(n407) );
  NOR3X1 U102 ( .A(n403), .B(EXE_SHAMT[4]), .C(EXE_SHAMT[3]), .Y(N299) );
  NOR3X1 U103 ( .A(n390), .B(EXE_SHAMT[4]), .C(EXE_SHAMT[3]), .Y(N300) );
  NOR3X1 U104 ( .A(n391), .B(EXE_SHAMT[4]), .C(EXE_SHAMT[3]), .Y(N301) );
  NOR3X1 U105 ( .A(n392), .B(EXE_SHAMT[4]), .C(EXE_SHAMT[3]), .Y(N302) );
  NOR3X1 U106 ( .A(n393), .B(EXE_SHAMT[4]), .C(EXE_SHAMT[3]), .Y(N303) );
  NOR3X1 U107 ( .A(n394), .B(EXE_SHAMT[4]), .C(EXE_SHAMT[3]), .Y(N304) );
  NOR3X1 U108 ( .A(n395), .B(EXE_SHAMT[4]), .C(EXE_SHAMT[3]), .Y(N305) );
  NOR3X1 U109 ( .A(n460), .B(EXE_SHAMT[4]), .C(EXE_SHAMT[3]), .Y(N322) );
  NOR3X1 U110 ( .A(n447), .B(EXE_SHAMT[4]), .C(EXE_SHAMT[3]), .Y(N327) );
  NOR3X1 U111 ( .A(n452), .B(EXE_SHAMT[4]), .C(EXE_SHAMT[3]), .Y(N328) );
  NOR3X1 U112 ( .A(n457), .B(EXE_SHAMT[4]), .C(EXE_SHAMT[3]), .Y(N329) );
  INVX1 U113 ( .A(EXE_SHAMT[1]), .Y(n29) );
  MX2X1 U114 ( .A(n121), .B(srl_107_A_7_), .S0(EXE_SHAMT[0]), .Y(n355) );
  MX2X1 U115 ( .A(srl_107_A_10_), .B(n122), .S0(EXE_SHAMT[0]), .Y(n357) );
  MX2X1 U116 ( .A(n103), .B(n100), .S0(EXE_SHAMT[0]), .Y(n374) );
  NOR2X1 U117 ( .A(EXE_SHAMT[4]), .B(n400), .Y(N306) );
  MXI2X1 U118 ( .A(n399), .B(n85), .S0(EXE_SHAMT[3]), .Y(n400) );
  INVX1 U119 ( .A(n398), .Y(n85) );
  MXI2X1 U120 ( .A(n397), .B(n396), .S0(n349), .Y(n399) );
  INVX1 U121 ( .A(n159), .Y(n306) );
  NAND2BX1 U122 ( .AN(Bi[0]), .B(Bi[1]), .Y(n178) );
  NAND2BX1 U123 ( .AN(Ai[0]), .B(Ai[1]), .Y(n183) );
  OR2X2 U124 ( .A(Ai[1]), .B(Ai[0]), .Y(n184) );
  OR2X2 U125 ( .A(Bi[1]), .B(Bi[0]), .Y(n179) );
  NAND4BXL U126 ( .AN(n269), .B(n270), .C(n271), .D(n272), .Y(ALU_Result[0])
         );
  AOI22X1 U127 ( .A0(N314), .A1(n171), .B0(N298), .B1(n170), .Y(n271) );
  OAI2BB1X1 U128 ( .A0N(n282), .A1N(n284), .B0(n285), .Y(n269) );
  AOI22X1 U129 ( .A0(n279), .A1(srl_107_A_0_), .B0(Ainput[0]), .B1(n28), .Y(
        n270) );
  AOI22X1 U130 ( .A0(N233), .A1(n25), .B0(N281), .B1(n67), .Y(n272) );
  NAND3X1 U131 ( .A(n227), .B(n228), .C(n229), .Y(ALU_Result[1]) );
  AOI22X1 U132 ( .A0(Ainput[1]), .A1(n28), .B0(N234), .B1(n25), .Y(n227) );
  AOI22X1 U133 ( .A0(n230), .A1(n231), .B0(n232), .B1(n111), .Y(n228) );
  AOI222X1 U134 ( .A0(N299), .A1(n170), .B0(N282), .B1(n67), .C0(N315), .C1(
        n171), .Y(n229) );
  NAND3X1 U135 ( .A(n203), .B(n204), .C(n205), .Y(ALU_Result[5]) );
  AOI22X1 U136 ( .A0(Ainput[5]), .A1(n28), .B0(N238), .B1(n26), .Y(n203) );
  AOI22X1 U137 ( .A0(n206), .A1(n207), .B0(n208), .B1(n119), .Y(n204) );
  AOI222X1 U138 ( .A0(N303), .A1(n170), .B0(N286), .B1(n67), .C0(N319), .C1(
        n171), .Y(n205) );
  NAND3X1 U139 ( .A(n167), .B(n168), .C(n169), .Y(ALU_Result[9]) );
  AOI22X1 U140 ( .A0(n28), .A1(Ainput[9]), .B0(N242), .B1(n26), .Y(n167) );
  AOI22X1 U141 ( .A0(n172), .A1(n173), .B0(n174), .B1(n122), .Y(n168) );
  AOI222X1 U142 ( .A0(N307), .A1(n170), .B0(N290), .B1(n67), .C0(N323), .C1(
        n171), .Y(n169) );
  NAND3X1 U143 ( .A(n251), .B(n252), .C(n253), .Y(ALU_Result[12]) );
  AOI22X1 U144 ( .A0(Ainput[12]), .A1(n28), .B0(N245), .B1(n25), .Y(n251) );
  AOI22X1 U145 ( .A0(n254), .A1(n255), .B0(n256), .B1(n103), .Y(n252) );
  AOI222X1 U146 ( .A0(N310), .A1(n170), .B0(N293), .B1(n67), .C0(N326), .C1(
        n171), .Y(n253) );
  NAND3X1 U147 ( .A(n209), .B(n210), .C(n211), .Y(ALU_Result[4]) );
  AOI22X1 U148 ( .A0(Ainput[4]), .A1(n28), .B0(N237), .B1(n26), .Y(n209) );
  AOI22X1 U149 ( .A0(n212), .A1(n213), .B0(n214), .B1(n118), .Y(n210) );
  AOI222X1 U150 ( .A0(N302), .A1(n170), .B0(N285), .B1(n67), .C0(N318), .C1(
        n171), .Y(n211) );
  NAND3X1 U151 ( .A(n185), .B(n186), .C(n187), .Y(ALU_Result[8]) );
  AOI22X1 U152 ( .A0(Ainput[8]), .A1(n28), .B0(N241), .B1(n26), .Y(n185) );
  AOI22X1 U153 ( .A0(n188), .A1(n189), .B0(n190), .B1(n121), .Y(n186) );
  AOI222X1 U154 ( .A0(N306), .A1(n170), .B0(N289), .B1(n67), .C0(N322), .C1(
        n171), .Y(n187) );
  NAND3X1 U155 ( .A(n257), .B(n258), .C(n259), .Y(ALU_Result[11]) );
  AOI22X1 U156 ( .A0(Ainput[11]), .A1(n28), .B0(N244), .B1(n25), .Y(n257) );
  AOI22X1 U157 ( .A0(n260), .A1(n261), .B0(n262), .B1(n100), .Y(n258) );
  AOI222X1 U158 ( .A0(N309), .A1(n170), .B0(N292), .B1(n67), .C0(N325), .C1(
        n171), .Y(n259) );
  NAND3X1 U159 ( .A(n233), .B(n234), .C(n235), .Y(ALU_Result[15]) );
  AOI22X1 U160 ( .A0(Ainput[15]), .A1(n28), .B0(N248), .B1(n25), .Y(n233) );
  AOI22X1 U161 ( .A0(n236), .A1(n237), .B0(n238), .B1(n109), .Y(n234) );
  AOI222X1 U162 ( .A0(N313), .A1(n170), .B0(N296), .B1(n67), .C0(N329), .C1(
        n171), .Y(n235) );
  NAND3X1 U163 ( .A(n215), .B(n216), .C(n217), .Y(ALU_Result[3]) );
  AOI22X1 U164 ( .A0(Ainput[3]), .A1(n28), .B0(N236), .B1(n26), .Y(n215) );
  AOI22X1 U165 ( .A0(n218), .A1(n219), .B0(n220), .B1(n115), .Y(n216) );
  AOI222X1 U166 ( .A0(N301), .A1(n170), .B0(N284), .B1(n67), .C0(N317), .C1(
        n171), .Y(n217) );
  NAND3X1 U167 ( .A(n191), .B(n192), .C(n193), .Y(ALU_Result[7]) );
  AOI22X1 U168 ( .A0(Ainput[7]), .A1(n28), .B0(N240), .B1(n26), .Y(n191) );
  AOI22X1 U169 ( .A0(n194), .A1(n195), .B0(n196), .B1(srl_107_A_7_), .Y(n192)
         );
  AOI222X1 U170 ( .A0(N305), .A1(n170), .B0(N288), .B1(n67), .C0(N321), .C1(
        n171), .Y(n193) );
  NAND3X1 U171 ( .A(n263), .B(n264), .C(n265), .Y(ALU_Result[10]) );
  AOI22X1 U172 ( .A0(Ainput[10]), .A1(n28), .B0(N243), .B1(n25), .Y(n263) );
  AOI22X1 U173 ( .A0(n266), .A1(n267), .B0(n268), .B1(srl_107_A_10_), .Y(n264)
         );
  AOI222X1 U174 ( .A0(N308), .A1(n170), .B0(N291), .B1(n67), .C0(N324), .C1(
        n171), .Y(n265) );
  NAND3X1 U175 ( .A(n239), .B(n240), .C(n241), .Y(ALU_Result[14]) );
  AOI22X1 U176 ( .A0(Ainput[14]), .A1(n28), .B0(N247), .B1(n25), .Y(n239) );
  AOI22X1 U177 ( .A0(n242), .A1(n243), .B0(n244), .B1(n107), .Y(n240) );
  AOI222X1 U178 ( .A0(N312), .A1(n170), .B0(N295), .B1(n67), .C0(N328), .C1(
        n171), .Y(n241) );
  NAND3X1 U179 ( .A(n221), .B(n222), .C(n223), .Y(ALU_Result[2]) );
  AOI22X1 U180 ( .A0(Ainput[2]), .A1(n28), .B0(N235), .B1(n26), .Y(n221) );
  AOI22X1 U181 ( .A0(n224), .A1(n225), .B0(n226), .B1(srl_107_A_2_), .Y(n222)
         );
  AOI222X1 U182 ( .A0(N300), .A1(n170), .B0(N283), .B1(n67), .C0(N316), .C1(
        n171), .Y(n223) );
  NAND3X1 U183 ( .A(n197), .B(n198), .C(n199), .Y(ALU_Result[6]) );
  AOI22X1 U184 ( .A0(Ainput[6]), .A1(n28), .B0(N239), .B1(n26), .Y(n197) );
  AOI22X1 U185 ( .A0(n200), .A1(n201), .B0(n202), .B1(n120), .Y(n198) );
  AOI222X1 U186 ( .A0(N304), .A1(n170), .B0(N287), .B1(n67), .C0(N320), .C1(
        n171), .Y(n199) );
  NAND3X1 U187 ( .A(n245), .B(n246), .C(n247), .Y(ALU_Result[13]) );
  AOI22X1 U188 ( .A0(Ainput[13]), .A1(n28), .B0(N246), .B1(n25), .Y(n245) );
  AOI22X1 U189 ( .A0(n248), .A1(n249), .B0(n250), .B1(n105), .Y(n246) );
  AOI222X1 U190 ( .A0(N311), .A1(n170), .B0(N294), .B1(n67), .C0(N327), .C1(
        n171), .Y(n247) );
  INVX1 U191 ( .A(n282), .Y(srl_107_A_0_) );
  INVX1 U192 ( .A(n225), .Y(srl_107_A_2_) );
  INVX1 U193 ( .A(n283), .Y(n68) );
  OAI21XL U194 ( .A0(n280), .A1(n69), .B0(n281), .Y(n283) );
  OAI221XL U195 ( .A0(Ainput[0]), .A1(n1), .B0(n71), .B1(n176), .C0(n68), .Y(
        n279) );
  OAI221XL U196 ( .A0(Ainput[1]), .A1(n1), .B0(n78), .B1(n176), .C0(n68), .Y(
        n232) );
  OAI221XL U197 ( .A0(Ainput[2]), .A1(n1), .B0(n66), .B1(n176), .C0(n68), .Y(
        n226) );
  OAI221XL U198 ( .A0(Ainput[3]), .A1(n1), .B0(n79), .B1(n176), .C0(n68), .Y(
        n220) );
  OAI221XL U199 ( .A0(Ainput[4]), .A1(n1), .B0(n80), .B1(n176), .C0(n68), .Y(
        n214) );
  OAI221XL U200 ( .A0(Ainput[5]), .A1(n1), .B0(n81), .B1(n176), .C0(n68), .Y(
        n208) );
  OAI221XL U201 ( .A0(Ainput[6]), .A1(n1), .B0(n82), .B1(n176), .C0(n68), .Y(
        n202) );
  OAI221XL U202 ( .A0(Ainput[7]), .A1(n1), .B0(n65), .B1(n176), .C0(n68), .Y(
        n196) );
  OAI221XL U203 ( .A0(Ainput[8]), .A1(n1), .B0(n83), .B1(n176), .C0(n68), .Y(
        n190) );
  OAI221XL U204 ( .A0(Ainput[9]), .A1(n1), .B0(n84), .B1(n176), .C0(n68), .Y(
        n174) );
  OAI221XL U205 ( .A0(Ainput[10]), .A1(n1), .B0(n72), .B1(n176), .C0(n68), .Y(
        n268) );
  OAI221XL U206 ( .A0(Ainput[11]), .A1(n1), .B0(n73), .B1(n176), .C0(n68), .Y(
        n262) );
  OAI221XL U207 ( .A0(Ainput[12]), .A1(n1), .B0(n74), .B1(n176), .C0(n68), .Y(
        n256) );
  OAI221XL U208 ( .A0(Ainput[13]), .A1(n1), .B0(n75), .B1(n176), .C0(n68), .Y(
        n250) );
  OAI221XL U209 ( .A0(Ainput[14]), .A1(n1), .B0(n76), .B1(n176), .C0(n68), .Y(
        n244) );
  OAI221XL U210 ( .A0(Ainput[15]), .A1(n1), .B0(n77), .B1(n176), .C0(n68), .Y(
        n238) );
  INVX1 U211 ( .A(Ainput[2]), .Y(n66) );
  BUFX3 U212 ( .A(n181), .Y(n28) );
  OAI21XL U213 ( .A0(N349), .A1(n280), .B0(n281), .Y(n181) );
  MXI2X1 U214 ( .A(n421), .B(n94), .S0(n349), .Y(n461) );
  INVX1 U215 ( .A(n446), .Y(n94) );
  MXI2X1 U216 ( .A(n378), .B(n114), .S0(n349), .Y(n394) );
  INVX1 U217 ( .A(n377), .Y(n114) );
  MXI2X1 U218 ( .A(n386), .B(n116), .S0(n349), .Y(n395) );
  INVX1 U219 ( .A(n385), .Y(n116) );
  NAND2X1 U220 ( .A(n413), .B(n349), .Y(n442) );
  NAND2X1 U221 ( .A(n421), .B(n349), .Y(n447) );
  NAND2X1 U222 ( .A(n378), .B(n349), .Y(n390) );
  NAND2X1 U223 ( .A(n386), .B(n349), .Y(n391) );
  INVX1 U224 ( .A(n276), .Y(n70) );
  AOI22X1 U225 ( .A0(N349), .A1(n275), .B0(n274), .B1(n277), .Y(n276) );
  INVX1 U226 ( .A(n27), .Y(n347) );
  INVX1 U227 ( .A(n195), .Y(srl_107_A_7_) );
  INVX1 U228 ( .A(n267), .Y(srl_107_A_10_) );
  INVX1 U229 ( .A(n255), .Y(n103) );
  INVX1 U230 ( .A(n243), .Y(n107) );
  INVX1 U231 ( .A(n231), .Y(n111) );
  INVX1 U232 ( .A(n219), .Y(n115) );
  INVX1 U233 ( .A(n249), .Y(n105) );
  INVX1 U234 ( .A(n201), .Y(n120) );
  INVX1 U235 ( .A(n189), .Y(n121) );
  INVX1 U236 ( .A(n173), .Y(n122) );
  INVX1 U237 ( .A(n261), .Y(n100) );
  INVX1 U238 ( .A(n213), .Y(n118) );
  INVX1 U239 ( .A(n207), .Y(n119) );
  INVX1 U240 ( .A(n237), .Y(n109) );
  NOR2X1 U241 ( .A(EXE_SHAMT[4]), .B(n352), .Y(N308) );
  MXI2X1 U242 ( .A(n351), .B(n87), .S0(EXE_SHAMT[3]), .Y(n352) );
  MXI2X1 U243 ( .A(n377), .B(n376), .S0(n349), .Y(n351) );
  INVX1 U244 ( .A(n390), .Y(n87) );
  NOR2X1 U245 ( .A(EXE_SHAMT[4]), .B(n354), .Y(N309) );
  MXI2X1 U246 ( .A(n353), .B(n89), .S0(EXE_SHAMT[3]), .Y(n354) );
  MXI2X1 U247 ( .A(n385), .B(n381), .S0(n349), .Y(n353) );
  INVX1 U248 ( .A(n391), .Y(n89) );
  NOR2X1 U249 ( .A(EXE_SHAMT[4]), .B(n444), .Y(N318) );
  MXI2X1 U250 ( .A(n443), .B(n102), .S0(EXE_SHAMT[3]), .Y(n444) );
  MXI2X1 U251 ( .A(n441), .B(n440), .S0(n349), .Y(n443) );
  INVX1 U252 ( .A(n442), .Y(n102) );
  NOR2X1 U253 ( .A(EXE_SHAMT[4]), .B(n449), .Y(N319) );
  MXI2X1 U254 ( .A(n448), .B(n104), .S0(EXE_SHAMT[3]), .Y(n449) );
  MXI2X1 U255 ( .A(n446), .B(n445), .S0(n349), .Y(n448) );
  INVX1 U256 ( .A(n447), .Y(n104) );
  INVX1 U257 ( .A(Ainput[7]), .Y(n65) );
  NOR2X1 U258 ( .A(EXE_SHAMT[4]), .B(n423), .Y(N315) );
  MXI2X1 U259 ( .A(n422), .B(n93), .S0(EXE_SHAMT[3]), .Y(n423) );
  MXI2X1 U260 ( .A(n445), .B(n419), .S0(n349), .Y(n422) );
  INVX1 U261 ( .A(n461), .Y(n93) );
  NOR2X1 U262 ( .A(EXE_SHAMT[4]), .B(n431), .Y(N316) );
  MXI2X1 U263 ( .A(n430), .B(n96), .S0(EXE_SHAMT[3]), .Y(n431) );
  MXI2X1 U264 ( .A(n450), .B(n428), .S0(n349), .Y(n430) );
  INVX1 U265 ( .A(n429), .Y(n96) );
  NOR2X1 U266 ( .A(EXE_SHAMT[4]), .B(n439), .Y(N317) );
  MXI2X1 U267 ( .A(n438), .B(n98), .S0(EXE_SHAMT[3]), .Y(n439) );
  MXI2X1 U268 ( .A(n455), .B(n436), .S0(n349), .Y(n438) );
  INVX1 U269 ( .A(n437), .Y(n98) );
  NOR2X1 U270 ( .A(EXE_SHAMT[4]), .B(n363), .Y(N310) );
  MXI2X1 U271 ( .A(n362), .B(n86), .S0(EXE_SHAMT[3]), .Y(n363) );
  MXI2X1 U272 ( .A(n396), .B(n358), .S0(n349), .Y(n362) );
  INVX1 U273 ( .A(n392), .Y(n86) );
  NOR2X1 U274 ( .A(EXE_SHAMT[4]), .B(n372), .Y(N311) );
  MXI2X1 U275 ( .A(n371), .B(n90), .S0(EXE_SHAMT[3]), .Y(n372) );
  MXI2X1 U276 ( .A(n401), .B(n367), .S0(n349), .Y(n371) );
  INVX1 U277 ( .A(n393), .Y(n90) );
  NOR2X1 U278 ( .A(EXE_SHAMT[4]), .B(n380), .Y(N312) );
  MXI2X1 U279 ( .A(n379), .B(n88), .S0(EXE_SHAMT[3]), .Y(n380) );
  MXI2X1 U280 ( .A(n376), .B(n375), .S0(n349), .Y(n379) );
  INVX1 U281 ( .A(n394), .Y(n88) );
  MXI2X1 U282 ( .A(n413), .B(n95), .S0(n349), .Y(n460) );
  INVX1 U283 ( .A(n441), .Y(n95) );
  OAI22X1 U284 ( .A0(n82), .A1(n1), .B0(Ainput[6]), .B1(n4), .Y(n200) );
  OAI22X1 U285 ( .A0(n72), .A1(n1), .B0(Ainput[10]), .B1(n4), .Y(n266) );
  OAI22X1 U286 ( .A0(n66), .A1(n1), .B0(Ainput[2]), .B1(n4), .Y(n224) );
  OAI22X1 U287 ( .A0(n79), .A1(n1), .B0(Ainput[3]), .B1(n4), .Y(n218) );
  OAI22X1 U288 ( .A0(n65), .A1(n1), .B0(Ainput[7]), .B1(n4), .Y(n194) );
  OAI22X1 U289 ( .A0(n73), .A1(n1), .B0(Ainput[11]), .B1(n4), .Y(n260) );
  OAI22X1 U290 ( .A0(n76), .A1(n1), .B0(Ainput[14]), .B1(n4), .Y(n242) );
  OAI22X1 U291 ( .A0(n78), .A1(n1), .B0(Ainput[1]), .B1(n4), .Y(n230) );
  OAI22X1 U292 ( .A0(n84), .A1(n1), .B0(Ainput[9]), .B1(n4), .Y(n172) );
  OAI22X1 U293 ( .A0(n81), .A1(n1), .B0(Ainput[5]), .B1(n4), .Y(n206) );
  OAI22X1 U294 ( .A0(n75), .A1(n1), .B0(Ainput[13]), .B1(n4), .Y(n248) );
  OAI22X1 U295 ( .A0(n80), .A1(n1), .B0(Ainput[4]), .B1(n4), .Y(n212) );
  OAI22X1 U296 ( .A0(n83), .A1(n1), .B0(Ainput[8]), .B1(n4), .Y(n188) );
  OAI22X1 U297 ( .A0(n74), .A1(n1), .B0(Ainput[12]), .B1(n4), .Y(n254) );
  OAI22X1 U298 ( .A0(n77), .A1(n1), .B0(Ainput[15]), .B1(n4), .Y(n236) );
  OAI22X1 U299 ( .A0(n4), .A1(Ainput[0]), .B0(n1), .B1(n71), .Y(n284) );
  INVX1 U300 ( .A(Ainput[0]), .Y(n71) );
  INVX1 U301 ( .A(Ainput[6]), .Y(n82) );
  INVX1 U302 ( .A(Ainput[10]), .Y(n72) );
  INVX1 U303 ( .A(Ainput[3]), .Y(n79) );
  INVX1 U304 ( .A(Ainput[11]), .Y(n73) );
  INVX1 U305 ( .A(Ainput[14]), .Y(n76) );
  INVX1 U306 ( .A(Ainput[1]), .Y(n78) );
  INVX1 U307 ( .A(Ainput[9]), .Y(n84) );
  INVX1 U308 ( .A(Ainput[5]), .Y(n81) );
  INVX1 U309 ( .A(Ainput[13]), .Y(n75) );
  INVX1 U310 ( .A(Ainput[4]), .Y(n80) );
  INVX1 U311 ( .A(Ainput[8]), .Y(n83) );
  INVX1 U312 ( .A(Ainput[12]), .Y(n74) );
  INVX1 U313 ( .A(Ainput[15]), .Y(n77) );
  NOR2X1 U314 ( .A(EXE_SHAMT[4]), .B(n405), .Y(N307) );
  MXI2X1 U315 ( .A(n404), .B(n91), .S0(EXE_SHAMT[3]), .Y(n405) );
  MXI2X1 U316 ( .A(n402), .B(n401), .S0(n349), .Y(n404) );
  INVX1 U317 ( .A(n403), .Y(n91) );
  NOR2X1 U318 ( .A(EXE_SHAMT[4]), .B(n454), .Y(N320) );
  MXI2X1 U319 ( .A(n453), .B(n106), .S0(EXE_SHAMT[3]), .Y(n454) );
  MXI2X1 U320 ( .A(n451), .B(n450), .S0(n349), .Y(n453) );
  INVX1 U321 ( .A(n452), .Y(n106) );
  NOR2X1 U322 ( .A(EXE_SHAMT[4]), .B(n459), .Y(N321) );
  MXI2X1 U323 ( .A(n458), .B(n108), .S0(EXE_SHAMT[3]), .Y(n459) );
  INVX1 U324 ( .A(n457), .Y(n108) );
  MXI2X1 U325 ( .A(n456), .B(n455), .S0(n349), .Y(n458) );
  NOR4BX1 U326 ( .AN(n152), .B(n160), .C(n151), .D(n305), .Y(n154) );
  NOR3X1 U327 ( .A(n311), .B(n312), .C(n166), .Y(n160) );
  NOR2X1 U328 ( .A(n312), .B(n307), .Y(n159) );
  AND3X2 U329 ( .A(n313), .B(n312), .C(n155), .Y(n150) );
  AOI31X1 U330 ( .A0(n309), .A1(n312), .A2(n163), .B0(n308), .Y(n152) );
  INVX1 U331 ( .A(n157), .Y(n308) );
  INVX1 U332 ( .A(n147), .Y(n305) );
  INVX1 U333 ( .A(n163), .Y(n311) );
  INVX1 U334 ( .A(n166), .Y(n309) );
  INVX1 U335 ( .A(n146), .Y(n310) );
  AOI31X1 U336 ( .A0(n146), .A1(n147), .A2(n148), .B0(n149), .Y(N148) );
  AOI21X1 U337 ( .A0(n150), .A1(n307), .B0(n151), .Y(n148) );
  INVX1 U338 ( .A(Read_data1[0]), .Y(n329) );
  OAI222XL U339 ( .A0(n182), .A1(n130), .B0(n183), .B1(n301), .C0(n184), .C1(
        n327), .Y(Ainput[2]) );
  INVX1 U340 ( .A(Read_data1[2]), .Y(n327) );
  OAI222XL U341 ( .A0(n182), .A1(n129), .B0(n183), .B1(n300), .C0(n184), .C1(
        n326), .Y(Ainput[3]) );
  INVX1 U342 ( .A(Read_data1[3]), .Y(n326) );
  OAI222XL U343 ( .A0(n182), .A1(n131), .B0(n183), .B1(n302), .C0(n184), .C1(
        n328), .Y(Ainput[1]) );
  INVX1 U344 ( .A(Read_data1[1]), .Y(n328) );
  OAI222XL U345 ( .A0(n182), .A1(n128), .B0(n183), .B1(n299), .C0(n184), .C1(
        n325), .Y(Ainput[4]) );
  INVX1 U346 ( .A(Read_data1[4]), .Y(n325) );
  AOI22X1 U347 ( .A0(n347), .A1(Write_DataOUT[6]), .B0(Sign_extend[6]), .B1(
        n27), .Y(n201) );
  AOI22X1 U348 ( .A0(n27), .A1(Sign_extend[1]), .B0(n347), .B1(
        Write_DataOUT[1]), .Y(n231) );
  AOI22X1 U349 ( .A0(n27), .A1(Sign_extend[2]), .B0(n347), .B1(
        Write_DataOUT[2]), .Y(n225) );
  AOI22X1 U350 ( .A0(n27), .A1(Sign_extend[3]), .B0(n347), .B1(
        Write_DataOUT[3]), .Y(n219) );
  AOI22X1 U351 ( .A0(n27), .A1(Sign_extend[4]), .B0(n347), .B1(
        Write_DataOUT[4]), .Y(n213) );
  AOI22X1 U352 ( .A0(n27), .A1(Sign_extend[5]), .B0(n347), .B1(
        Write_DataOUT[5]), .Y(n207) );
  AOI22X1 U353 ( .A0(n27), .A1(Sign_extend[0]), .B0(n347), .B1(
        Write_DataOUT[0]), .Y(n282) );
  AND4X2 U354 ( .A(Branch), .B(n135), .C(Opcode[2]), .D(n136), .Y(branch_taken) );
  NOR4X1 U355 ( .A(Opcode[5]), .B(Opcode[4]), .C(Opcode[3]), .D(Opcode[1]), 
        .Y(n136) );
  XOR2X1 U356 ( .A(Opcode[0]), .B(N66), .Y(n135) );
  INVX1 U357 ( .A(n273), .Y(n67) );
  AOI32X1 U358 ( .A0(n274), .A1(n24), .A2(ALU_ctl[2]), .B0(n69), .B1(n275), 
        .Y(n273) );
  OAI222XL U359 ( .A0(n177), .A1(n126), .B0(n178), .B1(n297), .C0(n179), .C1(
        n339), .Y(Write_DataOUT[6]) );
  INVX1 U360 ( .A(Read_data2[6]), .Y(n339) );
  OAI222XL U361 ( .A0(n177), .A1(n287), .B0(n178), .B1(n303), .C0(n179), .C1(
        n345), .Y(Write_DataOUT[0]) );
  INVX1 U362 ( .A(Read_data2[0]), .Y(n345) );
  OAI222XL U363 ( .A0(n177), .A1(n131), .B0(n178), .B1(n302), .C0(n179), .C1(
        n344), .Y(Write_DataOUT[1]) );
  INVX1 U364 ( .A(Read_data2[1]), .Y(n344) );
  OAI222XL U365 ( .A0(n177), .A1(n130), .B0(n178), .B1(n301), .C0(n179), .C1(
        n343), .Y(Write_DataOUT[2]) );
  INVX1 U366 ( .A(Read_data2[2]), .Y(n343) );
  OAI222XL U367 ( .A0(n177), .A1(n129), .B0(n178), .B1(n300), .C0(n179), .C1(
        n342), .Y(Write_DataOUT[3]) );
  INVX1 U368 ( .A(Read_data2[3]), .Y(n342) );
  OAI222XL U369 ( .A0(n177), .A1(n128), .B0(n178), .B1(n299), .C0(n179), .C1(
        n341), .Y(Write_DataOUT[4]) );
  INVX1 U370 ( .A(Read_data2[4]), .Y(n341) );
  OAI222XL U371 ( .A0(n177), .A1(n127), .B0(n178), .B1(n298), .C0(n179), .C1(
        n340), .Y(Write_DataOUT[5]) );
  INVX1 U372 ( .A(Read_data2[5]), .Y(n340) );
  INVX1 U373 ( .A(MEM_WBWriteDATA[0]), .Y(n287) );
  INVX1 U374 ( .A(MEM_WBWriteDATA[1]), .Y(n131) );
  BUFX3 U375 ( .A(Sign_extend[12]), .Y(Last_inst[12]) );
  BUFX3 U376 ( .A(Sign_extend[8]), .Y(Last_inst[8]) );
  BUFX3 U377 ( .A(Sign_extend[13]), .Y(Last_inst[13]) );
  OAI222XL U378 ( .A0(n182), .A1(n126), .B0(n183), .B1(n297), .C0(n184), .C1(
        n323), .Y(Ainput[6]) );
  INVX1 U379 ( .A(Read_data1[6]), .Y(n323) );
  OAI222XL U380 ( .A0(n182), .A1(n286), .B0(n183), .B1(n293), .C0(n184), .C1(
        n319), .Y(Ainput[10]) );
  INVX1 U381 ( .A(Read_data1[10]), .Y(n319) );
  OAI222XL U382 ( .A0(n182), .A1(n125), .B0(n183), .B1(n296), .C0(n184), .C1(
        n322), .Y(Ainput[7]) );
  INVX1 U383 ( .A(Read_data1[7]), .Y(n322) );
  OAI222XL U384 ( .A0(n182), .A1(n180), .B0(n183), .B1(n292), .C0(n184), .C1(
        n318), .Y(Ainput[11]) );
  INVX1 U385 ( .A(Read_data1[11]), .Y(n318) );
  OAI222XL U386 ( .A0(n182), .A1(n133), .B0(n183), .B1(n289), .C0(n184), .C1(
        n315), .Y(Ainput[14]) );
  INVX1 U387 ( .A(Read_data1[14]), .Y(n315) );
  BUFX3 U388 ( .A(Sign_extend[9]), .Y(Last_inst[9]) );
  OAI222XL U389 ( .A0(n123), .A1(n182), .B0(n294), .B1(n183), .C0(n184), .C1(
        n320), .Y(Ainput[9]) );
  INVX1 U390 ( .A(Read_data1[9]), .Y(n320) );
  OAI222XL U391 ( .A0(n182), .A1(n127), .B0(n183), .B1(n298), .C0(n184), .C1(
        n324), .Y(Ainput[5]) );
  INVX1 U392 ( .A(Read_data1[5]), .Y(n324) );
  OAI222XL U393 ( .A0(n182), .A1(n134), .B0(n183), .B1(n290), .C0(n184), .C1(
        n316), .Y(Ainput[13]) );
  INVX1 U394 ( .A(Read_data1[13]), .Y(n316) );
  OAI222XL U395 ( .A0(n182), .A1(n124), .B0(n183), .B1(n295), .C0(n184), .C1(
        n321), .Y(Ainput[8]) );
  INVX1 U396 ( .A(Read_data1[8]), .Y(n321) );
  OAI222XL U397 ( .A0(n182), .A1(n175), .B0(n183), .B1(n291), .C0(n184), .C1(
        n317), .Y(Ainput[12]) );
  INVX1 U398 ( .A(Read_data1[12]), .Y(n317) );
  NAND4X1 U399 ( .A(N349), .B(n274), .C(ALU_ctl[0]), .D(ALU_ctl[2]), .Y(n285)
         );
  AOI22X1 U400 ( .A0(n347), .A1(Write_DataOUT[7]), .B0(Sign_extend[7]), .B1(
        n27), .Y(n195) );
  AOI22X1 U401 ( .A0(n347), .A1(Write_DataOUT[8]), .B0(Sign_extend[8]), .B1(
        n27), .Y(n189) );
  AOI22X1 U402 ( .A0(n347), .A1(Write_DataOUT[9]), .B0(Sign_extend[9]), .B1(
        n27), .Y(n173) );
  AOI22X1 U403 ( .A0(n347), .A1(Write_DataOUT[10]), .B0(Sign_extend[10]), .B1(
        n27), .Y(n267) );
  AOI22X1 U404 ( .A0(n347), .A1(Write_DataOUT[11]), .B0(Sign_extend[11]), .B1(
        n27), .Y(n261) );
  AOI22X1 U405 ( .A0(n347), .A1(Write_DataOUT[12]), .B0(Sign_extend[12]), .B1(
        n27), .Y(n255) );
  AOI22X1 U406 ( .A0(n347), .A1(Write_DataOUT[13]), .B0(Sign_extend[13]), .B1(
        n27), .Y(n249) );
  AOI22X1 U407 ( .A0(n347), .A1(Write_DataOUT[14]), .B0(Sign_extend[14]), .B1(
        n27), .Y(n243) );
  AOI22X1 U408 ( .A0(n347), .A1(Write_DataOUT[15]), .B0(Sign_extend[15]), .B1(
        n27), .Y(n237) );
  OAI222XL U409 ( .A0(n182), .A1(n132), .B0(n183), .B1(n288), .C0(n184), .C1(
        n314), .Y(Ainput[15]) );
  INVX1 U410 ( .A(Read_data1[15]), .Y(n314) );
  BUFX3 U411 ( .A(ALUSrc), .Y(n27) );
  MX2X1 U412 ( .A(n412), .B(n410), .S0(EXE_SHAMT[1]), .Y(n413) );
  MX2X1 U413 ( .A(n415), .B(n414), .S0(EXE_SHAMT[1]), .Y(n421) );
  MX2X1 U414 ( .A(n370), .B(n368), .S0(EXE_SHAMT[1]), .Y(n386) );
  MX2X1 U415 ( .A(n360), .B(n350), .S0(EXE_SHAMT[1]), .Y(n378) );
  OAI222XL U416 ( .A0(n177), .A1(n125), .B0(n178), .B1(n296), .C0(n179), .C1(
        n338), .Y(Write_DataOUT[7]) );
  INVX1 U417 ( .A(Read_data2[7]), .Y(n338) );
  OAI222XL U418 ( .A0(n177), .A1(n124), .B0(n178), .B1(n295), .C0(n179), .C1(
        n337), .Y(Write_DataOUT[8]) );
  INVX1 U419 ( .A(Read_data2[8]), .Y(n337) );
  OAI222XL U420 ( .A0(n177), .A1(n123), .B0(n178), .B1(n294), .C0(n179), .C1(
        n336), .Y(Write_DataOUT[9]) );
  INVX1 U421 ( .A(Read_data2[9]), .Y(n336) );
  OAI222XL U422 ( .A0(n177), .A1(n286), .B0(n178), .B1(n293), .C0(n179), .C1(
        n335), .Y(Write_DataOUT[10]) );
  INVX1 U423 ( .A(Read_data2[10]), .Y(n335) );
  OAI222XL U424 ( .A0(n177), .A1(n180), .B0(n178), .B1(n292), .C0(n179), .C1(
        n334), .Y(Write_DataOUT[11]) );
  INVX1 U425 ( .A(Read_data2[11]), .Y(n334) );
  OAI222XL U426 ( .A0(n177), .A1(n175), .B0(n178), .B1(n291), .C0(n179), .C1(
        n333), .Y(Write_DataOUT[12]) );
  INVX1 U427 ( .A(Read_data2[12]), .Y(n333) );
  OAI222XL U428 ( .A0(n177), .A1(n134), .B0(n178), .B1(n290), .C0(n179), .C1(
        n332), .Y(Write_DataOUT[13]) );
  INVX1 U429 ( .A(Read_data2[13]), .Y(n332) );
  OAI222XL U430 ( .A0(n177), .A1(n133), .B0(n178), .B1(n289), .C0(n179), .C1(
        n331), .Y(Write_DataOUT[14]) );
  INVX1 U431 ( .A(Read_data2[14]), .Y(n331) );
  OAI222XL U432 ( .A0(n177), .A1(n132), .B0(n178), .B1(n288), .C0(n179), .C1(
        n330), .Y(Write_DataOUT[15]) );
  INVX1 U433 ( .A(Read_data2[15]), .Y(n330) );
  BUFX3 U434 ( .A(Sign_extend[10]), .Y(Last_inst[10]) );
  BUFX3 U435 ( .A(Sign_extend[1]), .Y(Last_inst[1]) );
  BUFX3 U436 ( .A(Sign_extend[2]), .Y(Last_inst[2]) );
  BUFX3 U437 ( .A(Sign_extend[3]), .Y(Last_inst[3]) );
  BUFX3 U438 ( .A(Sign_extend[4]), .Y(Last_inst[4]) );
  BUFX3 U439 ( .A(Sign_extend[5]), .Y(Last_inst[5]) );
  BUFX3 U440 ( .A(Sign_extend[6]), .Y(Last_inst[6]) );
  BUFX3 U441 ( .A(Sign_extend[7]), .Y(Last_inst[7]) );
  BUFX3 U442 ( .A(Sign_extend[11]), .Y(Last_inst[11]) );
  BUFX3 U443 ( .A(Sign_extend[14]), .Y(Last_inst[14]) );
  INVX1 U444 ( .A(EX_MEMALUResult[9]), .Y(n294) );
  INVX1 U445 ( .A(EX_MEMALUResult[0]), .Y(n303) );
  INVX1 U446 ( .A(EX_MEMALUResult[1]), .Y(n302) );
  INVX1 U447 ( .A(EX_MEMALUResult[2]), .Y(n301) );
  INVX1 U448 ( .A(EX_MEMALUResult[3]), .Y(n300) );
  INVX1 U449 ( .A(EX_MEMALUResult[4]), .Y(n299) );
  INVX1 U450 ( .A(EX_MEMALUResult[5]), .Y(n298) );
  INVX1 U451 ( .A(EX_MEMALUResult[6]), .Y(n297) );
  INVX1 U452 ( .A(EX_MEMALUResult[7]), .Y(n296) );
  INVX1 U453 ( .A(EX_MEMALUResult[8]), .Y(n295) );
  INVX1 U454 ( .A(EX_MEMALUResult[10]), .Y(n293) );
  INVX1 U455 ( .A(EX_MEMALUResult[11]), .Y(n292) );
  INVX1 U456 ( .A(EX_MEMALUResult[12]), .Y(n291) );
  INVX1 U457 ( .A(EX_MEMALUResult[13]), .Y(n290) );
  INVX1 U458 ( .A(EX_MEMALUResult[14]), .Y(n289) );
  INVX1 U459 ( .A(EX_MEMALUResult[15]), .Y(n288) );
  INVX1 U460 ( .A(MEM_WBWriteDATA[9]), .Y(n123) );
  INVX1 U461 ( .A(MEM_WBWriteDATA[2]), .Y(n130) );
  INVX1 U462 ( .A(MEM_WBWriteDATA[3]), .Y(n129) );
  INVX1 U463 ( .A(MEM_WBWriteDATA[4]), .Y(n128) );
  INVX1 U464 ( .A(MEM_WBWriteDATA[5]), .Y(n127) );
  INVX1 U465 ( .A(MEM_WBWriteDATA[6]), .Y(n126) );
  INVX1 U466 ( .A(MEM_WBWriteDATA[7]), .Y(n125) );
  INVX1 U467 ( .A(MEM_WBWriteDATA[8]), .Y(n124) );
  INVX1 U468 ( .A(MEM_WBWriteDATA[10]), .Y(n286) );
  INVX1 U469 ( .A(MEM_WBWriteDATA[11]), .Y(n180) );
  INVX1 U470 ( .A(MEM_WBWriteDATA[12]), .Y(n175) );
  INVX1 U471 ( .A(MEM_WBWriteDATA[13]), .Y(n134) );
  INVX1 U472 ( .A(MEM_WBWriteDATA[14]), .Y(n133) );
  INVX1 U473 ( .A(MEM_WBWriteDATA[15]), .Y(n132) );
  BUFX3 U474 ( .A(Sign_extend[0]), .Y(Last_inst[0]) );
  INVX1 U475 ( .A(EXE_SHAMT[2]), .Y(n349) );
  INVX1 U476 ( .A(RegDst), .Y(n346) );
  INVX1 U477 ( .A(n144), .Y(Write_RegOUT[1]) );
  AOI22X1 U478 ( .A0(RD_IN[1]), .A1(RegDst), .B0(RT_IN[1]), .B1(n346), .Y(n144) );
  INVX1 U479 ( .A(n145), .Y(Write_RegOUT[0]) );
  AOI22X1 U480 ( .A0(RD_IN[0]), .A1(RegDst), .B0(RT_IN[0]), .B1(n346), .Y(n145) );
  INVX1 U481 ( .A(n141), .Y(Write_RegOUT[4]) );
  AOI22X1 U482 ( .A0(RegDst), .A1(RD_IN[4]), .B0(RT_IN[4]), .B1(n346), .Y(n141) );
  INVX1 U483 ( .A(n143), .Y(Write_RegOUT[2]) );
  AOI22X1 U484 ( .A0(RD_IN[2]), .A1(RegDst), .B0(RT_IN[2]), .B1(n346), .Y(n143) );
  INVX1 U485 ( .A(n142), .Y(Write_RegOUT[3]) );
  AOI22X1 U486 ( .A0(RD_IN[3]), .A1(RegDst), .B0(RT_IN[3]), .B1(n346), .Y(n142) );
  BUFX3 U487 ( .A(Sign_extend[15]), .Y(Last_inst[15]) );
  NAND3X1 U488 ( .A(n23), .B(n22), .C(n277), .Y(n176) );
  NOR2X1 U489 ( .A(n23), .B(ALU_ctl[3]), .Y(n274) );
  NOR2X1 U490 ( .A(ALU_ctl[2]), .B(ALU_ctl[0]), .Y(n277) );
  NAND3X1 U491 ( .A(Sign_extend[5]), .B(n313), .C(Sign_extend[1]), .Y(n166) );
  NOR2X1 U492 ( .A(n24), .B(ALU_ctl[2]), .Y(n278) );
  NAND3X1 U493 ( .A(n277), .B(ALU_ctl[1]), .C(ALU_ctl[3]), .Y(n280) );
  NOR2X1 U494 ( .A(Sign_extend[4]), .B(Sign_extend[3]), .Y(n163) );
  AND3X2 U495 ( .A(n277), .B(n23), .C(ALU_ctl[3]), .Y(n170) );
  NAND4BXL U496 ( .AN(Sign_extend[4]), .B(Sign_extend[3]), .C(n309), .D(n312), 
        .Y(n157) );
  AND3X2 U497 ( .A(n278), .B(n23), .C(ALU_ctl[3]), .Y(n171) );
  NAND3X1 U498 ( .A(n23), .B(n22), .C(n278), .Y(n281) );
  NAND4X1 U499 ( .A(Sign_extend[3]), .B(Sign_extend[4]), .C(Sign_extend[1]), 
        .D(n165), .Y(n147) );
  NOR2X1 U500 ( .A(n313), .B(n306), .Y(n165) );
  OAI22X1 U501 ( .A0(ALUop[1]), .A1(n348), .B0(n152), .B1(n149), .Y(N147) );
  NAND2X1 U502 ( .A(ALUop[1]), .B(n348), .Y(n149) );
  NAND3X1 U503 ( .A(n163), .B(Sign_extend[1]), .C(n164), .Y(n146) );
  NOR3X1 U504 ( .A(Sign_extend[0]), .B(Sign_extend[5]), .C(Sign_extend[2]), 
        .Y(n164) );
  NOR2X1 U505 ( .A(n311), .B(Sign_extend[1]), .Y(n155) );
  INVX1 U506 ( .A(Sign_extend[2]), .Y(n312) );
  NAND3BX1 U507 ( .AN(n149), .B(n154), .C(n161), .Y(N144) );
  AOI21X1 U508 ( .A0(n155), .A1(n162), .B0(n310), .Y(n161) );
  OAI21XL U509 ( .A0(Sign_extend[2]), .A1(Sign_extend[0]), .B0(n306), .Y(n162)
         );
  OAI21XL U510 ( .A0(n153), .A1(n149), .B0(ALUop[1]), .Y(N146) );
  AOI21X1 U511 ( .A0(n150), .A1(Sign_extend[5]), .B0(n304), .Y(n153) );
  INVX1 U512 ( .A(n154), .Y(n304) );
  AND4X2 U513 ( .A(n309), .B(Sign_extend[2]), .C(Sign_extend[3]), .D(
        Sign_extend[4]), .Y(n151) );
  INVX1 U514 ( .A(Sign_extend[5]), .Y(n307) );
  INVX1 U515 ( .A(Sign_extend[0]), .Y(n313) );
  AND3X2 U516 ( .A(n278), .B(ALU_ctl[1]), .C(ALU_ctl[3]), .Y(n275) );
  INVX1 U517 ( .A(ALUop[0]), .Y(n348) );
  AOI31X1 U518 ( .A0(n156), .A1(n157), .A2(n158), .B0(n149), .Y(N145) );
  AOI31X1 U519 ( .A0(n159), .A1(Sign_extend[0]), .A2(n155), .B0(n160), .Y(n158) );
  NOR2X1 U520 ( .A(n305), .B(n310), .Y(n156) );
  OR2X1 U521 ( .A(n115), .B(n79), .Y(n47) );
  NOR2X1 U522 ( .A(n66), .B(srl_107_A_2_), .Y(n46) );
  AND2X1 U523 ( .A(Ainput[15]), .B(n237), .Y(n45) );
  NAND2X1 U524 ( .A(Ainput[13]), .B(n249), .Y(n59) );
  OR2X1 U525 ( .A(n107), .B(n76), .Y(n58) );
  NAND2X1 U526 ( .A(Ainput[9]), .B(n173), .Y(n53) );
  NAND2BX1 U527 ( .AN(srl_107_A_10_), .B(Ainput[10]), .Y(n54) );
  AND2X1 U528 ( .A(n53), .B(n54), .Y(n40) );
  NAND2X1 U529 ( .A(Ainput[5]), .B(n207), .Y(n49) );
  NAND2BX1 U530 ( .AN(n120), .B(Ainput[6]), .Y(n50) );
  AND2X1 U531 ( .A(n49), .B(n50), .Y(n36) );
  NAND2BX1 U532 ( .AN(Ainput[0]), .B(srl_107_A_0_), .Y(n31) );
  AOI2BB1X1 U533 ( .A0N(n31), .A1N(Ainput[1]), .B0(n111), .Y(n30) );
  AOI211X1 U534 ( .A0(Ainput[1]), .A1(n31), .B0(n46), .C0(n30), .Y(n32) );
  AOI221X1 U535 ( .A0(n115), .A1(n79), .B0(srl_107_A_2_), .B1(n66), .C0(n32), 
        .Y(n34) );
  NAND2X1 U536 ( .A(Ainput[4]), .B(n213), .Y(n48) );
  NAND2X1 U537 ( .A(n48), .B(n47), .Y(n33) );
  OAI222XL U538 ( .A0(n34), .A1(n33), .B0(Ainput[4]), .B1(n213), .C0(Ainput[5]), .C1(n207), .Y(n35) );
  AOI222X1 U539 ( .A0(srl_107_A_7_), .A1(n65), .B0(n120), .B1(n82), .C0(n36), 
        .C1(n35), .Y(n38) );
  NAND2X1 U540 ( .A(Ainput[8]), .B(n189), .Y(n52) );
  OR2X1 U541 ( .A(srl_107_A_7_), .B(n65), .Y(n51) );
  NAND2X1 U542 ( .A(n52), .B(n51), .Y(n37) );
  OAI222XL U543 ( .A0(n38), .A1(n37), .B0(Ainput[8]), .B1(n189), .C0(Ainput[9]), .C1(n173), .Y(n39) );
  AOI222X1 U544 ( .A0(n100), .A1(n73), .B0(srl_107_A_10_), .B1(n72), .C0(n40), 
        .C1(n39), .Y(n42) );
  NAND2X1 U545 ( .A(Ainput[12]), .B(n255), .Y(n57) );
  OR2X1 U546 ( .A(n100), .B(n73), .Y(n55) );
  NAND2X1 U547 ( .A(n57), .B(n55), .Y(n41) );
  OAI222XL U548 ( .A0(n42), .A1(n41), .B0(Ainput[12]), .B1(n255), .C0(
        Ainput[13]), .C1(n249), .Y(n43) );
  AOI32X1 U549 ( .A0(n59), .A1(n58), .A2(n43), .B0(n107), .B1(n76), .Y(n44) );
  OAI22X1 U550 ( .A0(Ainput[15]), .A1(n237), .B0(n45), .B1(n44), .Y(N349) );
  NOR4BX1 U551 ( .AN(n47), .B(n46), .C(n45), .D(N349), .Y(n64) );
  NAND4X1 U552 ( .A(n51), .B(n50), .C(n49), .D(n48), .Y(n63) );
  NAND4X1 U553 ( .A(n55), .B(n54), .C(n53), .D(n52), .Y(n62) );
  NOR2BX1 U554 ( .AN(Ainput[0]), .B(srl_107_A_0_), .Y(n56) );
  OAI22X1 U555 ( .A0(Ainput[1]), .A1(n56), .B0(n56), .B1(n231), .Y(n60) );
  NAND4X1 U556 ( .A(n60), .B(n59), .C(n58), .D(n57), .Y(n61) );
  NOR4BX1 U557 ( .AN(n64), .B(n63), .C(n62), .D(n61), .Y(N66) );
endmodule


module EX_MEMreg ( clk, rst, RTD_ADDRIN, ALU_ResIN, RT_IN, RegWrite, MemtoReg, 
        Branch, MemRead, MemWrite, ZERO_IN, RTD_ADDROUT, ALU_ResOUT, RT_OUT, 
        RegWrite_out, MemtoReg_out, Branch_out, MemRead_out, MemWrite_out, 
        ZERO_OUT );
  input [4:0] RTD_ADDRIN;
  input [15:0] ALU_ResIN;
  input [15:0] RT_IN;
  output [4:0] RTD_ADDROUT;
  output [15:0] ALU_ResOUT;
  output [15:0] RT_OUT;
  input clk, rst, RegWrite, MemtoReg, Branch, MemRead, MemWrite, ZERO_IN;
  output RegWrite_out, MemtoReg_out, Branch_out, MemRead_out, MemWrite_out,
         ZERO_OUT;
  wire   n1;

  DFFRHQX1 Branch_out_reg ( .D(Branch), .CK(clk), .RN(n1), .Q(Branch_out) );
  DFFRHQX1 ZERO_OUT_reg ( .D(ZERO_IN), .CK(clk), .RN(n1), .Q(ZERO_OUT) );
  DFFRHQX1 ALU_ResOUT_reg_15_ ( .D(ALU_ResIN[15]), .CK(clk), .RN(n1), .Q(
        ALU_ResOUT[15]) );
  DFFRHQX1 ALU_ResOUT_reg_14_ ( .D(ALU_ResIN[14]), .CK(clk), .RN(n1), .Q(
        ALU_ResOUT[14]) );
  DFFRHQX1 ALU_ResOUT_reg_13_ ( .D(ALU_ResIN[13]), .CK(clk), .RN(n1), .Q(
        ALU_ResOUT[13]) );
  DFFRHQX1 ALU_ResOUT_reg_12_ ( .D(ALU_ResIN[12]), .CK(clk), .RN(n1), .Q(
        ALU_ResOUT[12]) );
  DFFRHQX1 ALU_ResOUT_reg_11_ ( .D(ALU_ResIN[11]), .CK(clk), .RN(n1), .Q(
        ALU_ResOUT[11]) );
  DFFRHQX1 ALU_ResOUT_reg_10_ ( .D(ALU_ResIN[10]), .CK(clk), .RN(n1), .Q(
        ALU_ResOUT[10]) );
  DFFRHQX1 ALU_ResOUT_reg_9_ ( .D(ALU_ResIN[9]), .CK(clk), .RN(n1), .Q(
        ALU_ResOUT[9]) );
  DFFRHQX1 ALU_ResOUT_reg_8_ ( .D(ALU_ResIN[8]), .CK(clk), .RN(n1), .Q(
        ALU_ResOUT[8]) );
  DFFRHQX1 ALU_ResOUT_reg_7_ ( .D(ALU_ResIN[7]), .CK(clk), .RN(n1), .Q(
        ALU_ResOUT[7]) );
  DFFRHQX1 ALU_ResOUT_reg_6_ ( .D(ALU_ResIN[6]), .CK(clk), .RN(n1), .Q(
        ALU_ResOUT[6]) );
  DFFRHQX1 ALU_ResOUT_reg_5_ ( .D(ALU_ResIN[5]), .CK(clk), .RN(n1), .Q(
        ALU_ResOUT[5]) );
  DFFRHQX1 ALU_ResOUT_reg_4_ ( .D(ALU_ResIN[4]), .CK(clk), .RN(n1), .Q(
        ALU_ResOUT[4]) );
  DFFRHQX1 ALU_ResOUT_reg_3_ ( .D(ALU_ResIN[3]), .CK(clk), .RN(n1), .Q(
        ALU_ResOUT[3]) );
  DFFRHQX1 ALU_ResOUT_reg_2_ ( .D(ALU_ResIN[2]), .CK(clk), .RN(n1), .Q(
        ALU_ResOUT[2]) );
  DFFRHQX1 ALU_ResOUT_reg_1_ ( .D(ALU_ResIN[1]), .CK(clk), .RN(n1), .Q(
        ALU_ResOUT[1]) );
  DFFRHQX1 ALU_ResOUT_reg_0_ ( .D(ALU_ResIN[0]), .CK(clk), .RN(n1), .Q(
        ALU_ResOUT[0]) );
  DFFRHQX1 RegWrite_out_reg ( .D(RegWrite), .CK(clk), .RN(n1), .Q(RegWrite_out) );
  DFFRHQX1 RTD_ADDROUT_reg_3_ ( .D(RTD_ADDRIN[3]), .CK(clk), .RN(n1), .Q(
        RTD_ADDROUT[3]) );
  DFFRHQX1 RTD_ADDROUT_reg_2_ ( .D(RTD_ADDRIN[2]), .CK(clk), .RN(n1), .Q(
        RTD_ADDROUT[2]) );
  DFFRHQX1 RTD_ADDROUT_reg_1_ ( .D(RTD_ADDRIN[1]), .CK(clk), .RN(n1), .Q(
        RTD_ADDROUT[1]) );
  DFFRHQX1 RTD_ADDROUT_reg_0_ ( .D(RTD_ADDRIN[0]), .CK(clk), .RN(n1), .Q(
        RTD_ADDROUT[0]) );
  DFFRHQX1 RTD_ADDROUT_reg_4_ ( .D(RTD_ADDRIN[4]), .CK(clk), .RN(n1), .Q(
        RTD_ADDROUT[4]) );
  DFFRHQX1 RT_OUT_reg_15_ ( .D(RT_IN[15]), .CK(clk), .RN(n1), .Q(RT_OUT[15])
         );
  DFFRHQX1 RT_OUT_reg_14_ ( .D(RT_IN[14]), .CK(clk), .RN(n1), .Q(RT_OUT[14])
         );
  DFFRHQX1 RT_OUT_reg_13_ ( .D(RT_IN[13]), .CK(clk), .RN(n1), .Q(RT_OUT[13])
         );
  DFFRHQX1 RT_OUT_reg_12_ ( .D(RT_IN[12]), .CK(clk), .RN(n1), .Q(RT_OUT[12])
         );
  DFFRHQX1 RT_OUT_reg_11_ ( .D(RT_IN[11]), .CK(clk), .RN(n1), .Q(RT_OUT[11])
         );
  DFFRHQX1 RT_OUT_reg_10_ ( .D(RT_IN[10]), .CK(clk), .RN(n1), .Q(RT_OUT[10])
         );
  DFFRHQX1 RT_OUT_reg_9_ ( .D(RT_IN[9]), .CK(clk), .RN(n1), .Q(RT_OUT[9]) );
  DFFRHQX1 RT_OUT_reg_8_ ( .D(RT_IN[8]), .CK(clk), .RN(n1), .Q(RT_OUT[8]) );
  DFFRHQX1 RT_OUT_reg_7_ ( .D(RT_IN[7]), .CK(clk), .RN(n1), .Q(RT_OUT[7]) );
  DFFRHQX1 RT_OUT_reg_6_ ( .D(RT_IN[6]), .CK(clk), .RN(n1), .Q(RT_OUT[6]) );
  DFFRHQX1 RT_OUT_reg_5_ ( .D(RT_IN[5]), .CK(clk), .RN(n1), .Q(RT_OUT[5]) );
  DFFRHQX1 RT_OUT_reg_4_ ( .D(RT_IN[4]), .CK(clk), .RN(n1), .Q(RT_OUT[4]) );
  DFFRHQX1 RT_OUT_reg_3_ ( .D(RT_IN[3]), .CK(clk), .RN(n1), .Q(RT_OUT[3]) );
  DFFRHQX1 RT_OUT_reg_2_ ( .D(RT_IN[2]), .CK(clk), .RN(n1), .Q(RT_OUT[2]) );
  DFFRHQX1 RT_OUT_reg_1_ ( .D(RT_IN[1]), .CK(clk), .RN(n1), .Q(RT_OUT[1]) );
  DFFRHQX1 RT_OUT_reg_0_ ( .D(RT_IN[0]), .CK(clk), .RN(n1), .Q(RT_OUT[0]) );
  DFFRHQX1 MemWrite_out_reg ( .D(MemWrite), .CK(clk), .RN(n1), .Q(MemWrite_out) );
  DFFRHQX1 MemRead_out_reg ( .D(MemRead), .CK(clk), .RN(n1), .Q(MemRead_out)
         );
  DFFRHQX1 MemtoReg_out_reg ( .D(MemtoReg), .CK(clk), .RN(n1), .Q(MemtoReg_out) );
  INVX1 U3 ( .A(rst), .Y(n1) );
endmodule


module memory_access ( clk, reset, Branch, ZERO, PCSrc );
  input clk, reset, Branch, ZERO;
  output PCSrc;
  wire   n2;

  INVX1 U2 ( .A(n2), .Y(PCSrc) );
  NAND3BX1 U3 ( .AN(reset), .B(Branch), .C(ZERO), .Y(n2) );
endmodule


module MEM_WBreg ( clk, rst, RegWrite, MemtoReg, WRITE_REG, READ_DATA, ADDRESS, 
        RegWrite_out, MemtoReg_out, WRITE_RegOUT, READ_DataOUT, ADDRESS_OUT, 
        write_data );
  input [4:0] WRITE_REG;
  input [15:0] READ_DATA;
  input [15:0] ADDRESS;
  output [4:0] WRITE_RegOUT;
  output [15:0] READ_DataOUT;
  output [15:0] ADDRESS_OUT;
  output [15:0] write_data;
  input clk, rst, RegWrite, MemtoReg;
  output RegWrite_out, MemtoReg_out;
  wire   n26, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n1, n2, n20, n21, n22, n23, n24, n25;

  DFFRHQX1 READ_DataOUT_reg_15_ ( .D(READ_DATA[15]), .CK(clk), .RN(n25), .Q(
        READ_DataOUT[15]) );
  DFFRHQX1 READ_DataOUT_reg_14_ ( .D(READ_DATA[14]), .CK(clk), .RN(n2), .Q(
        READ_DataOUT[14]) );
  DFFRHQX1 READ_DataOUT_reg_13_ ( .D(READ_DATA[13]), .CK(clk), .RN(n2), .Q(
        READ_DataOUT[13]) );
  DFFRHQX1 READ_DataOUT_reg_12_ ( .D(READ_DATA[12]), .CK(clk), .RN(n25), .Q(
        READ_DataOUT[12]) );
  DFFRHQX1 READ_DataOUT_reg_11_ ( .D(READ_DATA[11]), .CK(clk), .RN(n25), .Q(
        READ_DataOUT[11]) );
  DFFRHQX1 READ_DataOUT_reg_10_ ( .D(READ_DATA[10]), .CK(clk), .RN(n25), .Q(
        READ_DataOUT[10]) );
  DFFRHQX1 READ_DataOUT_reg_9_ ( .D(READ_DATA[9]), .CK(clk), .RN(n25), .Q(
        READ_DataOUT[9]) );
  DFFRHQX1 READ_DataOUT_reg_8_ ( .D(READ_DATA[8]), .CK(clk), .RN(n25), .Q(
        READ_DataOUT[8]) );
  DFFRHQX1 READ_DataOUT_reg_7_ ( .D(READ_DATA[7]), .CK(clk), .RN(n25), .Q(
        READ_DataOUT[7]) );
  DFFRHQX1 READ_DataOUT_reg_6_ ( .D(READ_DATA[6]), .CK(clk), .RN(n25), .Q(
        READ_DataOUT[6]) );
  DFFRHQX1 READ_DataOUT_reg_5_ ( .D(READ_DATA[5]), .CK(clk), .RN(n2), .Q(
        READ_DataOUT[5]) );
  DFFRHQX1 READ_DataOUT_reg_4_ ( .D(READ_DATA[4]), .CK(clk), .RN(n25), .Q(
        READ_DataOUT[4]) );
  DFFRHQX1 READ_DataOUT_reg_3_ ( .D(READ_DATA[3]), .CK(clk), .RN(n2), .Q(
        READ_DataOUT[3]) );
  DFFRHQX1 READ_DataOUT_reg_2_ ( .D(READ_DATA[2]), .CK(clk), .RN(n25), .Q(
        READ_DataOUT[2]) );
  DFFRHQX1 READ_DataOUT_reg_1_ ( .D(READ_DATA[1]), .CK(clk), .RN(n2), .Q(
        READ_DataOUT[1]) );
  DFFRHQX1 READ_DataOUT_reg_0_ ( .D(READ_DATA[0]), .CK(clk), .RN(n25), .Q(
        READ_DataOUT[0]) );
  DFFRHQX1 ADDRESS_OUT_reg_15_ ( .D(ADDRESS[15]), .CK(clk), .RN(n2), .Q(
        ADDRESS_OUT[15]) );
  DFFRHQX1 ADDRESS_OUT_reg_14_ ( .D(ADDRESS[14]), .CK(clk), .RN(n2), .Q(
        ADDRESS_OUT[14]) );
  DFFRHQX1 ADDRESS_OUT_reg_13_ ( .D(ADDRESS[13]), .CK(clk), .RN(n2), .Q(
        ADDRESS_OUT[13]) );
  DFFRHQX1 ADDRESS_OUT_reg_12_ ( .D(ADDRESS[12]), .CK(clk), .RN(n2), .Q(
        ADDRESS_OUT[12]) );
  DFFRHQX1 ADDRESS_OUT_reg_11_ ( .D(ADDRESS[11]), .CK(clk), .RN(n2), .Q(
        ADDRESS_OUT[11]) );
  DFFRHQX1 ADDRESS_OUT_reg_10_ ( .D(ADDRESS[10]), .CK(clk), .RN(n2), .Q(
        ADDRESS_OUT[10]) );
  DFFRHQX1 ADDRESS_OUT_reg_9_ ( .D(ADDRESS[9]), .CK(clk), .RN(n2), .Q(
        ADDRESS_OUT[9]) );
  DFFRHQX1 ADDRESS_OUT_reg_8_ ( .D(ADDRESS[8]), .CK(clk), .RN(n2), .Q(
        ADDRESS_OUT[8]) );
  DFFRHQX1 ADDRESS_OUT_reg_7_ ( .D(ADDRESS[7]), .CK(clk), .RN(n2), .Q(
        ADDRESS_OUT[7]) );
  DFFRHQX1 ADDRESS_OUT_reg_6_ ( .D(ADDRESS[6]), .CK(clk), .RN(n2), .Q(
        ADDRESS_OUT[6]) );
  DFFRHQX1 ADDRESS_OUT_reg_5_ ( .D(ADDRESS[5]), .CK(clk), .RN(n2), .Q(
        ADDRESS_OUT[5]) );
  DFFRHQX1 ADDRESS_OUT_reg_4_ ( .D(ADDRESS[4]), .CK(clk), .RN(n2), .Q(
        ADDRESS_OUT[4]) );
  DFFRHQX1 ADDRESS_OUT_reg_3_ ( .D(ADDRESS[3]), .CK(clk), .RN(n2), .Q(
        ADDRESS_OUT[3]) );
  DFFRHQX1 ADDRESS_OUT_reg_2_ ( .D(ADDRESS[2]), .CK(clk), .RN(n25), .Q(
        ADDRESS_OUT[2]) );
  DFFRHQX1 ADDRESS_OUT_reg_1_ ( .D(ADDRESS[1]), .CK(clk), .RN(n25), .Q(
        ADDRESS_OUT[1]) );
  DFFRHQX1 ADDRESS_OUT_reg_0_ ( .D(ADDRESS[0]), .CK(clk), .RN(n25), .Q(
        ADDRESS_OUT[0]) );
  DFFRHQX1 RegWrite_out_reg ( .D(RegWrite), .CK(clk), .RN(n25), .Q(
        RegWrite_out) );
  DFFRHQX1 MemtoReg_out_reg ( .D(MemtoReg), .CK(clk), .RN(n25), .Q(n26) );
  DFFRHQX1 WRITE_RegOUT_reg_4_ ( .D(WRITE_REG[4]), .CK(clk), .RN(n25), .Q(
        WRITE_RegOUT[4]) );
  DFFRHQX1 WRITE_RegOUT_reg_3_ ( .D(WRITE_REG[3]), .CK(clk), .RN(n2), .Q(
        WRITE_RegOUT[3]) );
  DFFRHQX1 WRITE_RegOUT_reg_0_ ( .D(WRITE_REG[0]), .CK(clk), .RN(n25), .Q(
        WRITE_RegOUT[0]) );
  DFFRHQX1 WRITE_RegOUT_reg_1_ ( .D(WRITE_REG[1]), .CK(clk), .RN(n2), .Q(
        WRITE_RegOUT[1]) );
  DFFRHQX1 WRITE_RegOUT_reg_2_ ( .D(WRITE_REG[2]), .CK(clk), .RN(n25), .Q(
        WRITE_RegOUT[2]) );
  INVX1 U3 ( .A(rst), .Y(n2) );
  INVX1 U4 ( .A(n24), .Y(MemtoReg_out) );
  INVX1 U5 ( .A(n1), .Y(n24) );
  INVX1 U6 ( .A(n1), .Y(n20) );
  INVX1 U7 ( .A(n1), .Y(n23) );
  INVX1 U8 ( .A(n1), .Y(n22) );
  INVX1 U9 ( .A(n1), .Y(n21) );
  BUFX3 U10 ( .A(n26), .Y(n1) );
  INVX1 U11 ( .A(n18), .Y(write_data[0]) );
  AOI22X1 U12 ( .A0(ADDRESS_OUT[0]), .A1(n23), .B0(READ_DataOUT[0]), .B1(
        MemtoReg_out), .Y(n18) );
  INVX1 U13 ( .A(n11), .Y(write_data[1]) );
  AOI22X1 U14 ( .A0(ADDRESS_OUT[1]), .A1(n21), .B0(READ_DataOUT[1]), .B1(
        MemtoReg_out), .Y(n11) );
  INVX1 U15 ( .A(n3), .Y(write_data[9]) );
  AOI22X1 U16 ( .A0(ADDRESS_OUT[9]), .A1(n22), .B0(READ_DataOUT[9]), .B1(
        MemtoReg_out), .Y(n3) );
  INVX1 U17 ( .A(n10), .Y(write_data[2]) );
  AOI22X1 U18 ( .A0(ADDRESS_OUT[2]), .A1(n20), .B0(READ_DataOUT[2]), .B1(
        MemtoReg_out), .Y(n10) );
  INVX1 U19 ( .A(n9), .Y(write_data[3]) );
  AOI22X1 U20 ( .A0(ADDRESS_OUT[3]), .A1(n20), .B0(READ_DataOUT[3]), .B1(
        MemtoReg_out), .Y(n9) );
  INVX1 U21 ( .A(n8), .Y(write_data[4]) );
  AOI22X1 U22 ( .A0(ADDRESS_OUT[4]), .A1(n22), .B0(READ_DataOUT[4]), .B1(
        MemtoReg_out), .Y(n8) );
  INVX1 U23 ( .A(n7), .Y(write_data[5]) );
  AOI22X1 U24 ( .A0(ADDRESS_OUT[5]), .A1(n22), .B0(READ_DataOUT[5]), .B1(
        MemtoReg_out), .Y(n7) );
  INVX1 U25 ( .A(n6), .Y(write_data[6]) );
  AOI22X1 U26 ( .A0(ADDRESS_OUT[6]), .A1(n22), .B0(READ_DataOUT[6]), .B1(
        MemtoReg_out), .Y(n6) );
  INVX1 U27 ( .A(n5), .Y(write_data[7]) );
  AOI22X1 U28 ( .A0(ADDRESS_OUT[7]), .A1(n22), .B0(READ_DataOUT[7]), .B1(
        MemtoReg_out), .Y(n5) );
  INVX1 U29 ( .A(n4), .Y(write_data[8]) );
  AOI22X1 U30 ( .A0(ADDRESS_OUT[8]), .A1(n22), .B0(READ_DataOUT[8]), .B1(
        MemtoReg_out), .Y(n4) );
  INVX1 U31 ( .A(n17), .Y(write_data[10]) );
  AOI22X1 U32 ( .A0(ADDRESS_OUT[10]), .A1(n23), .B0(READ_DataOUT[10]), .B1(
        MemtoReg_out), .Y(n17) );
  INVX1 U33 ( .A(n16), .Y(write_data[11]) );
  AOI22X1 U34 ( .A0(ADDRESS_OUT[11]), .A1(n22), .B0(READ_DataOUT[11]), .B1(
        MemtoReg_out), .Y(n16) );
  INVX1 U35 ( .A(n15), .Y(write_data[12]) );
  AOI22X1 U36 ( .A0(ADDRESS_OUT[12]), .A1(n22), .B0(READ_DataOUT[12]), .B1(
        MemtoReg_out), .Y(n15) );
  INVX1 U37 ( .A(n14), .Y(write_data[13]) );
  AOI22X1 U38 ( .A0(ADDRESS_OUT[13]), .A1(n22), .B0(READ_DataOUT[13]), .B1(
        MemtoReg_out), .Y(n14) );
  INVX1 U39 ( .A(n13), .Y(write_data[14]) );
  AOI22X1 U40 ( .A0(ADDRESS_OUT[14]), .A1(n22), .B0(READ_DataOUT[14]), .B1(
        MemtoReg_out), .Y(n13) );
  INVX1 U41 ( .A(n12), .Y(write_data[15]) );
  AOI22X1 U42 ( .A0(ADDRESS_OUT[15]), .A1(n21), .B0(READ_DataOUT[15]), .B1(
        MemtoReg_out), .Y(n12) );
  INVX1 U43 ( .A(rst), .Y(n25) );
endmodule


module Forwarding ( Ai, Bi, EX_MEMRegRD, EXE_MEMRegWRITE, MEM_WBRegRD, 
        MEM_WBWRITE, ID_RS, ID_RT );
  output [1:0] Ai;
  output [1:0] Bi;
  input [4:0] EX_MEMRegRD;
  input [4:0] MEM_WBRegRD;
  input [4:0] ID_RS;
  input [4:0] ID_RT;
  input EXE_MEMRegWRITE, MEM_WBWRITE;
  wire   n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34,
         n35, n37, n1, n2;

  INVX1 U1 ( .A(n22), .Y(Ai[1]) );
  INVX1 U2 ( .A(n6), .Y(Bi[1]) );
  NOR4BX1 U3 ( .AN(n19), .B(n20), .C(n21), .D(n2), .Y(n18) );
  XOR2X1 U4 ( .A(ID_RT[4]), .B(EX_MEMRegRD[4]), .Y(n20) );
  XOR2X1 U5 ( .A(ID_RT[0]), .B(EX_MEMRegRD[0]), .Y(n21) );
  NAND4X1 U6 ( .A(n30), .B(n31), .C(n32), .D(n33), .Y(n22) );
  XNOR2X1 U7 ( .A(EX_MEMRegRD[1]), .B(ID_RS[1]), .Y(n30) );
  XNOR2X1 U8 ( .A(EX_MEMRegRD[3]), .B(ID_RS[3]), .Y(n32) );
  XNOR2X1 U9 ( .A(EX_MEMRegRD[2]), .B(ID_RS[2]), .Y(n31) );
  NAND4X1 U10 ( .A(n15), .B(n16), .C(n17), .D(n18), .Y(n6) );
  XNOR2X1 U11 ( .A(EX_MEMRegRD[2]), .B(ID_RT[2]), .Y(n15) );
  XNOR2X1 U12 ( .A(EX_MEMRegRD[3]), .B(ID_RT[3]), .Y(n17) );
  XNOR2X1 U13 ( .A(EX_MEMRegRD[1]), .B(ID_RT[1]), .Y(n16) );
  NOR2X1 U14 ( .A(n23), .B(n24), .Y(Ai[0]) );
  NAND4X1 U15 ( .A(n25), .B(n26), .C(n27), .D(n28), .Y(n24) );
  NAND4X1 U16 ( .A(n29), .B(MEM_WBWRITE), .C(n14), .D(n22), .Y(n23) );
  XNOR2X1 U17 ( .A(ID_RS[3]), .B(MEM_WBRegRD[3]), .Y(n26) );
  NOR2X1 U18 ( .A(n7), .B(n8), .Y(Bi[0]) );
  NAND4X1 U19 ( .A(n9), .B(n10), .C(n11), .D(n12), .Y(n8) );
  NAND4X1 U20 ( .A(n13), .B(MEM_WBWRITE), .C(n14), .D(n6), .Y(n7) );
  XNOR2X1 U21 ( .A(ID_RT[3]), .B(MEM_WBRegRD[3]), .Y(n10) );
  OR4X2 U22 ( .A(n37), .B(MEM_WBRegRD[0]), .C(MEM_WBRegRD[1]), .D(
        MEM_WBRegRD[2]), .Y(n14) );
  OR2X2 U23 ( .A(MEM_WBRegRD[4]), .B(MEM_WBRegRD[3]), .Y(n37) );
  OR4X2 U24 ( .A(EX_MEMRegRD[0]), .B(EX_MEMRegRD[1]), .C(n1), .D(
        EX_MEMRegRD[2]), .Y(n19) );
  OR2X2 U25 ( .A(EX_MEMRegRD[4]), .B(EX_MEMRegRD[3]), .Y(n1) );
  XNOR2X1 U26 ( .A(ID_RT[0]), .B(MEM_WBRegRD[0]), .Y(n12) );
  XNOR2X1 U27 ( .A(ID_RS[0]), .B(MEM_WBRegRD[0]), .Y(n28) );
  XNOR2X1 U28 ( .A(ID_RT[1]), .B(MEM_WBRegRD[1]), .Y(n11) );
  XNOR2X1 U29 ( .A(ID_RS[1]), .B(MEM_WBRegRD[1]), .Y(n27) );
  XNOR2X1 U30 ( .A(ID_RT[4]), .B(MEM_WBRegRD[4]), .Y(n13) );
  XNOR2X1 U31 ( .A(ID_RT[2]), .B(MEM_WBRegRD[2]), .Y(n9) );
  XNOR2X1 U32 ( .A(ID_RS[2]), .B(MEM_WBRegRD[2]), .Y(n25) );
  NOR4BX1 U33 ( .AN(n19), .B(n34), .C(n35), .D(n2), .Y(n33) );
  XOR2X1 U34 ( .A(ID_RS[4]), .B(EX_MEMRegRD[4]), .Y(n34) );
  XOR2X1 U35 ( .A(ID_RS[0]), .B(EX_MEMRegRD[0]), .Y(n35) );
  XNOR2X1 U36 ( .A(ID_RS[4]), .B(MEM_WBRegRD[4]), .Y(n29) );
  INVX1 U37 ( .A(EXE_MEMRegWRITE), .Y(n2) );
endmodule


module Hazard_detector ( ID_Rt, IF_Rs, IF_Rt, mem_read, stall );
  input [4:0] ID_Rt;
  input [4:0] IF_Rs;
  input [4:0] IF_Rt;
  input mem_read;
  output stall;
  wire   n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21;

  NOR3X1 U2 ( .A(n19), .B(n20), .C(n21), .Y(n12) );
  XOR2X1 U3 ( .A(IF_Rt[4]), .B(ID_Rt[4]), .Y(n21) );
  XOR2X1 U4 ( .A(IF_Rt[0]), .B(ID_Rt[0]), .Y(n19) );
  XOR2X1 U5 ( .A(IF_Rt[1]), .B(ID_Rt[1]), .Y(n20) );
  NOR3X1 U6 ( .A(n16), .B(n17), .C(n18), .Y(n15) );
  XOR2X1 U7 ( .A(IF_Rs[4]), .B(ID_Rt[4]), .Y(n18) );
  XOR2X1 U8 ( .A(IF_Rs[0]), .B(ID_Rt[0]), .Y(n16) );
  XOR2X1 U9 ( .A(IF_Rs[1]), .B(ID_Rt[1]), .Y(n17) );
  NOR2BX1 U10 ( .AN(mem_read), .B(n9), .Y(stall) );
  AOI33X1 U11 ( .A0(n10), .A1(n11), .A2(n12), .B0(n13), .B1(n14), .B2(n15), 
        .Y(n9) );
  XNOR2X1 U12 ( .A(ID_Rt[2]), .B(IF_Rt[2]), .Y(n10) );
  XNOR2X1 U13 ( .A(ID_Rt[3]), .B(IF_Rt[3]), .Y(n11) );
  XNOR2X1 U14 ( .A(ID_Rt[3]), .B(IF_Rs[3]), .Y(n14) );
  XNOR2X1 U15 ( .A(ID_Rt[2]), .B(IF_Rs[2]), .Y(n13) );
endmodule


module PL_CPU ( clk, rst, PC0, PC1, PC2, PC_INST, IF_Instruction, 
        MEM_ReadDataOUT, MEM_ADDRIN, MEM_WriteData, MEM_MemRead, MEM_MemWrite
 );
  output [15:0] PC_INST;
  input [31:0] IF_Instruction;
  input [15:0] MEM_ReadDataOUT;
  output [15:0] MEM_ADDRIN;
  output [15:0] MEM_WriteData;
  input clk, rst;
  output PC0, PC1, PC2, MEM_MemRead, MEM_MemWrite;
  wire   Branch_taken, Stall, ID_MemtoRegIN, ID_RegWriteIN, ID_RegWrite,
         ID_MemtoReg, ID_Branch, ID_MemRead, ID_MemWrite, ID_RegDst, ID_ALUSrc,
         EX_RegWrite, EX_MemtoReg, EX_Branch, EX_MemRead, EX_MemWrite,
         EX_RegDst, EX_ALUSrc, EX_Zero, MEM_RegWrite, MEM_MemtoReg, MEM_Branch,
         MEM_ZERO, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16;
  wire   [15:0] last_inst;
  wire   [31:0] ID_instruction;
  wire   [4:0] ID_WriteRegADDR;
  wire   [15:0] ID_ALUresult;
  wire   [15:0] ID_ReadDataIN;
  wire   [1:0] ID_ALUop;
  wire   [15:0] ID_ReadData1;
  wire   [15:0] ID_ReadData2;
  wire   [31:0] ID_SignExtend;
  wire   [4:0] ID_INS25to21;
  wire   [4:0] ID_INS20to16;
  wire   [4:0] ID_INS15to11;
  wire   [4:0] ID_INS10to6;
  wire   [5:0] ID_Opcode;
  wire   [31:0] EX_SignExtend;
  wire   [4:0] EX_RsIN;
  wire   [4:0] EX_RtIN;
  wire   [4:0] EX_RdIN;
  wire   [4:0] EX_SHAMTIN;
  wire   [15:0] EX_ReadData1;
  wire   [15:0] EX_ReadData2;
  wire   [1:0] EX_ALUop;
  wire   [5:0] EX_Opcode;
  wire   [4:0] EX_WriteRegOut;
  wire   [15:0] EX_WriteDataOUT;
  wire   [15:0] EX_ALUResult;
  wire   [15:0] WB_WriteData;
  wire   [1:0] ForwardA;
  wire   [1:0] ForwardB;
  wire   [4:0] MEM_WriteREG;

  Ifetch u_Ifetch ( .clk(clk), .rst(rst), .PCSrc(Branch_taken), .stall(Stall), 
        .Instruction(IF_Instruction), .PC({PC_INST[15:3], n14, n15, n16}), 
        .Last_Inst(last_inst) );
  IF_IDreg u_stage1 ( .clk(clk), .rst(rst), .stall(Stall), .INST_RegIN(
        IF_Instruction), .INST_RegOUT(ID_instruction), .Branch_taken(
        Branch_taken) );
  Idecode u_Idecode ( .clk(clk), .rst(rst), .WRITE_RegADDR(ID_WriteRegADDR), 
        .Instruction({ID_instruction[31:23], n12, n10, ID_instruction[20:18], 
        n8, n6, ID_instruction[15:0]}), .MemtoReg_in(n4), .RegWrite_in(
        ID_RegWriteIN), .ALU_result(ID_ALUresult), .read_datain(ID_ReadDataIN), 
        .RegWrite(ID_RegWrite), .MemtoReg(ID_MemtoReg), .Branch(ID_Branch), 
        .MemRead(ID_MemRead), .MemWrite(ID_MemWrite), .RegDst(ID_RegDst), 
        .ALUop(ID_ALUop), .ALUSrc(ID_ALUSrc), .read_data1(ID_ReadData1), 
        .read_data2(ID_ReadData2), .Sign_extend(ID_SignExtend), .INS_25to21(
        ID_INS25to21), .INS_20to16(ID_INS20to16), .INS_15to11(ID_INS15to11), 
        .INS_10to6(ID_INS10to6), .stall(Stall), .branch_taken(Branch_taken), 
        .Opcode(ID_Opcode) );
  ID_EXreg u_stage2 ( .clk(clk), .rst(rst), .RS_ADDRIN(ID_INS25to21), 
        .RT_ADDRIN(ID_INS20to16), .RD_ADDRIN(ID_INS15to11), .SHAME_ADDRIN(
        ID_INS10to6), .RS_IN(ID_ReadData1), .RT_IN(ID_ReadData2), .OFFSET_IN(
        ID_SignExtend), .RegWrite(ID_RegWrite), .MemtoReg(ID_MemtoReg), 
        .Branch(ID_Branch), .MemRead(ID_MemRead), .MemWrite(ID_MemWrite), 
        .RegDst(ID_RegDst), .ALUSrc(ID_ALUSrc), .ALUop(ID_ALUop), .RS_ADDROUT(
        EX_RsIN), .RT_ADDROUT(EX_RtIN), .RD_ADDROUT(EX_RdIN), .SHAMT_ADDROUT(
        EX_SHAMTIN), .RS_OUT(EX_ReadData1), .RT_OUT(EX_ReadData2), 
        .OFFSET_OUT(EX_SignExtend), .ALUop_out(EX_ALUop), .RegWrite_out(
        EX_RegWrite), .MemtoReg_out(EX_MemtoReg), .Branch_out(EX_Branch), 
        .MemRead_out(EX_MemRead), .MemWrite_out(EX_MemWrite), .RegDst_out(
        EX_RegDst), .ALUSrc_out(EX_ALUSrc), .Opcode_in(ID_Opcode), 
        .Opcode_out(EX_Opcode), .stall(Stall), .branch_taken(Branch_taken) );
  Execute u_Execute ( .Read_data1(EX_ReadData1), .Read_data2(EX_ReadData2), 
        .Sign_extend(EX_SignExtend), .RT_IN(EX_RtIN), .RD_IN(EX_RdIN), .ALUop(
        EX_ALUop), .ALUSrc(EX_ALUSrc), .RegDst(EX_RegDst), .clk(clk), .rst(rst), .Zero(EX_Zero), .ALU_Result(EX_ALUResult), .Write_RegOUT(EX_WriteRegOut), 
        .Write_DataOUT(EX_WriteDataOUT), .EX_MEMALUResult(MEM_ADDRIN), 
        .MEM_WBWriteDATA(WB_WriteData), .EXE_RS(EX_RsIN), .EXE_SHAMT(
        EX_SHAMTIN), .Ai(ForwardA), .Bi(ForwardB), .Opcode(EX_Opcode), 
        .branch_taken(Branch_taken), .Last_inst(last_inst), .Branch(EX_Branch)
         );
  EX_MEMreg u_stage3 ( .clk(clk), .rst(rst), .RTD_ADDRIN(EX_WriteRegOut), 
        .ALU_ResIN(EX_ALUResult), .RT_IN(EX_WriteDataOUT), .RegWrite(
        EX_RegWrite), .MemtoReg(EX_MemtoReg), .Branch(EX_Branch), .MemRead(
        EX_MemRead), .MemWrite(EX_MemWrite), .ZERO_IN(EX_Zero), .RTD_ADDROUT(
        MEM_WriteREG), .ALU_ResOUT(MEM_ADDRIN), .RT_OUT(MEM_WriteData), 
        .RegWrite_out(MEM_RegWrite), .MemtoReg_out(MEM_MemtoReg), .Branch_out(
        MEM_Branch), .MemRead_out(MEM_MemRead), .MemWrite_out(MEM_MemWrite), 
        .ZERO_OUT(MEM_ZERO) );
  memory_access u_ACCESS ( .clk(clk), .reset(rst), .Branch(MEM_Branch), .ZERO(
        MEM_ZERO) );
  MEM_WBreg u_stage4 ( .clk(clk), .rst(rst), .RegWrite(MEM_RegWrite), 
        .MemtoReg(MEM_MemtoReg), .WRITE_REG(MEM_WriteREG), .READ_DATA(
        MEM_ReadDataOUT), .ADDRESS(MEM_ADDRIN), .RegWrite_out(ID_RegWriteIN), 
        .MemtoReg_out(ID_MemtoRegIN), .WRITE_RegOUT(ID_WriteRegADDR), 
        .READ_DataOUT(ID_ReadDataIN), .ADDRESS_OUT(ID_ALUresult), .write_data(
        WB_WriteData) );
  Forwarding u_Forwarding ( .Ai(ForwardA), .Bi(ForwardB), .EX_MEMRegRD(
        MEM_WriteREG), .EXE_MEMRegWRITE(MEM_RegWrite), .MEM_WBRegRD(
        ID_WriteRegADDR), .MEM_WBWRITE(ID_RegWriteIN), .ID_RS(EX_RsIN), 
        .ID_RT(EX_RtIN) );
  Hazard_detector u_Hazard ( .ID_Rt(EX_RtIN), .IF_Rs({ID_instruction[25:23], 
        n12, n10}), .IF_Rt({ID_instruction[20:18], n8, n6}), .mem_read(
        EX_MemRead), .stall(Stall) );
  INVX1 U1 ( .A(n5), .Y(n4) );
  INVX1 U2 ( .A(ID_MemtoRegIN), .Y(n5) );
  INVX1 U3 ( .A(n13), .Y(n12) );
  INVX1 U4 ( .A(ID_instruction[22]), .Y(n13) );
  INVX1 U5 ( .A(n11), .Y(n10) );
  INVX1 U6 ( .A(ID_instruction[21]), .Y(n11) );
  INVX1 U7 ( .A(n9), .Y(n8) );
  INVX1 U8 ( .A(ID_instruction[17]), .Y(n9) );
  INVX1 U9 ( .A(n7), .Y(n6) );
  INVX1 U10 ( .A(ID_instruction[16]), .Y(n7) );
  BUFX3 U11 ( .A(PC0), .Y(PC_INST[2]) );
  BUFX3 U12 ( .A(PC0), .Y(PC_INST[1]) );
  BUFX3 U13 ( .A(PC0), .Y(PC_INST[0]) );
  AND3X1 U14 ( .A(n15), .B(n16), .C(n14), .Y(PC0) );
endmodule

