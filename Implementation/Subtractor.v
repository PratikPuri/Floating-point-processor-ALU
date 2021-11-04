`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:50:26 08/22/2017 
// Design Name: 
// Module Name:    Subtractor 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Subtractor(
    input [31:0] src1,
    input [31:0] src2,
    output [31:0] out,
	 output carryOut
    );
	
 wire [31:0] compSrc2;
 assign compSrc2 = {~src2} + 1;
 Adder compSub(src1,compSrc2,out,carryOut);

endmodule
