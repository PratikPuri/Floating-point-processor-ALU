`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:43:16 08/19/2017 
// Design Name: 
// Module Name:    InstructMem 
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
module InstructMem( input Clock, Reset,readEn,writeEn,PC_Inc,
						  output reg [15:0] instructWord
						);
 reg [15:0] instructReg [15:0];
 reg [3:0] PC; 
 reg temp;
 
 initial 
 begin
	$readmemb("ins.tv",instructReg);
 end
 integer i;
 
 always @ (posedge Clock)
 begin
	
	if(Reset)
	begin	
		PC <= 0;
		instructWord <= 2**16 - 1;
	end	
		/*for(i = 0; i < 16 ; i = i+1 )
			instructReg[i] <= 0;*/
	else
	begin
		if(readEn)
		begin
			instructWord <= instructReg[PC];
		end
		else
			instructWord <= instructWord;
		if(writeEn)
			instructReg[PC] <= instructWord;
		else
			instructReg[PC] <= instructReg[PC];
		if(PC_Inc)	
			{temp,PC} <= PC + 1;
		else
			PC <= PC;
	end	
 
 end		
	
endmodule
