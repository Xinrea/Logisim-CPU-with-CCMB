//==================================================================================================
//  Filename      : MPC.v
//  Created On    : 2018-03-04 16:36:14
//  Last Modified : 2018-03-06 14:39:27
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module MPC(in_EN,in_CLOCK,in_RST,in_BGEZ,in_BEQ,in_BNE,in_J,in_JR,in_result,in_equal,in_extended,in_a,in_is,in_force,in_faddr,out_JS,out_pcout);
	input in_EN,in_CLOCK,in_RST,in_BGEZ,in_BEQ,in_BNE,in_J,in_JR,in_result,in_equal;
	input [31:0]in_extended,in_a,in_is;
	input in_force;
	input [31:0]in_faddr;
	output out_JS;
	output reg [31:0]out_pcout = 0;
	wire cidi_control;
	wire [31:0]new_pcin;
	wire [31:0]pcin;
	assign out_JS = (~in_equal&in_BNE)|~cidi_control;

	always @(posedge in_CLOCK or posedge in_RST) begin
		if(in_RST)out_pcout = 0;
		else begin
			if(in_force)out_pcout = in_faddr;
			else begin
				if(in_EN|in_JR|in_J)out_pcout = pcin;
			end
		end
	end

	CIDI m_CIDI(in_BGEZ,in_BNE,in_BEQ,in_result,in_equal,cidi_control);
	PCC m_PCC(in_extended,cidi_control,out_pcout,new_pcin);
	UCIDI m_UCIDI(in_J,in_JR,new_pcin,in_a,out_pcout,in_is,pcin);
endmodule