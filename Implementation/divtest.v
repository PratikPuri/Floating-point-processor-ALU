`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:25:16 08/23/2017
// Design Name:   Divider
// Module Name:   I:/xilinx_project/Assignment_2/divtest.v
// Project Name:  Assignment_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Divider
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module divtest;

	// Inputs
	reg [31:0] src1;
	reg [31:0] src2;

	// Outputs
	wire divFlag;
	wire [31:0] divOut;

	// Instantiate the Unit Under Test (UUT)
	Divider uut (
		.src1(src1), 
		.src2(src2), 
		.divFlag(divFlag), 
		.divOut(divOut)
	);

	initial begin
		// Initialize Inputs
		src1 = 8;
		src2 = 2;
		
		#10
		src1 = 6;
		src2 = 2;
		
		#10
		src1 = 4;
		src2 = 2;
		
		#10
		src1 = 2;
		src2 = 2;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

