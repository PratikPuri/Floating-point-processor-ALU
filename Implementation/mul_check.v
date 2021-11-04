`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:30:55 08/22/2017
// Design Name:   Multiplication
// Module Name:   I:/xilinx_project/Assignment_2/mul_check.v
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

module mul_check;

	// Inputs
	reg [31:0] src1;
	reg [31:0] src2;

	// Outputs
	wire [63:0] mulOut;

	// Instantiate the Unit Under Test (UUT)
	Multiplication uut (
		.src1(src1), 
		.src2(src2), 
		.mulOut(mulOut)
	);

	initial begin
		// Initialize Inputs
		src1 = 0;
		src2 = 0;
		
		#10
		src1 <= 33554432;
		src2 <= 33554432;
		
		#10
		src1 <= -4;
		src2 <= 4;
		
		#10
		src1 <= 33554432;
		src2 <= -33554432;
		
		#10
		src1 <= -33554432;
		src2 <= -33554432;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

