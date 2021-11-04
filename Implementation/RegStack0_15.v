`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:41:02 08/19/2017 
// Design Name: 
// Module Name:    RegStack0_15 
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
module RegStack0_15( input Clock, Reset, wrtEn,RdEn,reg2WrEn,
							input [3:0] regSrc1Ad, regSrc2Ad, regOutAd,
							input [31:0] regWrtVal,regWrtVal2,
							output reg[31:0] regSrc1Val,regSrc2Val
						  );

 reg[31:0] regStack[15:0];
 integer i;
  
 initial begin
	$readmemb("reg.tv",regStack);
 end
 reg [3:0] temp1,temp2,temp3,temp4;
 wire [3:0] wrtAd2;
 
 assign wrtAd2 = regOutAd + 1;
 
 always @ (posedge Clock)
 begin
		if(Reset)
		begin
			regSrc1Val <= 0;
			regSrc2Val <= 0;
			temp1 <= 0;
			temp2 <= 0;
			
		end
		else
		begin			
			if(RdEn)
			begin
				regSrc1Val <= regStack[regSrc1Ad];
				regSrc2Val <= regStack[regSrc2Ad];
			end
			else 
			begin
				regSrc1Val <= regSrc1Val;
				regSrc2Val <= regSrc2Val;
			end
			if(wrtEn)
			begin
				regStack[regOutAd] <= regWrtVal;
				//regStack[wrtAd2] <= regWrtVal2;
				if(reg2WrEn)
					regStack[regOutAd + 1] <= regWrtVal2;
				else
					regStack[regOutAd + 1] <= regStack[regOutAd + 1];
			end
			else
				regStack[regOutAd] <= regStack[regOutAd];
		end	
 end		
endmodule
 