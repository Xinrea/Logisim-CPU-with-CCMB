//==================================================================================================
//  Filename      : PCC.v
//  Created On    : 2018-03-04 12:39:12
//  Last Modified : 2018-03-05 17:00:40
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module PCC(in_extended,in_cidi_control,in_pcout,out_pcin);
	input [31:0]in_extended;
	input in_cidi_control;
	input [31:0]in_pcout;
	output reg [31:0]out_pcin = 0;
	always @(*) begin
		out_pcin = in_pcout + in_cidi_control?1:(in_extended-1);
	end
endmodule