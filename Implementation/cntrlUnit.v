`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:35:22 08/21/2017 
// Design Name: 
// Module Name:    cntrlUnit 
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
module cntrlUnit( input Clock,Reset, divFlag,divFlag1,divFlag2,mulStall,
						input [3:0] Opcode,
						input [3:0] src1Ad,src2Ad,wrAd,input [2:0] OpcodeDelay,
						output reg insReadEn,insWriteEn,regAd1En,regAd2En,regAd3En,regWrtEn,reg2WrtEn,regRdEn,PC_Inc,aluSrcA,aluSrcB,
								 muxSrc1WB,muxSrc2Inc,muxSrc2WB,mux2Src1,mux2Src2,stall,stall2,stall1,
						output reg[2:0] aluCntrl			
						);
 reg resetHap,HLT;
 reg [3:0] wrAd1,wrAd2;
 reg [2:0] prevOpcode,prev;
 reg mux1,mux2,mux21,mux22;
 

 always @ (negedge Clock,posedge Reset)
 begin
		if(Reset)
		begin
			mux21 <= 0;
			mux22 <= 0;
			wrAd1 <= 0;
			wrAd2 <= 0;
			stall <= 0;
			mux1 <= 0;
			mux2 <= 0;
			PC_Inc <= 1;
			regWrtEn <= 0;
			stall1 <= 0;
			stall2 <= 0;
		
		end
		else
		begin
		if(Opcode == 15)
		begin
			regWrtEn <= 0;
			PC_Inc <= 0;
			
			mux21 <= 0;
			mux22 <= 0;
			wrAd1 <= 0;
			wrAd2 <= 0;
			stall <= 0;
			mux1 <= 0;
			mux2 <= 0;
			stall1 <= 0;
			stall2 <= 0;
		end	
		else
		begin	
			wrAd1 <= wrAd;
			wrAd2 <= wrAd1;
			if(stall1 == 0)
			begin
				aluCntrl <= Opcode;
				prevOpcode <= aluCntrl;
				prev <= prevOpcode;
			end
			else
			begin
				if(divFlag2)
				begin
					aluCntrl <= Opcode;	
					prevOpcode <= 0;
					prev <= 0;			
				end
				else
				begin
					aluCntrl <= aluCntrl;
					prevOpcode <= prevOpcode;
					prev <= prev;
				end	

			end
			
			if(((aluCntrl == 3)) || (stall1 == 1))
			begin	
				if(divFlag1)
				begin
					stall1 <= 0;
					stall <= 0;
					stall2 <= 0;
				end	
				else
				begin
					stall1 <= 1;
					stall2 <= stall1;
					stall <= stall2;
				end
				if(divFlag2)
					PC_Inc <= 1;
				else
					PC_Inc <= 0 ;	
				
			end	
			else
			begin
			//if(Opcode == 3)
			//	PC_Inc <= 0;
			//else	
				PC_Inc <= 1;
				stall1 <= 0;
			end	
			
			
			
			if(Opcode == 2)
			begin
				reg2WrtEn <= 1;
			end
			else
			begin
				reg2WrtEn <= 0;
			end
			
			if(((wrAd1 == src1Ad)||(wrAd1 == src2Ad)||(wrAd2 == src1Ad)||(wrAd2 == src1Ad)))//&&((Opcode != 4)||(Opcode != 5)))
			begin
				if((wrAd1 == src1Ad))
					mux1 <= 1;
				else
					mux1 <= 0;
				if((wrAd1 == src2Ad))
					mux2 <= 1;
				else
					mux2 <= 0;		
					
				if(wrAd2 == src1Ad)
				begin
					mux21 <= 1; 
				end	
				else
				begin
					mux21 <= 0;
				end
				
				if(wrAd2 == src2Ad)
				begin
					mux22 <= 1; 
				end	
				else
				begin
					mux22 <= 0;
				end
				
				
				regAd1En <= 1;
				regAd2En <= 1;
				regAd3En <= 1;
				
				if((prevOpcode == 3))
					if(divFlag2)
					begin
						regRdEn <= 1;
						regWrtEn <= 1;
					end	
					else
					begin
						regRdEn <= 0;
						regWrtEn <= 0;
					end	
				else
				begin
					if((Opcode == 7)||(Opcode == 15))
						regWrtEn <= 0;
					else
						regWrtEn <= 1;	
					
					regRdEn <= 1;
				end	
				aluSrcA <= 1;
				aluSrcB <= 1;
				insReadEn <= 1;
				insWriteEn <= 0;	
			end
		   else
			begin
				regAd1En <= 1;
				regAd2En <= 1;
				regAd3En <= 1;
				//regWrtEn <= 1;
				if((prevOpcode == 3))
					if(divFlag2)
					begin
						regRdEn <= 1;
						regWrtEn <= 1;
					end	
					else
					begin
						regRdEn <= 0;
						regWrtEn <= 0;
					end	
				else
				begin
					if((Opcode == 7)||(Opcode == 15))
						regWrtEn <= 0;
					else
						regWrtEn <= 1;	
					
					regRdEn <= 1;
					
				end	
				aluSrcA <= 1;
				aluSrcB <= 1;
				insReadEn <= 1;
				insWriteEn <= 0;
				
				mux2 <= 0;
			mux1 <= 0;
			mux22 <= 0;
			mux21 <= 0;
			end	
		end	
   end		
 end 

 always @ (posedge Clock)
 begin
	muxSrc1WB <= mux1;
	muxSrc2Inc <= 0;
	muxSrc2WB <= mux2;
	mux2Src1 <= mux21;
	mux2Src2 <= mux22;
 end
endmodule
