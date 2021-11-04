`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:34:22 08/19/2017
// Design Name:   Multiplication
// Module Name:   I:/xilinx_project/Assignment_2/Mul_test.v
// Project Name:  Assignment_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Multiplication
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Mul_test;

	// Inputs
	reg [31:0] src1;
	reg [31:0] src2;

	wire[63:0] mulOut;
	// Instantiate the Unit Under Test (UUT)
	Multiplication uut (
		.src1(src1), 
		.src2(src2),
		.mulOut
	);

	initial begin
		// Initialize Inputs
		src1 = 0;
		src2 = 0;

		// Wait 100 ns for global reset to finish
		
		#10;
		src1 <= 32'b11000000000000000000000000000000;
		src2 <= 1234567890;
        
		  #10;
		src1 <= -20;
		src2 <= -20;
        
		  #10;
		src1 <= -20;
		src2 <= 20;
        
		  #10;
		src1 <= 20;
		src2 <= -20;
        
		// Add stimulus here

	end
      
endmodule

