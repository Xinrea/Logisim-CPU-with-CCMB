//==================================================================================================
//  Filename      : SYSCALL.v
//  Created On    : 2018-03-05 08:46:16
//  Last Modified : 2018-03-05 08:54:53
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module SYSCALL(in_CLK,in_RST,in_syscall,in_v0,in_a0,out_display,out_lock);
	input in_CLK,in_RST,in_syscall;
	input [31:0]in_v0,in_a0;
	output reg [31:0]out_display;
	output reg out_lock = 0;
	always @(posedge in_CLK or posedge in_RST) begin
		if (in_RST) begin
			// reset
			out_display <= 0;
			
		end
		else if (~(in_v0 == 10)&in_syscall) begin
			out_display <= in_a0;
		end
		out_lock <= (in_v0 == 10)&in_syscall;
	end

endmodule