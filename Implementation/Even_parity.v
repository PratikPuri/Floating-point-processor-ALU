`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:59:22 08/12/2017 
// Design Name: 
// Module Name:    Odd_Parity 
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
module Odd_Parity(
    input [7:0] Data_In,
    output  Data_Out
    );


/* genvar i;
 wire[6:0] temp;
 generate 
	for(i = 0;i<7;i = i+1)
	begin:forloop
		if(i == 0)
			assign temp[0] = Data_In[0] ^ Data_In[1];
		else
			assign temp[i] = temp[i-1] ^ Data_In[i+1];
	end
 endgenerate*/	
 
 assign Data_Out = {temp[6]};

endmodule
