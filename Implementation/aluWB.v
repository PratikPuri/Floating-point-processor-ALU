`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:05:48 08/24/2017 
// Design Name: 
// Module Name:    aluWB 
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
module aluWB(input Clock,
				 input [31:0] srcA,srcB,
				 input [63:0] outWB,
				 input muxSrc1,muxinc,muxSrc2,mux2Src1,mux2Src2,
				 input [2:0] Opcode,input divFlag,stall,
				 output reg [31:0] srcAout,srcBout );
				 
reg [63:0] outp;
				 
always @ (srcA,srcB,outWB)
begin
	
		srcAout =  mux2Src1?outp[31:0]:muxSrc1?outWB[31:0]:srcA;
		
		srcBout =  mux2Src2?outp[31:0]:muxSrc2?outWB[31:0]:srcB;
end

always @(posedge Clock)
begin
	outp <= outWB;
end	

endmodule
