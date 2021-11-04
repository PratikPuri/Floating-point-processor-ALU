`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:55:49 08/19/2017 
// Design Name: 
// Module Name:    Adder 
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
module Adder( input [31:0] src1,src2,
				  output reg [31:0] out,
				  output reg carryOut
             );
 
 reg [31:0] temp;
 
 always @ (src1,src2)
 begin
	case({src1[31],src2[31]})
		0,1,2:{carryOut,out} = src1 + src2;
		3:{carryOut,out} = ~({~src1} + {~src2} + 2) + 1;
	endcase

 end
 
 endmodule
