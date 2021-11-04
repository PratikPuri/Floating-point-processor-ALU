`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:29:10 08/21/2017 
// Design Name: 
// Module Name:    MicroProcessor 
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
module MicroProcessor(input Clock,Reset,
							 output  [63:0] aluOut);

wire [15:0] Opcode;
wire [2:0] aluCntrl,aluCntrlp3,OpcodeDelay;
wire [3:0] regSrc1Adp,regSrc2Adp,regOutAdp,regOutDelay,Dest;
wire [31:0] aluSrc1p,aluSrc2p,aluSrcA,aluSrcB,aluIn1,aluIn2,aluOutp;

assign Dest = (Opcode[15:12] == 4)||(Opcode[15:12] == 5)?Opcode[11:8]:Opcode[3:0];							 
 
cntrlUnit MPCtrl(Clock,Reset, divFlag,divFlag1,divFlag2, mulStall,Opcode[15:12],Opcode[11:8],Opcode[7:4],Dest,OpcodeDelay,
					  insReadEn,insWriteEn,regAd1En,regAd2En,regAd3En,regWrtEn,reg2WrtEn,regRdEn,PC_Inc,aluSrcAEn,aluSrcBEn,
					  muxSrc1WB,muxSrc2Inc,muxSrc2WB,mux2Src1,mux2Src2,stall,stall2,stall1,
					  aluCntrl );	
					  
CntrlPipeline MPaluCntrlPipeline(Clock,Reset,aluSrcAEn,aluSrcBEn,muxSrc1WB,muxSrc2Inc,muxSrc2WB,mux2Src1,mux2Src2,regWrtEn,reg2WrtEn,regRdEn,mulStall,stall,stall2,stall1,aluCntrl,
							          aluSrc1Enp2,aluSrc2Enp2,muxIncDecWB2p2,muxWB2p2,muxWB1p2,mux2Src1p2,mux2Src2p2,regWrtEnp3,reg2WrtEnp3
										 ,regRdEnp,aluCntrlp3);
					  

InstructMem MPins(Clock, Reset,1'b1/*pcinc*/,insWriteEn,PC_Inc,
						 Opcode[15:0]
						);
						
RegStack0_15 MPreg(Clock, Reset, regWrtEnp3,regRdEnp,reg2WrtEnp3,
						 regSrc1Adp, regSrc2Adp, regOutAdp,
						 aluOut[31:0],aluOut[63:32],
						 aluSrcA,aluSrcB
						);
						
PipelineReg MPpipeline(Clock,Reset,regAd1En,regAd2En,regAd3En,aluSrc1Enp2,aluSrc2Enp2,stall,stall1,
							Opcode[11:8],Opcode[7:4],Dest,
						   aluSrcA, aluSrcB,
						   regSrc1Adp,regSrc2Adp,regOutAdp,regOutDelay,
						   aluSrc1p,aluSrc2p
						 );
						 
aluWB aluWrtBk(Clock,aluSrc1p,aluSrc2p,aluOut[63:0],muxWB1p2,muxIncDecWB2p2
						,muxWB2p2,mux2Src1p2,mux2Src2p2,aluCntrlp3,divFlag,stall,aluIn1,aluIn2); 						 
						
AluWrapper MPAlu( Clock,Reset,
					   aluCntrlp3,
					   aluIn1,aluIn2,
					   aluOut,
						CarryOut,
						divFlag,divFlag1,divFlag2,
						mulStall
						);						

endmodule
