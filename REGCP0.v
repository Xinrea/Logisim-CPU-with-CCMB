//==================================================================================================
//  Filename      : REGCPO.v
//  Created On    : 2018-03-06 10:30:48
//  Last Modified : 2018-03-06 16:35:24
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module REGCP0(in_RST,in_CLK,WE,rW,W,rA,A,out_IE,out_INM,in_BK,in_NIE,in_WB_PC,out_EPC,in_eret);

	input in_CLK,in_RST;
	input WE;
	input [1:0]rW;
	input [31:0]W;
	input [1:0]rA;
	input in_BK,in_NIE;
	input [31:0]in_WB_PC;
	input in_eret;
	output [31:0]A;
	output out_IE;
	output [3:0]out_INM;
	output [31:0]out_EPC;
	// 0 for IE
	// 1 for INM
	// 2 for EPC
	reg [31:0]CP0[2:0];

	initial begin
		CP0[0] <= 1;
		CP0[1] <= 0;
		CP0[2] <= 0;
	end

	always @(posedge in_CLK or posedge in_RST) begin
		if(in_RST)begin
			CP0[0] <= 1;
			CP0[1] <= 0;
			CP0[2] <= 0;
		end
		else if(in_BK) begin
			CP0[0][0] <= in_NIE;
			CP0[0][31:1] <= 0;
			CP0[2] <= in_WB_PC + 1;
		end
		else begin
			if(in_eret)begin
				CP0[0][0] <= in_NIE;
				CP0[0][31:1] <= 0;
			end
			if(WE&&(rW == 1))begin
				CP0[rW] <= W;
			end
		end
	end

	assign A = CP0[rA];
	assign out_IE = CP0[0][0];
	assign out_INM = CP0[1][3:0];
	assign out_EPC = CP0[2];


endmodule