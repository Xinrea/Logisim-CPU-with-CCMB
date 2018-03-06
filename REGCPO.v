//==================================================================================================
//  Filename      : REGCPO.v
//  Created On    : 2018-03-06 10:30:48
//  Last Modified : 2018-03-06 14:47:09
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module REGCP0(in_CLK,WE,rW,W,rA,A,EPC);

	input in_CLK;
	input WE;
	input [1:0]rW;
	input [31:0]W;
	input [2:0]rA;
	output [31:0]A;
	output [31:0]EPC;
	// 0 for IE
	// 1 for INM
	// 2 for EPC
	reg [31:0]CP0[2:0];

	assign A = CP0[rA];
	assign EPC = CP0[2];

	always @(posedge in_CLK) begin
		if(WE)begin
			CP0[rW] <= W;
		end
	end

endmodule