//==================================================================================================
//  Filename      : MINT.v
//  Created On    : 2018-03-06 10:49:50
//  Last Modified : 2018-03-08 03:03:59
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module MINT(in_CLK,in_DCLK,in_RST,in_code,in_BK,in_eret,in_EPC,in_FDCLR,in_DECLR,R_FDCLR,R_DECLR,R_EECLR,out_force,out_pc,out_IG,out_NIE);
	input in_CLK,in_DCLK,in_RST;
	input [1:0]in_code;
	input in_BK,in_eret;
	input [31:0]in_EPC;
	input in_FDCLR,in_DECLR;
	output R_FDCLR,R_DECLR,R_EECLR;
	output reg out_force;
	output reg [31:0]out_pc;
	output reg [3:0]out_IG;
	output reg out_NIE;
	reg [1:0]rcode;
	wire [31:0]int_addr;
	wire flag;
	assign flag = in_code[0]|in_code[1];
	initial out_IG <= 0;

	assign R_FDCLR = in_FDCLR|in_RST|in_BK|in_eret;
	assign R_DECLR = in_DECLR|in_RST|in_BK|in_eret;
	assign R_EECLR = in_RST|in_BK|in_eret;

	always @(posedge in_CLK or posedge flag) begin
		if(in_BK)begin
			out_NIE <= 0;//		
			out_force <= 1;
			out_IG <= 0;
			if(rcode[0]|rcode[1])out_pc <= in_EPC;
			else out_pc <= int_addr;
		end
		else begin
			if(in_eret)begin
				out_pc <= in_EPC;
				out_force <= 1;
				out_NIE <= 1;
				case(rcode)
					2'b00:out_IG <= 4'b0000;
					2'b01:out_IG <= 4'b0001;
					2'b10:out_IG <= 4'b0010;
					2'b11:out_IG <= 4'b0100;
				endcase
			end
			else begin
				out_force <= 0;
				out_NIE <= 1;
				out_IG <= 0;
				out_pc <= in_EPC;
			end
		end
	end

	always @(posedge in_CLK or posedge in_RST) begin
		if (in_RST) begin
			// reset
			rcode = 0;
		end
		else if(in_BK) begin
			rcode = in_code;
		end
	end

	IRDECODE m_IRDECODE(rcode,int_addr);

endmodule