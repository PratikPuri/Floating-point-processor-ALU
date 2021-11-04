`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:21:21 08/19/2017 
// Design Name: 
// Module Name:    Comparator 
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
module Comparator( input [31:0] src1, src2,
						 output reg[31:0] compOut	
						);
 always @ (*)
   compOut = (src1 == src2)?src1:(src1 < src2)?src2:src1 ;

endmodule
