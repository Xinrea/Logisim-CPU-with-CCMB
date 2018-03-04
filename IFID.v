//==================================================================================================
//  Filename      : IFID.v
//  Created On    : 2018-03-04 18:01:29
//  Last Modified : 2018-03-04 18:08:11
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module IFID(in_EN,in_CLK,in_CLR,in_pcout,in_is,out_pcout,out_is);
	input in_EN,in_CLK,in_CLR;
	input [31:0]in_pcout,in_is;
	output reg [31:0]out_pcout,out_is;
	always @(posedge in_CLK or posedge in_CLR) begin
		if (in_CLR) begin
			// reset
			out_pcout <= 0;
			out_is <= 0;
		end
		else if (in_EN) begin
			out_pcout <= in_pcout;
			out_is <= in_is;
		end
	end
endmodule