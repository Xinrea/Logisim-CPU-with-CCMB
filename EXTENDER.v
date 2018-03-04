//==================================================================================================
//  Filename      : EXTENDER.v
//  Created On    : 2018-03-04 18:10:46
//  Last Modified : 2018-03-04 18:17:42
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module EXTENDER(in_IM,in_original,out_extended);
	input in_IM;
	input [15:0]in_original;
	output reg [31:0]out_extended;
	always @(*) begin
		out_extended[15:0] <= in_original;
		out_extended[31:16] <= in_IM?{16{in_original[15]}}:0;
	end
endmodule