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
module INTERRUPT(in_RST,in_IR,in_IG,in_INM,in_IE,out_code,out_break,out_leds);
	input in_RST;
	input [3:0]in_IR,in_IG;
	input [3:0]in_INM;
	output [2:0]out_leds;
	input in_IE;
	output reg [1:0]out_code;
	output reg out_break;
	reg [3:0]IR;
	assign out_leds[0] = IR[0];
	assign out_leds[1] = IR[1];
	assign out_leds[2] = IR[2];
	initial begin
		IR <= 0;
	end
	always @(posedge in_IR[0] or posedge in_IG[0] or posedge in_RST) begin
		if(in_IR[0])IR[0] <= 1;
		else if(in_IG[0])IR[0] <= 0;
		else if(in_RST)IR[0] <= 0;
	end

	always @(posedge in_IR[1] or posedge in_IG[1] or posedge in_RST) begin
		if(in_IR[1])IR[1] <= 1;
		else if(in_IG[1])IR[1] <= 0;
		else if(in_RST)IR[1] <= 0;
	end

	always @(posedge in_IR[2] or posedge in_IG[2] or posedge in_RST) begin
		if(in_IR[2])IR[2] <= 1;
		else if(in_IG[2])IR[2] <= 0;
		else if(in_RST)IR[2] <= 0;
	end

	always @(posedge in_IR[3] or posedge in_IG[3] or posedge in_RST) begin
		if(in_IR[3])IR[3] <= 1;
		else if(in_IG[3])IR[3] <= 0;
		else if(in_RST)IR[3] <= 0;
	end

	always @(*) begin//优先编码
		if(IR[3]&~in_INM[3])begin
			out_code <= 2'b11;
			out_break <= in_IE;
		end
		else begin
			if(IR[2]&~in_INM[2])begin
				out_code <= 2'b10;
				out_break <= in_IE;
			end
			else begin
				if(IR[1]&~in_INM[1])begin
					out_code <= 2'b01;
					out_break <= in_IE;
				end
				else begin
					if(IR[0]&~in_INM[0])begin
						out_code <= 2'b00;
						out_break <= in_IE;
					end
					else begin
						out_code <= 2'b00;
						out_break <= 0;
					end
				end
			end
		end
	end
endmodule