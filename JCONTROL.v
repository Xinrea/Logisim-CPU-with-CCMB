//==================================================================================================
//  Filename      : JCONTROL.v
//  Created On    : 2018-03-04 19:11:31
//  Last Modified : 2018-03-04 20:05:51
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module JCONTROL(in_instruction,in_special,
	out_J,out_JW,out_JR,out_BEQ,out_BNE,out_BGEZ,out_MemWrite,out_half);
	input [5:0]in_instruction;
	input in_special;
	output out_J,out_JW,out_JR,out_BEQ,out_BNE,out_BGEZ,out_MemWrite,out_half;
	assign out_J = ~in_special&~in_instruction[5]&~in_instruction[3]&in_instruction[1];
	assign out_JW = ~in_special&~in_instruction[5]&~in_instruction[3]&~in_instruction[1];
	assign out_JR = in_special&in_instruction[3]&~in_instruction[2]&~in_instruction[1];
	assign out_BEQ = ~in_special&~in_instruction[3]&~in_instruction[1]&~in_instruction[0];
	assign out_BNE = ~in_instruction[5]&~in_instruction[2]&in_instruction[2]&in_instruction[0];
	assign out_BGEZ = ~in_special&~in_instruction[3]&~in_instruction[2]&~in_instruction[1];
	assign out_MemWrite = ~in_special&in_instruction[5]&in_instruction[3];
	assign out_half = ~in_special&in_instruction[5]&~in_instruction[1];
endmodule