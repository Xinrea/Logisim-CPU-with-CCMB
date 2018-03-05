//==================================================================================================
//  Filename      : REGFILE.v
//  Created On    : 2018-03-04 22:04:58
//  Last Modified : 2018-03-05 08:34:18
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module REGFILE(in_clk,in_syscall,in_regcontrol,in_Memdata,in_R,in_pcout,
	in_p2,in_p4,in_ra,in_rb,out_A,out_B);
	input in_clk,in_syscall;
	input [4:0]in_regcontrol;
	input [31:0]in_Memdata,in_R,in_pcout;
	input [4:0]in_p2,in_p4,in_ra,in_rb;
	output [31:0]out_A,out_B;
	reg rW;
	reg [4:0]rA,rB;
	reg [31:0]W;
	always @(*) begin
		if(in_regcontrol[0])begin
			if(in_regcontrol[1])begin
				W <= in_pcout + 1;
			end
			else begin
				W <= in_R;
			end
		end
		else begin
			W <= in_Memdata;
		end

		if(in_regcontrol[3])begin
			if(in_regcontrol[4])begin
				rW <= 5'b11111;
			end
			else begin
				rW <= in_p4;
			end
		end
		else begin
			rW <= in_p2;
		end

		if(in_syscall)begin
			rA <= 2;
			rB <= 4;
		end
		else begin
			rA <= in_ra;
			rB <= in_rb;
		end
	end
	BASEREGFILE m_BASEREGFILE(in_clk,in_regcontrol[2],rW,rA,rB,W,out_A,out_B);
endmodule