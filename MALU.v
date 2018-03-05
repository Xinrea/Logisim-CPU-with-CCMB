//==================================================================================================
//  Filename      : MALU.v
//  Created On    : 2018-03-05 08:55:21
//  Last Modified : 2018-03-05 16:38:12
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module MALU(in_CLK,in_RST,in_syscall,in_BGEZ,in_ALUOP,in_ALUIN,in_ALUREDI,in_SYSREDI,
	in_R,in_WB,in_A,in_B,in_extended,in_p1,out_R,out_result,out_syscallout,out_equal,out_lock);
	input in_CLK,in_RST,in_syscall,in_BGEZ;
	input [3:0]in_ALUOP,in_ALUIN,in_ALUREDI,in_SYSREDI;
	input [31:0]in_R,in_WB,in_A,in_B,in_extended,in_p1;
	output [31:0]out_R;
	output [31:0]out_syscallout;
	output reg out_result;
	output out_equal,out_lock;
	reg [31:0]sys_v0,sys_a0,alu_X,alu_Y;

	always @(*) begin
		out_result <= out_R[0];
		if(in_ALUREDI[0]|in_ALUREDI[2])begin
			if(in_ALUREDI[2])begin
				alu_X <= in_WB;
			end
			else begin
				alu_X <= in_R;
			end
		end
		else begin
			if(in_ALUIN[0])begin
				alu_X <= in_B;
			end
			else begin
				alu_X <= in_A;
			end
		end

		if(in_ALUREDI[1]|in_ALUREDI[3])begin
			if(in_ALUREDI[3])begin
				alu_Y <= in_WB;
			end
			else begin
				alu_Y <= in_R;
			end
		end
		else begin
			if(in_BGEZ)begin
				alu_Y <= 0;
			end
			else begin
				if(~in_ALUIN[1])begin
					if(~in_ALUIN[2])begin
						if(~in_ALUIN[3])begin
							alu_Y <= in_p1;
						end
						else begin
							alu_Y <= in_extended;
						end
					end
					else begin
						alu_Y <= in_B;
					end
				end
				else begin
					alu_Y <= in_A;
				end
			end
		end

		if(in_SYSREDI[0]|in_SYSREDI[2])begin
			if(in_SYSREDI[2])begin
				sys_v0 <= in_WB;
			end
			else begin
				sys_v0 <= in_R;
			end
		end
		else begin
			sys_v0 <= in_A;
		end

		if(in_SYSREDI[1]|in_SYSREDI[3])begin
			if(in_SYSREDI[3])begin
				sys_a0 <= in_WB;
			end
			else begin
				sys_a0 <= in_R;
			end
		end
		else begin
			sys_a0 <= in_B;
		end
	end

	BASEALU m_BASEALU(alu_X,alu_Y,in_ALUOP,,,out_equal,out_R,);
	SYSCALL m_SYSCALL(in_CLK,in_RST,in_syscall,sys_v0,sys_a0,out_syscallout,out_lock);
endmodule