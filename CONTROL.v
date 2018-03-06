//==================================================================================================
//  Filename      : CONTROL.v
//  Created On    : 2018-03-04 21:43:10
//  Last Modified : 2018-03-06 14:54:37
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module CONTROL(in_is,out_J,out_JW,out_JR,out_BEQ,out_BNE,out_BGEZ,
	out_MemWrite,out_half,out_syscall,out_IM,out_ALUmode,out_ALUinput,out_RegControl,out_cp0,out_cpw,out_eret);
	input [31:0]in_is;
	output out_J,out_JW,out_JR,out_BEQ,out_BNE,out_BGEZ,out_MemWrite,out_half,out_syscall,out_IM;
	output [3:0]out_ALUmode;
	output [3:0]out_ALUinput;
	output [4:0]out_RegControl;
	output out_cp0,out_cpw,out_eret;
	reg [5:0]instruction = 0;
	reg special = 0;
	always @(*) begin
		if(in_is[31:26] == 0) begin 
			special <= 1;
			instruction <= in_is[5:0];
		end
		else begin
			special <= 0;
			instruction <= in_is[31:26];
		end
	end
	JCONTROL m_JCONTROL(instruction,special,out_J,out_JW,out_JR,out_BEQ,out_BNE,out_BGEZ,out_MemWrite,out_half);
	ARCONTROL m_ARCONTROL(special,instruction,in_is[25:21],out_IM,out_ALUmode,out_ALUinput,out_RegControl,out_syscall,out_cp0,out_cpw);
endmodule