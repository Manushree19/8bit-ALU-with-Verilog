// AND
module myAND (F, A, B);
  input A, B;
  output wire F;
  assign F = A & B;
endmodule

// OR
module myOR (F, A, B);
  input A, B;
  output wire F;
  assign F = A | B;
endmodule

// NOR
module myNOR2 (F, A, B);
  input A, B;
  output wire F;
  assign F = ~(A | B);
endmodule

// INV
module myINV (F, A);
  input A;
  output wire F;
  assign F = ~A;
endmodule

// NAND
module myNAND (F, A, B);
  input A, B;
  output wire F;
  assign F = ~(A & B);
endmodule

// XOR
module myXOR(F, A, B);
  input A, B;
  output wire F;
  assign F = A ^ B;
endmodule

// HALF ADDER
module myHALFADDER(Sum, Carry, A, B);
  input A, B;
  output wire Sum, Carry;
  assign Sum = A ^ B;
  assign Carry = A & B;
endmodule

// Full Adder using two Half Adders and OR gate
module myFULLADDER(Sum, Cout, A, B, Cin);
  input A, B, Cin;
  output wire Sum, Cout;
  wire tempSum1, tempCarry1, tempCarry2;
  myHALFADDER inst1(tempSum1, tempCarry1, A, B);
  myHALFADDER inst2(Sum, tempCarry2, tempSum1, Cin);
  myOR inst3(Cout, tempCarry1, tempCarry2);
endmodule

// 8-bit Multiplier
module myMULT4(A, B, P);
  input [7:0] A, B;
  output [15:0] P;

  // Internal wires for partial products and carries
  wire C1, C2, C3, C4, C5, C6, C7, C8, C9, C10;
  wire C11, C12, C13, C14, C15, C16, C17, C18, C19, C20;
  wire C21, C22, C23, C24, C25, C26, C27, C28, C29, C30;
  wire C31, C32, C33, C34, C35, C36, C37, C38, C39, C40;
  wire C41, C42, C43, C44, C45, C46, C47, C48, C49, C50;
  wire C51, C52, C53, C54, C55, C56;

  
  // Temporary wires for intermediate values
  wire temp1, temp2, temp3, temp4, temp5, temp6;
  wire temp7, temp8, temp9, temp10, temp11;
  wire temp12, temp13, temp14, temp15, temp16;
  wire temp17, temp18, temp19, temp20, temp21;
  wire temp22, temp23, temp24, temp25, temp26;
  wire temp27, temp28, temp29, temp30, temp31;
  wire temp32, temp33, temp34, temp35, temp36;
  wire temp37, temp38, temp39, temp40, temp41;
  wire temp42, temp43, temp44, temp45, temp46;
  wire temp47, temp48, temp49, temp50, temp51;
  wire temp52, temp53, temp54, temp55, temp56;
  wire temp57, temp58, temp59, temp60, temp61;
  wire temp62, temp63, temp64, temp65, temp66;
  wire temp67, temp68, temp69, temp70, temp71;
  wire temp72, temp73, temp74, temp75, temp76;
  wire temp77, temp78, temp79, temp80, temp81;
  wire temp82, temp83, temp84, temp85, temp86;
  wire temp87, temp88, temp89, temp90, temp91;
  wire temp92, temp93, temp94, temp95, temp96;
  wire temp97, temp98, temp99, temp100, temp101;
  wire temp102, temp103, temp104;

  // P0 calculation (A0 * B0)
  myAND inst1(P[0], A[0], B[0]);

  // P1 calculation
  myAND inst2(temp1, A[1], B[0]);
  myAND inst3(temp2, A[0], B[1]);
  myHALFADDER inst4(P[1], C1, temp1, temp2);

  // P2 calculation
  myAND inst5(temp3, A[2], B[0]);
  myAND inst6(temp4, A[1], B[1]);
  myFULLADDER inst7(temp5, C2, temp3, temp4, C1);
  myAND inst8(temp6, A[0], B[2]);
  myHALFADDER inst9(P[2], C3, temp5, temp6);

  // P3 calculation
  myAND inst10(temp7, A[3], B[0]);
  myAND inst11(temp8, A[2], B[1]);
  myFULLADDER inst12(temp9, C4, temp7, temp8, C2);
  myAND inst13(temp10, A[1], B[2]);
  myFULLADDER inst14(temp11,C5,temp10,temp9,C3);
  myAND inst15(temp12, A[0], B[3]);
  myHALFADDER inst16(P[3],C6,temp12,temp11);
 

  // P4 calculation
  myAND inst17(temp13, A[3], B[1]);
  myAND inst18(temp14,A[4],B[0]);
  myFULLADDER inst19(temp15, C7, temp13,temp14, C4);
  myAND inst20(temp16, A[2], B[2]);
  myFULLADDER inst21(temp17, C8, temp16, temp15, C5);
  myAND inst22(temp18, A[1], B[3]);
 
  myFULLADDER inst23(temp19, C9, temp17, C6, temp18);
  myAND inst24(temp20, A[0], B[4]);
 
  myHALFADDER inst25(P[4], C10, temp20, temp19);

  // P5 calculation
  myAND inst26(temp21, A[5], B[0]);
  myAND inst27(temp22, A[4], B[1]);
  myFULLADDER inst28(temp23, C11, temp21, temp22, C7);
  myAND inst29(temp24, A[2], B[3]);
  myFULLADDER inst30(temp25, C12, temp24, temp23, C8);
  myAND inst31(temp26, A[2], B[3]);
  myFULLADDER inst32(temp27, C13, temp25, temp26, C9);
  myAND inst33(temp28, A[1], B[4]);
  myFULLADDER inst34(temp29, C14, temp28, temp27, C10);
  myAND inst35(temp30,A[0],B[5]);
  myHALFADDER inst36(P[5],C15,temp30,temp29);
  
  // P6 calculation
  myAND inst37(temp31, A[6], B[0]);
  myAND inst38(temp32, A[5], B[1]);
  myFULLADDER inst39(temp33,C16, temp31, temp32, C11);
  myAND inst40(temp34, A[4], B[2]);
  myFULLADDER inst41(temp35,C17, temp34, temp33, C12);
  myAND inst42(temp36, A[3], B[3]);
  myFULLADDER inst43(temp37,C18, temp36, temp35, C13);
  myAND inst44(temp38, A[2], B[4]);
  myFULLADDER inst45(temp39,C19, temp37, temp36, C14);
  myAND inst46(temp40, A[1], B[5]);
  myFULLADDER inst47(temp41,C20, temp40, temp39, C15);
  myAND inst48(temp42, A[0], B[6]);
  myHALFADDER inst49(P[6],C21,temp42,temp41);

  // P7 calculation 
  myAND inst50(temp43, A[7], B[0]);
  myAND inst51(temp44, A[6], B[1]);
  myFULLADDER inst52(temp45,C22, temp43, temp44, C16);
  myAND inst53(temp46, A[5], B[2]);
  myFULLADDER inst54(temp47,C23, temp45, temp46, C17);
  myAND inst55(temp48,A[4], B[3]);
  myFULLADDER inst56(temp49,C24, temp47, temp48, C18);
  myAND inst57(temp50, A[3], B[4]);
  myFULLADDER inst58(temp51,C25, temp49, temp50, C19);
  myAND inst59(temp52, A[2], B[5]);
  myFULLADDER inst60(temp53,C26, temp51, temp52, C20);
  myAND inst61(temp54, A[1], B[6]);
  myFULLADDER inst62(temp55,C27, temp53, temp54, C21);
  myAND inst63(temp55, A[0], B[7]);
  myHALFADDER inst64(P[7],C28,temp55,temp54);
  
  // P8 calculation 
  myAND inst65(temp56, A[7], B[1]);
  myHALFADDER inst66(temp57,C29,temp56,C22);
  myAND inst67(temp58, A[6], B[2]);
  myFULLADDER inst68(temp59,C30, temp57, temp58, C23);
  myAND inst69(temp60, A[5], B[3]);
  myFULLADDER inst70(temp61,C31, temp59, temp60, C24);
  myAND inst71(temp62, A[4], B[4]);
  myFULLADDER inst72(temp63,C32, temp61, temp62, C25);
  myAND inst73(temp64, A[3], B[5]);
  myFULLADDER inst74(temp65,C33, temp63, temp64, C26);
  myAND inst75(temp66, A[2], B[6]);
  myFULLADDER inst76(temp67,C34, temp65, temp66, C27);
  myAND inst77(temp68, A[1], B[7]);
  myFULLADDER inst78(P[8],C35, temp67, temp68, C28);
  
  // P9 calculation 
  myAND inst79(temp69, A[7], B[2]);
  myFULLADDER inst80(temp70,C36, temp69, C30, C29);
  myAND inst81(temp71, A[6], B[3]);
  myFULLADDER inst82(temp72,C37, temp71, temp70, C31);
  myAND inst83(temp73, A[5], B[4]);
  myFULLADDER inst84(temp74,C38, temp72, temp73, C32);
  myAND inst85(temp75, A[4], B[5]);
  myFULLADDER inst86(temp76,C39, temp74, temp75, C33);
  myAND inst87(temp77, A[3], B[6]);
  myFULLADDER inst88(temp78,C40, temp76, temp77, C34);
  myAND inst89(temp79, A[2], B[7]);
  myFULLADDER inst90(P[9],C41, temp78, temp79, C35);
  
  // P10 calculation 
  myAND inst91(temp80, A[7], B[3]);
  myFULLADDER inst92(temp81,C42, temp80, C36, C37);
  myAND inst93(temp82, A[6], B[4]);
  myFULLADDER inst94(temp83,C43, temp81, temp80, C38);
  myAND inst95(temp84, A[5], B[5]);
  myFULLADDER inst96(temp85,C44, temp83, temp84, C39);
  myAND inst97(temp86, A[4], B[6]);
  myFULLADDER inst98(temp87,C45, temp85, temp86, C40);
  myAND inst99(temp88, A[3], B[7]);
  myFULLADDER inst100(P[10],C46, temp87, temp88, C41);
  
  // P11 calculation 
  myAND inst101(temp89, A[7], B[4]);
  myFULLADDER inst102(temp90,C47, temp89, C42, C43);
  myAND inst103(temp91, A[6], B[5]);
  myFULLADDER inst104(temp92,C48, temp90, temp91, C44);
  myAND inst105(temp93, A[5], B[6]);
  myFULLADDER inst106(temp94,C49, temp92, temp93, C45);
  myAND inst107(temp95, A[4], B[7]);
  myFULLADDER inst108(P[11],C50, temp94, temp95, C46);
  
  // P12 calculation 
  myAND inst109(temp96, A[7], B[5]);
  myFULLADDER inst110(temp97,C51, temp96, C47, C48);
  myAND inst111(temp98, A[6], B[6]);
  myFULLADDER inst112(temp99,C52, temp97, temp98, C49);
  myAND inst113(temp100, A[5], B[7]);
  myFULLADDER inst114(P[12],C53, temp99, temp100, C50);
  
  // P13 calculation 
  myAND inst115(temp101, A[7], B[6]);
  myFULLADDER inst116(temp102,C54, temp101, C51, C52);
  myAND inst117(temp103, A[6], B[7]);
  myFULLADDER inst118(P[13],C55, temp102, temp103, C53);
  
  // P14 calculation 
  myAND inst119(temp104, A[7], B[7]);
  myFULLADDER inst120(P[14],C56, temp104, C54, C55);
  
  // P15 calculation 
  assign P[15] = C56;
  
  
endmodule
//8-bit adder
module myAdder8(A,B,S);
  input [7:0] A,B;
  output [8:0] S;
  
  // Internal wires for partial sum and carries
  wire C0,C1,C2,C3,C4,C5,C6,C7;
  
  //S0 calculation
  myHALFADDER inst1(S[0],C0,A[0],B[0]);
  
  //S1 calculation
  myFULLADDER inst2(S[1],C1,A[1],B[1],C0);
  
  //S2 calculation
  myFULLADDER inst3(S[2],C2,A[2],B[2],C1);
  
  //S3 calculation
  myFULLADDER inst4(S[3],C3,A[3],B[3],C2);
  
  //S4 calculation
  myFULLADDER inst5(S[4],C4,A[4],B[4],C3);
  
  //S5 calculation
  myFULLADDER inst6(S[5],C5,A[5],B[5],C4);
  
  //S6 calculation
  myFULLADDER inst7(S[6],C6,A[6],B[6],C5);
  
  //S7 calculation
  myFULLADDER inst8(S[7],C7,A[7],B[7],C6);
  
  //S8 calculation
  assign S[8]=C7;
 
endmodule
module mySUBTRACTOR(A, B, D, is_negative);
  input [7:0] A, B;
  output reg [7:0] D;
  output reg is_negative;   // Flag to indicate if the result is negative

  wire [7:0] B_twos_complement;
  wire [8:0] temp_result;   // Use 9-bit to include carry-out
  wire carry_out;

  // Calculate the two's complement of B
  assign B_twos_complement = ~B + 1;

  // Perform the subtraction using an 8-bit adder (A + (-B))
  assign temp_result = A + B_twos_complement;
  assign carry_out = temp_result[8]; // Capture the carry-out from the addition

  always @(*) begin
    if (carry_out) begin
      // If carry-out is 1, result is positive, no need for two's complement
      D = temp_result[7:0];
      is_negative = 0;
    end else begin
      // If carry-out is 0, result is negative, take two's complement of D
      D = ~temp_result[7:0] + 1;
      is_negative = 1;
    end
  end
endmodule