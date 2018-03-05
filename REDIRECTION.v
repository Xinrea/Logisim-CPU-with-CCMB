//==================================================================================================
//  Filename      : REDIRECTION.v
//  Created On    : 2018-03-05 09:46:04
//  Last Modified : 2018-03-05 10:03:12
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module REDIRECTION(in_EN,in_CLK,in_RST,in_J,in_JS,in_PPWE,in_PPPWE,in_IS,in_PIS,in_PPIS,in_PPPIS,
	out_DECLR,out_FDCLR,out_BEN,out_PEN,out_ALUREDI,out_SYSREDI,out_CSW,out_CLW);
	input in_EN,in_CLK,in_RST,in_J,in_JS,in_PPWE,in_PPPWE;
	input [31:0]in_IS,in_PIS,in_PPIS,in_PPPIS;
	output reg out_DECLR,out_FDCLR,out_BEN,out_PEN;
	output reg [3:0]out_ALUREDI,out_SYSREDI;
	output reg [1:0]out_CSW;
	output reg CLW;
	
	wire [5:0]FUNCT;
	wire [4:0]RD;
	wire [4:0]RT;
	wire [4:0]RS;
	wire [5:0]OP;
	assign FUNCT = in_IS[5:0];
	assign RD = in_IS[15:11];
	assign RT = in_IS[20:16];
	assign RS = in_IS[25:21];
	assign OP = in_IS[31:26];

	wire [5:0]PFUNCT;
	wire [4:0]PRD;
	wire [4:0]PRT;
	wire [4:0]PRS;
	wire [5:0]POP;
	assign PFUNCT = in_PIS[5:0];
	assign PRD = in_PIS[15:11];
	assign PRT = in_PIS[20:16];
	assign PRS = in_PIS[25:21];
	assign POP = in_PIS[31:26];

	wire [5:0]PPFUNCT;
	wire [4:0]PPRD;
	wire [4:0]PPRT;
	wire [4:0]PPRS;
	wire [5:0]PPOP;
	assign PPFUNCT = in_PPIS[5:0];
	assign PPRD = in_PPIS[15:11];
	assign PPRT = in_PPIS[20:16];
	assign PPRS = in_PPIS[25:21];
	assign PPOP = in_PPIS[31:26];

	wire [5:0]PPPFUNCT;
	wire [4:0]PPPRD;
	wire [4:0]PPPRT;
	wire [4:0]PPPRS;
	wire [5:0]PPPOP;
	assign PPPFUNCT = in_PPPIS[5:0];
	assign PPPRD = in_PPPIS[15:11];
	assign PPPRT = in_PPPIS[20:16];
	assign PPPRS = in_PPPIS[25:21];
	assign PPPOP = in_PPPIS[31:26];

	
endmodule