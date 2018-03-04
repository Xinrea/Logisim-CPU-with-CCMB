//==================================================================================================
//  Filename      : UCIDI.v
//  Created On    : 2018-03-04 16:23:08
//  Last Modified : 2018-03-04 16:44:11
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module UCIDI(in_J,in_JR,in_pcc,in_a,in_pcout,in_is,out_pcin);
	input in_J;
	input in_JR;
	input [31:0]in_pcc;
	input [31:0]in_a;
	input [31:0]in_pcout;
	input [31:0]in_is;
	output reg [31:0]out_pcin;
	reg [31:0]new_address;

	new_address[7:0] = in_is[7:0];
	new_address[31:8] = in_pcout[31:8];

	always @(*) begin
		out_pcin = in_J?(in_JR?in_a:new_address):in_pcc;
	end
	
endmodule