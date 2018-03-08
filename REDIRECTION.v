//==================================================================================================
//  Filename      : REDIRECTION.v
//  Created On    : 2018-03-05 09:46:04
//  Last Modified : 2018-03-08 09:36:59
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
	output reg [3:0]out_ALUREDI;
	output [3:0]out_SYSREDI;
	output reg [1:0]out_CSW;
	output out_CLW;
	initial begin
		out_DECLR <= 0;
		out_FDCLR <= 0;
		out_BEN <= 1;
	end
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

	reg S1;
	reg rBEN;

	always @(*) begin
		S1 = (in_IS==12)&(PRT==4|PRT==2);
		if(OP == 0)begin
			out_BEN <= ~(((PRT==RT|PRT==RS)|S1)&(POP==6'b100011|POP==6'b100101))&in_EN;
		end
		else begin
			out_BEN <= ~(((PRT==RS)|S1)&(POP==6'b100011|POP==6'b100101))&in_EN;
		end
	end

	always @(negedge in_CLK) begin
		rBEN <= out_BEN;
	end

	always @(posedge in_CLK or posedge rBEN) begin
		if (rBEN) begin
			// reset
			out_DECLR <= 0;
		end
		else begin
			if(OP == 0)begin
				out_DECLR <= (((PRT==RT|PRT==RS)|S1)&(POP==6'b100011|POP==6'b100101))|in_RST;
			end
			else begin
				out_DECLR <= (((PRT==RS)|S1)&(POP==6'b100011|POP==6'b100101))|in_RST;
			end
		end
	end

	reg rJJS;
	always @(posedge in_CLK) begin
		rJJS <= in_J|in_JS;
	end

	always @(negedge in_CLK or posedge rJJS) begin
		if (rJJS) begin
			// reset
			out_FDCLR <= 0;
			out_PEN <= 1;
		end
		else begin
			out_FDCLR <= in_J|in_JS;
			out_PEN <= ~(in_J|in_JS);
		end
	end

	assign out_CLW = PPPOP==6'b100011|PPPOP==6'b100101;

	wire shift_is;
	wire [1:0]choose,choose2;
	assign shift_is = POP==0&(PFUNCT==0|PFUNCT==2|PFUNCT==3|PFUNCT==6);
	assign choose[0] = PPOP==0;
	assign choose[1] = POP==0;
	assign choose2[0] = PPPOP==0;
	assign choose2[1] = POP==0;

	wire IGNORE,IGNORE2,BIS;
	assign IGNORE = ~(PPOP==5|PPOP==4)|~(in_PPIS==12);
	assign IGNORE2 = ~(PPPOP==5|PPPOP==4)|~(in_PPPIS==12);
	//B instructions
	assign BIS = POP==5|POP==4;

	always @(*) begin
		case(choose)
			2'b00:begin
				out_ALUREDI[0] <= ((PPRT==PRS)^(shift_is)) & (in_PPWE&IGNORE&(BIS|(PPRT==PRS&~(in_PIS==0)&~(in_PPIS==0))));
				if(BIS)begin
					out_ALUREDI[1] <= ((PPRT==PRT)^(shift_is))&(in_PPWE&IGNORE&(BIS|(PPRT==PRS&~(in_PIS==0)&~(in_PPIS==0))));
				end
				else begin
					out_ALUREDI[1] <= ((0)^(shift_is))&(in_PPWE&IGNORE&(BIS|(PPRT==PRS&~(in_PIS==0)&~(in_PPIS==0))));
				end
			end
			2'b01:begin
				out_ALUREDI[0] <= ((PPRD==PRS)^(shift_is))&(in_PPWE&IGNORE&(BIS|(PPRD==PRS&~(in_PIS==0)&~(in_PPIS==0))));
				out_ALUREDI[1] <= ((0)^(shift_is))&(in_PPWE&IGNORE&(BIS|(PPRT==PRS&~(in_PIS==0)&~(in_PPIS==0))));
			end
			2'b10:begin
				out_ALUREDI[0] <= (((PPRT==PRS))^(shift_is))&(in_PPWE&IGNORE&(BIS|((PPRT==PRT|PPRT==PRS)&~(in_PIS==0)&~(in_PPIS==0))));
				out_ALUREDI[1] <= ((PPRT==PRT)^(shift_is))&(in_PPWE&IGNORE&(BIS|((PPRT==PRT|PPRT==PRS)&~(in_PIS==0)&~(in_PPIS==0))));
			end
			2'b11:begin
				out_ALUREDI[0] <= (((PPRD==PRS))^(shift_is))&(in_PPWE&IGNORE&(BIS|((PPRD==PRT|PPRD==PRS)&~(in_PIS==0)&~(in_PPIS==0))));
				out_ALUREDI[1] <= ((PPRD==PRT)^(shift_is))&(in_PPWE&IGNORE&(BIS|((PPRD==PRT|PPRD==PRS)&~(in_PIS==0)&~(in_PPIS==0))));
			end
		endcase
	end

	always @(*) begin
		case(choose2)
			2'b00:begin
				if(~(in_PPIS==0)&PPPRT==PPRT&~(PPOP == 6'B101011))begin
					out_ALUREDI[2] <= 0;
				end
				else out_ALUREDI[2] <= ((PPPRT==PRS)^(shift_is))&(in_PPPWE&IGNORE2&((PPPRT==PRS&~(in_PIS==0)&~(in_PPPIS==0))));
				if(~(in_PPIS==0)&PPPRD==PPRD)begin
					out_ALUREDI[3] <= 0;
				end
				else out_ALUREDI[3] <= ((0)^(shift_is))&(in_PPPWE&IGNORE2&((PPPRT==PRS&~(in_PIS==0)&~(in_PPPIS==0))));
			end
			2'b01:begin
				if(~(in_PPIS==0)&PPPRT==PPRT&~(PPOP == 6'B101011))begin
					out_ALUREDI[2] <= 0;
				end
				else out_ALUREDI[2] <= ((PPPRD==PRS)^(shift_is))&(in_PPPWE&IGNORE2&((PPPRD==PRS&~(in_PIS==0)&~(in_PPPIS==0))));
				if(~(in_PPIS==0)&PPPRD==PPRD)begin
					out_ALUREDI[3] <= 0;
				end
				else out_ALUREDI[3] <= ((0)^(shift_is))&(in_PPPWE&IGNORE2&((PPPRD==PRS&~(in_PIS==0)&~(in_PPPIS==0))));
			end
			2'b10:begin
				if(~(in_PPIS==0)&PPPRT==PPRT&~(PPOP == 6'B101011))begin
					out_ALUREDI[2] <= 0;
				end
				else out_ALUREDI[2] <= (((PPPRT==PRS))^(shift_is))&(in_PPPWE&IGNORE2&(((PPPRT==PRT|PPPRT==PRS)&~(in_PIS==0)&~(in_PPPIS==0))));
				if(~(in_PPIS==0)&PPPRD==PPRD)begin
					out_ALUREDI[3] <= 0;
				end
				else out_ALUREDI[3] <= ((PPPRT==PRT)^(shift_is))&(in_PPPWE&IGNORE2&(((PPPRT==PRS|PPPRT==PRT)&~(in_PIS==0)&~(in_PPPIS==0))));
			end
			2'b11:begin
				if(~(in_PPIS==0)&PPPRT==PPRT&~(PPOP == 6'B101011))begin
					out_ALUREDI[2] <= 0;
				end
				else out_ALUREDI[2] <= (((PPPRD==PRS))^(shift_is))&(in_PPPWE&IGNORE2&(((PPPRD==PRT|PPPRT==PRS)&~(in_PIS==0)&~(in_PPPIS==0))));
				if(~(in_PPIS==0)&PPPRD==PPRD)begin
					out_ALUREDI[3] <= 0;
				end
				else out_ALUREDI[3] <= ((PPPRD==PRT)^(shift_is))&(in_PPPWE&IGNORE2&(((PPPRD==PRS|PPPRD==PRT)&~(in_PIS==0)&~(in_PPPIS==0))));
			end
		endcase
	end

	assign out_SYSREDI[0] = ((in_PIS==12)&((PPRT==4|PPRD==4)|(PPRT==2|PPRD==2)))&(PPRT==2|PPRD==2);
	assign out_SYSREDI[1] = ((in_PIS==12)&((PPRT==4|PPRD==4)|(PPRT==2|PPRD==2)))&(PPRT==4|PPRD==4);
	assign out_SYSREDI[2] = ((in_PIS==12)&((PPPRT==4|PPPRD==4)|(PPPRT==2|PPPRD==2)))&(PPPRT==2|PPPRD==2);
	assign out_SYSREDI[3] = ((in_PIS==12)&((PPPRT==4|PPPRD==4)|(PPPRT==2|PPPRD==2)))&(PPPRT==4|PPPRD==4);

	always @(*) begin
		if(PPOP==0)begin
			out_CSW[0] <= POP==6'b101011&in_PPWE&IGNORE&(~(in_PIS==0)&~(in_PPIS==0))&(PPRD==PRT);
		end
		else begin
			out_CSW[0] <= POP==6'b101011&in_PPWE&IGNORE&(~(in_PIS==0)&~(in_PPIS==0))&(PPRT==PRT);
		end
	end

	always @(*) begin
		if(PPPOP==0)begin
			out_CSW[1] <= POP==6'b101011&in_PPPWE&IGNORE2&(~(in_PIS==0)&~(in_PPPIS==0))&(PPPRD==PRT);
		end
		else begin
			out_CSW[1] <= POP==6'b101011&in_PPPWE&IGNORE2&(~(in_PIS==0)&~(in_PPPIS==0))&(PPPRT==PRT);
		end
	end
endmodule