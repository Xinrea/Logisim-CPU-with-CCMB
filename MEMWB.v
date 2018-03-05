//==================================================================================================
//  Filename      : MEMWB.v
//  Created On    : 2018-03-05 09:42:02
//  Last Modified : 2018-03-05 14:52:10
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module MEMWB(in_EN,in_CLK,in_CLR,in_lock,in_ra,in_rb,in_is,in_p2,in_p3,in_p4,in_pcout,in_control,in_R,in_Memdata
	out_lock,out_ra,out_rb,out_is,out_p2,out_p3,out_p4,out_pcout,out_control,out_R);
	input in_EN,in_CLK,in_CLR;
	input in_lock;
	input [31:0]in_is,in_pcout,in_ra,in_rb,in_R,in_Memdata;
	input [4:0]in_p2,in_p3,in_p4;
	input [22:0]in_control;

	output reg out_lock;
	output reg [31:0]out_is,out_pcout,out_ra,out_rb,out_R,out_Memdata;
	output reg [4:0]out_p2,out_p3,out_p4;
	output reg [22:0]out_control;

	always @(posedge in_CLK or posedge in_CLR) begin
		if (in_CLR) begin
			// reset
			out_lock <= 0;

			out_is <= 0;
			out_pcout <= 0;
			out_ra <= 0;
			out_rb <= 0;
			out_R <= 0;
			out_Memdata <= 0;

			out_p2 <= 0;
			out_p3 <= 0;
			out_p4 <= 0;
			out_control <= 0;
			
		end
		else if (in_EN) begin
			out_lock <= in_lock;

			out_is <= in_is;
			out_pcout <= in_pcout;
			out_ra <= in_ra;
			out_rb <= in_rb;
			out_R <= in_R;
			out_Memdata <= in_Memdata;

			out_p2 <= in_p2;
			out_p3 <= in_p3;
			out_p4 <= in_p4;
			out_control <= in_control;
		end
	end
endmodule