//==================================================================================================
//  Filename      : IDEX.v
//  Created On    : 2018-03-05 08:35:16
//  Last Modified : 2018-03-06 14:55:49
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module IDEX(in_EN,in_CLK,in_CLR,in_is,in_p2,in_p3,in_p4,in_pcout,in_ra,in_rb,in_control,in_p1,in_extended,
	out_is,out_p2,out_p3,out_p4,out_pcout,out_ra,out_rb,out_control,out_p1,out_extended);
	input in_EN,in_CLK,in_CLR;
	input [31:0]in_is,in_pcout,in_ra,in_rb,in_p1,in_extended;
	input [4:0]in_p2,in_p3,in_p4;
	input [25:0]in_control;

	output reg [31:0]out_is,out_pcout,out_ra,out_rb,out_p1,out_extended;
	output reg [4:0]out_p2,out_p3,out_p4;
	output reg [25:0]out_control;

	initial begin
			out_is <= 0;
			out_pcout <= 0;
			out_ra <= 0;
			out_rb <= 0;
			out_p1 <= 0;
			out_extended <= 0;

			out_p2 <= 0;
			out_p3 <= 0;
			out_p4 <= 0;
			out_control <= 0;
	end
	always @(posedge in_CLK or posedge in_CLR) begin
		if (in_CLR) begin
			// reset
			out_is <= 0;
			out_pcout <= 0;
			out_ra <= 0;
			out_rb <= 0;
			out_p1 <= 0;
			out_extended <= 0;

			out_p2 <= 0;
			out_p3 <= 0;
			out_p4 <= 0;
			out_control <= 0;
			
		end
		else if (in_EN) begin
			out_is <= in_is;
			out_pcout <= in_pcout;
			out_ra <= in_ra;
			out_rb <= in_rb;
			out_p1 <= in_p1;
			out_extended <= in_extended;

			out_p2 <= in_p2;
			out_p3 <= in_p3;
			out_p4 <= in_p4;
			out_control <= in_control;
		end
	end
endmodule