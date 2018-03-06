//==================================================================================================
//  Filename      : REGFILE.v
//  Created On    : 2018-03-04 22:04:58
//  Last Modified : 2018-03-06 14:34:57
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module REGFILE(in_clk,in_syscall,in_regcontrol,in_Memdata,in_R,in_pcout,in_pc0,in_pcw,
	in_p2,in_p4,in_id_p4,in_ra,in_rb,out_A,out_B,out_EPC);
	input in_clk,in_syscall;
	input [4:0]in_regcontrol;
	input [31:0]in_Memdata,in_R,in_pcout;
	input in_pc0,in_pcw;
	input [4:0]in_p2,in_p4,in_id_p4,in_ra,in_rb;
	output [31:0]out_A,out_B;
	output [31:0]out_EPC;
	reg [4:0]rW;
	reg [4:0]rA,rB,rCP;
	reg [31:0]W;
	wire [31:0]out_CP;
	always @(*) begin
		if(in_pc0)begin//about writing registers
			rCP <= in_p4;
			W <= out_CP;
			rW <=in_p2;
		end
		else begin
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
		end

		if(in_pcw)begin
			rA <= in_rb;
		end
		else begin
			if(in_syscall)begin
				rA <= 2;
				rB <= 4;
			end
			else begin
				rA <= in_ra;
				rB <= in_rb;
			end
		end


	end
	BASEREGFILE m_BASEREGFILE(in_clk,in_regcontrol[2],rW,rA,rB,W,out_A,out_B);
	REGCP0 m_REGPC0(in_clk,in_pcw,in_id_p4[1:0],out_A,rCP,out_CP,out_EPC);
endmodule