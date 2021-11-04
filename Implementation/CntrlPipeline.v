`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:43:15 08/23/2017 
// Design Name: 
// Module Name:    CntrlPipeline 
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
module CntrlPipeline(input Clock,Reset,aluSrc1En,aluSrc2En,muxWB1,muxIncDecWB2,muxWB2,mux21WB,mux22WB,regWREn,reg2WREn,regRdEn,mulStall,stall,stall2,stall1,input [2:0] aluCntrl,
							output reg aluSrc1Enp2,aluSrc2Enp2,muxIncDecWB2p2,muxWB2p2,muxWB1p2,mux21WBp2,mux22WBp2,regWREnp3,reg2WREnp3,regRdEnp,
							output reg[2:0] aluCntrlp3);


 reg aluSrc1EnTemp,muxWB2Temp,aluSrc2EnTemp,muxIncDecWB2Temp,muxWB1p2Temp,regWREnTemp,regWREnTemp1,
		regWREnTemp2,regWREnTemp4,reg2WREnTemp,reg2WREnTemp1,
		reg2WREnTemp2,reg2WREnTemp4,mux21temp,mux22temp;
		
 reg [2:0] aluCntrlTemp,aluCntrlp2;

 always @ (negedge Clock)
 begin
	if(Reset)
	begin
		aluSrc1EnTemp <= 0;
		aluSrc2EnTemp <= 0;
		aluCntrlTemp <= 0;
	end	
	else
	begin
	 	if(!stall)
		begin
			aluCntrlTemp <= aluCntrl;
			aluCntrlp2 <= aluCntrlTemp;
			aluCntrlp3 <= aluCntrlp2;
		 end
		 else
		 begin
			aluCntrlTemp <= aluCntrlTemp;
			aluCntrlp2 <= aluCntrlp2;
			aluCntrlp3 <= aluCntrlp3;
		 end	
		 
		 	if(!stall)
		begin		 
			aluSrc1EnTemp	<= aluSrc1En;
			aluSrc1Enp2 <= aluSrc1EnTemp;
		 
			aluSrc2EnTemp	<= aluSrc2En;
			aluSrc2Enp2 <= aluSrc2EnTemp;
		 end
		 else
		 begin
			aluSrc1EnTemp	<= aluSrc1EnTemp;
			aluSrc1Enp2 <= aluSrc1Enp2;
		 
			aluSrc2EnTemp	<= aluSrc2EnTemp;
			aluSrc2Enp2 <= aluSrc2Enp2;
		 end	
	end
 end		
 
 always @ (posedge Clock)
 begin
	if(Reset)
	begin
		muxIncDecWB2Temp <= 0;
		muxWB1p2Temp <= 0;
		muxWB2Temp <= 0;
		regWREnTemp <= 0;
		regWREnTemp1 <= 0;
		regWREnTemp2 <= 0;
		reg2WREnTemp <= 0;
		reg2WREnTemp1 <= 0;
		reg2WREnTemp2 <= 0;
		regWREnTemp4 <= 0;
		reg2WREnTemp4 <= 0;
		muxWB1p2 <= 0;
		muxWB2p2 <= 0;
		muxIncDecWB2p2 <= 0;
		mux21temp <= 0;
		mux22temp <= 0;
		mux21WBp2 <= 0;
		mux22WBp2 <= 0;
	end	
	else
	begin
		if(!stall)
		begin
			regWREnTemp <= regWREn;
			regWREnTemp1 <= regWREnTemp;
			regWREnTemp2 <= regWREnTemp1;
			//regWREnTemp4 <= regWREnTemp2;
			regWREnp3 <= regWREnTemp2;
			
			reg2WREnTemp <= reg2WREn;
			reg2WREnTemp1 <= reg2WREnTemp;
			reg2WREnTemp2 <= reg2WREnTemp1;
			//reg2WREnTemp4 <= reg2WREnTemp2;
			reg2WREnp3 <= reg2WREnTemp2;			
		end
		else
		begin
			regWREnTemp <= regWREnTemp;
			regWREnTemp1 <= regWREnTemp1;
			regWREnTemp2 <= regWREnTemp2;
			regWREnp3 <= regWREnp3;
			
			reg2WREnTemp <= reg2WREnTemp;
			reg2WREnTemp1 <= reg2WREnTemp1;
			reg2WREnTemp2 <= reg2WREnTemp2;
			reg2WREnp3 <= reg2WREnp3;
		end
		
		if(!stall)
		begin
			muxIncDecWB2Temp <= muxIncDecWB2;
			muxIncDecWB2p2 <= muxIncDecWB2Temp;
		 
			muxWB2Temp <= muxWB2;
			muxWB2p2 <= muxWB2Temp;
		 
			muxWB1p2Temp <= muxWB1;
			muxWB1p2 <= muxWB1p2Temp;
			
			mux21temp <= mux21WB;
			mux21WBp2 <= mux21temp;
			
			mux22temp <= mux22WB;
			mux22WBp2 <= mux22temp;
			
			regRdEnp <= regRdEn;
		end
		else
		begin
			muxIncDecWB2Temp <= muxIncDecWB2Temp;
			muxIncDecWB2p2 <= muxIncDecWB2p2;
		 
			muxWB2Temp <= muxWB2Temp;
			muxWB2p2 <= muxWB2p2;
		 
			muxWB1p2Temp <= muxWB1p2Temp;
			muxWB1p2 <= muxWB1p2;
			
			mux21temp <= mux21temp;
			mux21WBp2 <= muxWB1p2;
			
			mux22temp <= mux22temp;
			mux22WBp2 <= muxWB1p2;
			
			regRdEnp <= regRdEn;
		end
		
		
	end		 
 end

endmodule
