module complex_multiplier(
  input [7:0] r1, i1, r2, i2,
  output [15:0] real_out, imag_out
);

  // Calculate real and imaginary outputs
  assign real_out = r1 * r2 - i1 * i2;
  assign imag_out = r1 * i2 + r2 * i1;

endmodule

module complex_divider(
  input [7:0] r1, i1, r2, i2,
  output [15:0] real_out, imag_out
);

  // Intermediate products
  wire [15:0] r1_r2 = r1 * r2;
  wire [15:0] i1_i2 = i1 * i2;
  wire [15:0] r2_i1 = r2 * i1;
  wire [15:0] r1_i2 = r1 * i2;
  wire [15:0] r2_squared = r2 * r2;
  wire [15:0] i2_squared = i2 * i2;
  wire [15:0] denominator = r2_squared + i2_squared;

  // Calculate real and imaginary outputs for division
  assign real_out = (r1_r2 + i1_i2) / denominator;
  assign imag_out = (r2_i1 - r1_i2) / denominator;

endmodule
module complex_conjugate(
  input  [7:0] r1, i1, r2, i2,
  output [7:0] conj_r1, conj_i1, conj_r2, conj_i2
);
  assign conj_r1 = r1;
  assign conj_i1 = -i1;
  assign conj_r2 = r2;
  assign conj_i2 = -i2;
endmodule

module complex_angle(
  input  [7:0] r1, i1, r2, i2,
  output [15:0] angle_r1, angle_r2
);
  assign angle_r1 = (r1 == 0 && i1 == 0) ? 0 : $atan2(i1, r1) * 65536 / (2 * 3.14159);
  assign angle_r2 = (r2 == 0 && i2 == 0) ? 0 : $atan2(i2, r2) * 65536 / (2 * 3.14159);
endmodule


module complex_multiplier_divider_tb;

  // Declare input and output signals
  reg [7:0] r1, i1, r2, i2;                // 8-bit binary inputs for real and imaginary parts
  wire [15:0] mult_real_out, mult_imag_out; // Outputs for multiplication
  wire [15:0] div_real_out, div_imag_out;   // Outputs for division
  wire [8:0] add_real_out, add_imag_out;    // Outputs for addition with carry bit
  wire [7:0] sub_real_out, sub_imag_out;    // Outputs for subtraction
  wire sub_real_neg, sub_imag_neg;          // Flags for negative subtraction result

   wire [15:0] angle_r1, angle_r2;                  // 16-bit outputs for angles
  
  // Declare output signals for conjugate module
  wire [7:0] conj_r1, conj_i1, conj_r2, conj_i2; // Instantiate the complex multiplier
  complex_multiplier uut_mult (
    .r1(r1), 
    .i1(i1), 
    .r2(r2), 
    .i2(i2), 
    .real_out(mult_real_out), 
    .imag_out(mult_imag_out)
  );

  // Instantiate the complex divider
  complex_divider uut_div (
    .r1(r1), 
    .i1(i1), 
    .r2(r2), 
    .i2(i2), 
    .real_out(div_real_out), 
    .imag_out(div_imag_out)
  );

  // Instantiate the 8-bit adders for complex addition
  myAdder8 adder_real (
    .A(r1), 
    .B(r2), 
    .S(add_real_out)
  );
  
  myAdder8 adder_imag (
    .A(i1), 
    .B(i2), 
    .S(add_imag_out)
  );

  // Instantiate the subtractors for complex subtraction
  mySUBTRACTOR subtractor_real (
    .A(r1), 
    .B(r2), 
    .D(sub_real_out), 
    .is_negative(sub_real_neg)
  );

  mySUBTRACTOR subtractor_imag (
    .A(i1), 
    .B(i2), 
    .D(sub_imag_out), 
    .is_negative(sub_imag_neg)
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

  initial begin
    // Initialize input values
    r1 = 8'b11111111;   
    i1 = 8'b11111111;   
    r2 = 8'b11111111;   
    i2 = 8'b11111111;    

    // Wait for a small time and check the multiplication output
    #10;
    $display("Test Case: Complex Number Multiplication, Division, Addition, and Subtraction");

    // Display Multiplication Results
    $display("Multiplication Results:");
    $display("Input 1: r1 = %b (%0d), i1 = %b (%0d)", r1, r1, i1, i1);
    $display("Input 2: r2 = %b (%0d), i2 = %b (%0d)", r2, r2, i2, i2);
    $display("Multiplication Output Real Part: %b (%0d)", mult_real_out, mult_real_out);
    $display("Multiplication Output Imaginary Part: %b (%0d)", mult_imag_out, mult_imag_out);

    // Wait for a small time and check the division output
    #10;
    $display("Division Results:");
    $display("Division Output Real Part: %b (%0d)", div_real_out, div_real_out);
    $display("Division Output Imaginary Part: %b (%0d)", div_imag_out, div_imag_out);

    // Wait for a small time and check the addition output
    #10;
    $display("Addition Results:");
    $display("Addition Output Real Part: %b (%0d)", add_real_out, add_real_out);
    $display("Addition Output Imaginary Part: %b (%0d)", add_imag_out, add_imag_out);

    // Wait for a small time and check the subtraction output
    #10;
    $display("Subtraction Results:");
    $display("Subtraction Output Real Part: %b (%0d), Negative Flag: %b", sub_real_out, sub_real_out, sub_real_neg);
    $display("Subtraction Output Imaginary Part: %b (%0d), Negative Flag: %b", sub_imag_out, sub_imag_out, sub_imag_neg);

    #10;
      // Display results for conjugate
  $display("Conjugate 1: Real = %b (%0d), Imag = %b (%0d)", conj_r1, conj_r1, conj_i1, conj_i1);
  $display("Conjugate 2: Real = %b (%0d), Imag = %b (%0d)", conj_r2, conj_r2, conj_i2, conj_i2);

  // Display results for angles
  $display("Angle r1 = %0d degrees, Angle r2 = %0d degrees", 
             (angle_r1 * 360) / 65536, 
             (angle_r2 * 360) / 65536);
    #10
    $finish;
  end

endmodule