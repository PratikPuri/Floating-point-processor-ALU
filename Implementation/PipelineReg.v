`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:56:32 08/21/2017 
// Design Name: 
// Module Name:    PipelineReg 
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
module PipelineReg(input Clock,Reset,regSrc1AdEn,regSrc2AdEn,regOutAdEn,aluSrc1En,aluSrc2En,stall,stall1,
						 input [3:0] regSrc1Ad,regSrc2Ad,regOutAd,
						 input [31:0] aluSrc1, aluSrc2,
						 output reg [3:0] regSrc1Adp,regSrc2Adp,regOutAdp,regOutDelayWB,
						 output reg[31:0] aluSrc1p,aluSrc2p
						 );
 
 reg [3:0] regOutDelay[1:0];
 
 
 always @ (posedge Clock)
 begin
	if(Reset)
	begin
		regSrc1Adp <= 0;
		regSrc2Adp <= 0;
		regOutAdp <= 0;
      aluSrc1p <= 0;
		aluSrc2p <= 0;	
		regOutDelay[0] <= 0;
		regOutDelay[1] <= 0;
		regOutDelayWB <= 0;
		
   end
	else
	begin
		if(aluSrc1En && !stall )
			aluSrc1p <= aluSrc1;
		else
			aluSrc1p <= aluSrc1p;
		
		if(aluSrc2En && !stall)
			aluSrc2p <= aluSrc2;
		else
			aluSrc2p <= aluSrc2p;
			
		if(regSrc1AdEn && !stall)
			regSrc1Adp <= regSrc1Ad;
		else
			regSrc1Adp <= regSrc1Adp;
			
		if(regSrc2AdEn && !stall)
			regSrc2Adp <= regSrc2Ad;
		else
			regSrc2Adp <= regSrc2Adp;	
		
	
		if(regOutAdEn && !stall)
		begin
			
				regOutDelayWB <= regOutAd;
				regOutDelay[0] <= regOutDelayWB;
				regOutDelay[1] <= regOutDelay[0]	;
				regOutAdp <= regOutDelay[1];
			
		end
		else
		begin
				regOutDelayWB <= regOutDelayWB;
				regOutDelay[0] <= regOutDelay[0];
				regOutDelay[1] <= regOutDelay[1]	;
				regOutAdp <= regOutAdp;
		end
    end	
 end

endmodule
