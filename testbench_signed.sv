module complex_multiplier_tb;

  // Declare input and output signals as signed
  reg signed [7:0] r1, i1, r2, i2;  // 8-bit signed inputs for real and imaginary parts
  wire signed [15:0] real_out_mult, imag_out_mult;  // 16-bit signed outputs for multiplier
  wire signed [15:0] real_out_div, imag_out_div; // 16-bit signed outputs for divider
  wire signed [8:0] real_out_add, imag_out_add;     // 9-bit signed outputs for adder
  wire signed [7:0] real_out_sub, imag_out_sub;     // 8-bit signed outputs for subtractor
  wire is_real_neg, is_imag_neg;                    // Negative flags for subtraction
  wire [15:0] angle_r1, angle_r2;                  // 16-bit outputs for angles
  
  // Declare output signals for conjugate module
  wire signed [7:0] conj_r1, conj_i1, conj_r2, conj_i2;
  
  // Instantiate modules
  complex_multiplier uut_mult (
    .r1(r1), 
    .i1(i1), 
    .r2(r2), 
    .i2(i2), 
    .real_out(real_out_mult), 
    .imag_out(imag_out_mult)
  );

  complex_divider uut_div (
    .r1(r1), 
    .i1(i1), 
    .r2(r2), 
    .i2(i2), 
    .real_out(real_out_div), 
    .imag_out(imag_out_div)
  );

  complex_adder uut_add (
    .r1(r1), 
    .i1(i1), 
    .r2(r2), 
    .i2(i2), 
    .real_out(real_out_add), 
    .imag_out(imag_out_add)
  );

  complex_subtractor uut_sub (
    .r1(r1), 
    .i1(i1), 
    .r2(r2), 
    .i2(i2), 
    .real_out(real_out_sub), 
    .imag_out(imag_out_sub), 
    .is_real_negative(is_real_neg), 
    .is_imag_negative(is_imag_neg)
  );

  complex_conjugate uut_conjugate (
    .r1(r1), 
    .i1(i1), 
    .r2(r2), 
    .i2(i2), 
    .conj_r1(conj_r1), 
    .conj_i1(conj_i1), 
    .conj_r2(conj_r2), 
    .conj_i2(conj_i2)
  );

  complex_angle uut_angle (
    .r1(r1), 
    .i1(i1), 
    .r2(r2), 
    .i2(i2), 
    .angle_r1(angle_r1), 
    .angle_r2(angle_r2)
  );

  // Testbench logic
  initial begin
    r1 = 8'b00000101;  // Example value: 4
    i1 = 8'b00000101;  // Example value: 4
    r2 = 8'b00000101;  // Example value: 4
    i2 = 8'b00000101;  // Example value: 4

    #10;

     // Display results for addition
  $display("Addition: Real = %b (%0d), Imag = %b (%0d)", real_out_add, real_out_add, imag_out_add, imag_out_add);

  // Display results for subtraction
  $display("Subtraction: Real = %b (%0d) (Neg=%b), Imag = %b (%0d) (Neg=%b)", 
           real_out_sub, real_out_sub, is_real_neg, imag_out_sub, imag_out_sub, is_imag_neg);

  // Display results for multiplication
  $display("Multiplication: Real = %b (%0d), Imag = %b (%0d)", real_out_mult, real_out_mult, imag_out_mult, imag_out_mult);

  // Display results for division
  $display("Division: Real = %b (%0d), Imag = %b (%0d)", real_out_div, real_out_div, imag_out_div, imag_out_div);

  // Display results for conjugate
  $display("Conjugate 1: Real = %b (%0d), Imag = %b (%0d)", conj_r1, conj_r1, conj_i1, conj_i1);
  $display("Conjugate 2: Real = %b (%0d), Imag = %b (%0d)", conj_r2, conj_r2, conj_i2, conj_i2);

  // Display results for angles
$display("Angle r1 = %0d degrees, Angle r2 = %0d degrees", 
             (angle_r1 * 360) / 65536, 
             (angle_r2 * 360) / 65536);


    #10;
    $finish;
  end
  
endmodule

module complex_multiplier(
  input signed [7:0] r1, i1, r2, i2,
  output signed [15:0] real_out, imag_out
);
  assign real_out = (r1 * r2) - (i1 * i2);
  assign imag_out = (r1 * i2) + (r2 * i1);
endmodule

module complex_divider(
  input signed [7:0] r1, i1, r2, i2,
  output reg signed [15:0] real_out, imag_out
);
  always @* begin
    if (r2 == 0 && i2 == 0) begin
      real_out = 0;
      imag_out = 0;
    end else begin
      real_out = ((r1 * r2) + (i1 * i2)) / ((r2 * r2) + (i2 * i2));
      imag_out = ((i1 * r2) - (r1 * i2)) / ((r2 * r2) + (i2 * i2));
    end
  end
endmodule

module complex_adder(
  input signed [7:0] r1, i1, r2, i2,
  output signed [8:0] real_out, imag_out
);
  assign real_out = r1 + r2;
  assign imag_out = i1 + i2;
endmodule

module complex_subtractor(
  input signed [7:0] r1, i1, r2, i2,
  output signed [7:0] real_out, imag_out,
  output is_real_negative, is_imag_negative
);
  assign real_out = r1 - r2;
  assign imag_out = i1 - i2;
  assign is_real_negative = (r1 - r2) < 0;
  assign is_imag_negative = (i1 - i2) < 0;
endmodule

module complex_conjugate(
  input signed [7:0] r1, i1, r2, i2,
  output signed [7:0] conj_r1, conj_i1, conj_r2, conj_i2
);
  assign conj_r1 = r1;
  assign conj_i1 = -i1;
  assign conj_r2 = r2;
  assign conj_i2 = -i2;
endmodule

module complex_angle(
  input signed [7:0] r1, i1, r2, i2,
  output [15:0] angle_r1, angle_r2
);
  assign angle_r1 = (r1 == 0 && i1 == 0) ? 0 : $atan2(i1, r1) * 65536 / (2 * 3.14159);
  assign angle_r2 = (r2 == 0 && i2 == 0) ? 0 : $atan2(i2, r2) * 65536 / (2 * 3.14159);
endmodule