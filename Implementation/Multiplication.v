`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:26:37 08/19/2017 
// Design Name: 
// Module Name:    Multiplication 
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
module Multiplication( input [31:0] src1,src2,
							  output reg [63:0] mulOut	
							);
 
 always @ (*)
 	begin
		case({src1[31],src2[31]})
			0: mulOut =  src1 * src2 ;
			1: mulOut = (~((src1) * ({~src2} + 1))) + 1;
			2: mulOut = (~(({~src1} + 1) * (src2))) + 1;
			3: mulOut = (({~src1} + 1) * ({~src2} + 1));
			default: mulOut = 0;
		endcase
	
	end
 
endmodule
