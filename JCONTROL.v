//==================================================================================================
//  Filename      : JCONTROL.v
//  Created On    : 2018-03-04 19:11:31
//  Last Modified : 2018-03-06 11:13:03
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
	output reg out_J,out_JW,out_JR,out_BEQ,out_BNE,out_BGEZ,out_MemWrite,out_half;
	always @(*) begin
		if(~in_special&(in_instruction==8'h10))begin
			out_J <= 0;
			out_JW <= 0;
			out_JR <= 0;
			out_BEQ <= 0;
			out_BNE <= 0;
			out_BGEZ <= 0;
			out_MemWrite <= 0;
			out_half <= 0;
		end
		else begin
			out_J <= (~in_special&~in_instruction[5]&~in_instruction[3]&in_instruction[1])|(in_special&in_instruction[3]&~in_instruction[2]&~in_instruction[1]);
			out_JW <= ~in_special&~in_instruction[5]&~in_instruction[3]&~in_instruction[1];
			out_JR <= in_special&in_instruction[3]&~in_instruction[2]&~in_instruction[1];
			out_BEQ <= ~in_special&~in_instruction[3]&~in_instruction[1]&~in_instruction[0];
			out_BNE <= !in_instruction[5]&&!in_instruction[3]&&in_instruction[2]&&in_instruction[0];
			out_BGEZ <= ~in_special&~in_instruction[3]&~in_instruction[2]&~in_instruction[1];
			out_MemWrite <= ~in_special&in_instruction[5]&in_instruction[3];
			out_half <= ~in_special&in_instruction[5]&~in_instruction[1];	
		end
	end
endmodule