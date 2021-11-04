`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:19:20 08/22/2017 
// Design Name: 
// Module Name:    Divider 
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
module Divider(
    input [31:0] src1,
    input [31:0] src2,
    output reg[31:0] divOut
    );
	
 reg [31:0] tempSrc1,tempSrc2;
 
 always @ (src1,src2)
 begin	
	/*case({src1[31],src2[31]})
		0:
		begin
			tempSrc1 = src1;
			tempSrc2 = src2;
		end	
		1: 
		begin
			tempSrc1 =  src1;
			tempSrc2 = ~src2 + 1;
		end	
		2: 
		begin
			tempSrc1 = ~src1 + 1;
			tempSrc2 = src2 ;
		end	
		3:
		begin
			tempSrc1 = ~src1 + 1;
			tempSrc2 = ~src2 + 1;
		end
   endcase  */		
		
	if(!src2)
	begin
		divOut = 32'b1;
	end	
	else
	begin	
		divOut = src1 - src2;
   end		
 end		
endmodule
