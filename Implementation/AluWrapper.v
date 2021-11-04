`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:39:13 08/20/2017 
// Design Name: 
// Module Name:    AluWrapper 
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
module AluWrapper(input Clock,Reset,
						input [2:0] aluCntrl,
						input [31:0] aluSrc1,aluSrc2,
						output reg [63:0] aluOut,
						output reg carryOut,
						output reg divFlag,divFlag1,divFlag2,
						output reg mulStall
						);
 
 wire [31:0] addOut,compOut, divOut, subOut,incOut,decOut;
 wire [63:0] mulOut;
 reg [31:0] divCount;
 reg  divSign;
 reg parity;
 reg zero;
 
 wire addCarry,subCarry,incCarry,decCarry;
 
 Adder aluAdder(aluSrc1,aluSrc2,addOut,addCarry);
 
 Adder inc(aluSrc1,1,incOut,incCarry);
 
 Subtractor dec(aluSrc1, 1, decOut,decCarry);
 
 Subtractor aluSub(aluSrc1, aluSrc2, subOut,subCarry);
 
 Multiplication mul(aluSrc1,aluSrc2,mulOut);
 
 Divider aluDiv(aluSrc1,aluSrc2,divOut);
 
 Comparator comp(aluSrc1,aluSrc2,compOut);
 
 always @ (posedge Clock)
	begin
		if(Reset)
		begin
			divCount <= 0;
			divSign <= 0;
			mulStall <= 1;
			divFlag <= 0;
			divFlag1 <= 0;
			divFlag2 <= 0;
			parity <= 0;
		end	
		else
		begin
		case(aluCntrl)
			0:
			begin	
				divFlag <= 0;
				divFlag2 <= 0;
				aluOut[31:0] <= addOut;
				aluOut[63:32] <= 0;
				carryOut <= addCarry;
			end	
			1: 
			begin
				divFlag2 <= 0;
				divFlag <= 0;
				aluOut[31:0] <= subOut;
				aluOut[63:32] <= 0;
				carryOut <= subCarry;
			end
			2: 
			begin
				divFlag <= 0;
				divFlag2 <= 0;
				aluOut[63:0] <= mulOut[63:0];
			end	
			
			3:
			begin
			if((divOut) < aluSrc2)
				begin
					divFlag <= 1;
					divCount <= 0;
					aluOut <= divCount + 1;
				end
			else
			begin
				divCount <= divCount + 1;
				divFlag <= 0;
				aluOut <= divOut;
			end
			
			if((divOut - aluSrc2) < aluSrc2)
				begin
					divFlag1 <= 1;
				end
			else
			begin
				divFlag1 <= 0;
			end
			
			if((divOut - (aluSrc2+aluSrc2)) < aluSrc2)
				begin
					divFlag2 <= 1;
				end
			else
			begin
			if(divFlag2)
				if(!divFlag)
					divFlag2 <= 1;
				else
					divFlag2 <= 0;
			else	
				divFlag2 <= 0;
			end
					
				/*if(divFlag && (divCount == 0))
				begin
					divSign <= (aluSrc1[31] == 1)?(aluSrc2[31] == 0)?1'b1:1'b0:(aluSrc2[31] == 1)?1'b1:1'b0;
					divCount <= divCount + 1;
					aluOut <= divOut;
				end
				else
				begin
					if(divFlag)
					begin
						divCount <= divCount + 1;
						aluOut <= divOut;
					end	
					else
					begin	
						case(divSign)
							0:aluOut <= divCount;
							1:aluOut <= ~divCount + 1;
						endcase	
						divCount <= 0;
						divSign <= 0;
					end	
				end*/	
			end			
			
			4:
			begin
				divFlag <= 0;
				divFlag2 <= 0;
				aluOut[31:0] <= incOut;
				carryOut <= incCarry;
				aluOut[63:32] <= 0;
			end
			5:
			begin
				divFlag <= 0;
				divFlag2 <= 0;
				aluOut[31:0] <= decOut;
				carryOut <= decCarry;
				aluOut[63:32] <= 0;
			end
			
			6: 
			begin
				divFlag <= 0;
				divFlag2 <= 0;
				aluOut[31:0] <= compOut;
				aluOut[63:32] <= 0;
			end
			 7:
			 begin 	
				parity <= ~^aluSrc1;
				aluOut <= aluOut;
			 end
			default:
			begin
				divFlag <= 0;
				divFlag2 <= 0;
				aluOut <= 0;
			end	
		endcase	
		
		end
   end	
	
endmodule
