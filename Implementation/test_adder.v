`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:01:29 08/19/2017
// Design Name:   Adder
// Module Name:   I:/xilinx_project/Assignment_2/test_adder.v
// Project Name:  Assignment_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_adder;

	// Inputs
	reg [31:0] src1;
	reg [31:0] src2;

	// Outputs
	wire [31:0] out;

	// Instantiate the Unit Under Test (UUT)
	Adder uut (
		.src1(src1), 
		.src2(src2), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		src1 = 0;
		src2 = 0;

		// Wait 100 ns for global reset to finish
		#10;
		
		src1 <= -2;
		src2 <= -3;
      
		#10
		src1 <= 2;
		src2 <= -3;
      
		#10
		src1 <= -2;
		src2 <= 3;
		
		#10
		
		src1 <= 2;
		src2 <= 3;
      
      	
		// Add stimulus here

	end
      
endmodule

