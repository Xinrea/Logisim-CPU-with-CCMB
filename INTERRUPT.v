//==================================================================================================
//  Filename      : INTERRUPT.v
//  Created On    : 2018-03-06 09:39:33
//  Last Modified : 2018-03-06 15:26:19
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module INTERRUPT(in_RST,in_CLK,in_IR,in_IG,in_INM,in_IE,out_code,out_break,IR);
	input in_RST,in_CLK;
	input [2:0]in_IR;
	input [3:0]in_IG;
	input [3:0]in_INM;
	input in_IE;
	output reg [1:0]out_code;
	output reg out_break;
	output reg [2:0]IR;
	reg [2:0]rIR;
	initial begin
		IR <= 0;
	end

	always @(posedge in_CLK) begin
		rIR = in_IR;
	end
	always @(posedge rIR[0] or posedge in_RST or posedge in_IG[0]) begin
		if(in_RST)IR[0] = 0;
		else if(in_IG[0])IR[0] = 0;
		else IR[0] = 1;
	end

	always @(posedge rIR[1] or posedge in_RST or posedge in_IG[1]) begin
		if(in_RST)IR[1] = 0;
		else if(in_IG[1])IR[1] = 0;
		else IR[1] = 1;
	end

	always @(posedge rIR[2] or posedge in_RST or posedge in_IG[2]) begin
		if(in_RST)IR[2] = 0;
		else if(in_IG[2])IR[2] = 0;
		else IR[2] = 1;
	end

	// always @(posedge in_IR[3] or posedge in_RST or posedge in_IG[3]) begin
	// 	if(in_RST)IR[3] <= 0;
	// 	else if(in_IG[3])IR[3] <= 0;
	// 	else if(in_IR[3])IR[3] <= 1;
	// end

	always @(*) begin//优先编码
		if(IR[2]&~in_INM[2])begin
			out_code <= 2'b11;
			out_break <= in_IE;
		end
		else begin
			if(IR[1]&~in_INM[1])begin
				out_code <= 2'b10;
				out_break <= in_IE;
			end
			else begin
				if(IR[0]&~in_INM[0])begin
					out_code <= 2'b01;
					out_break <= in_IE;
				end
				else begin
					out_code <= 2'b00;
					out_break <= 0;
				end
			end
		end
	end
endmodule