//==================================================================================================
//  Filename      : DECODE.v
//  Created On    : 2018-03-04 18:21:15
//  Last Modified : 2018-03-04 18:42:29
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module DECODE(in_IM,in_is,out_p1,out_im,out_p2,out_p3,out_p4);
	input in_IM;
	input [31:0]in_is;
	output [31:0]out_p1;
	output [31:0]out_im;
	output [4:0]out_p2,out_p3,out_p4;
	assign out_p2 = in_is[20:16];
	assign out_p3 = in_is[25:21];
	assign out_p4 = in_is[15:11];
	EXTENDER m_EXTENDER(in_IM,in_is[15:0],out_im);
endmodule