`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:48:55 08/23/2017
// Design Name:   MicroProcessor
// Module Name:   I:/xilinx_project/Assignment_2_stable2/test_MP.v
// Project Name:  Assignment_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MicroProcessor
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_MP;

	// Inputs
	reg Clock;
	reg Reset;

	// Outputs
	wire [63:0] aluOut;

	// Instantiate the Unit Under Test (UUT)
	MicroProcessor uut (
		.Clock(Clock), 
		.Reset(Reset), 
		.aluOut(aluOut)
	);

	initial begin
		// Initialize Inputs
	
		Reset = 0;
		#5
		Reset = 1;
		#10
		Reset = 0;
		

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
   
	always 
	begin
			Clock = 0;
			#10;
			Clock = 1;
			#10;
   end
endmodule

