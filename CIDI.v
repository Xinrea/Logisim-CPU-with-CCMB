//==================================================================================================
//  Filename      : CIDI.v
//  Created On    : 2018-03-04 16:22:45
//  Last Modified : 2018-03-04 16:22:51
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module CIDI(in_BGEZ,in_BNE,in_BEQ,in_result,in_equal,out_cidi_control);
	input in_BGEZ;
	input in_BNE;
	input in_BEQ;
	input in_result;
	input in_equal;
	output out_cidi_control;
	always @(*) begin
		out_cidi_control = in_BEQ?~in_equal:(in_BNE?in_equal:(in_BGEZ?in_result:1));
	end
endmodule