`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:26:47 08/19/2017
// Design Name:   Comparator
// Module Name:   I:/xilinx_project/Assignment_2/Comp_test.v
// Project Name:  Assignment_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Comparator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Comp_test;

	// Inputs
	reg [31:0] src1;
	reg [31:0] src2;

	// Outputs
	wire [1:0] compOut;

	// Instantiate the Unit Under Test (UUT)
	Comparator uut (
		.src1(src1), 
		.src2(src2), 
		.compOut(compOut)
	);

	initial begin
		// Initialize Inputs
		src1 = 0;
		src2 = 0;

		// Wait 100 ns for global reset to finish
		#10;
		
		src1 <= 1;
		src2 <=5;
		#10;
		src1 =10;
		src2 = 2;	
        
		// Add stimulus here

	end
      
endmodule

