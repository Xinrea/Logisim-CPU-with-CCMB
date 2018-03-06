//==================================================================================================
//  Filename      : MINT.v
//  Created On    : 2018-03-06 10:49:50
//  Last Modified : 2018-03-06 16:41:34
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module MINT(in_CLK,in_RST,in_code,in_BK,in_eret,in_EPC,in_FDCLR,in_DECLR,R_FDCLR,R_DECLR,R_EECLR,out_force,out_pc,out_IG,out_NIE);
	input in_CLK,in_RST;
	input [1:0]in_code;
	input in_BK,in_eret;
	input [31:0]in_EPC;
	input in_FDCLR,in_DECLR;
	output R_FDCLR,R_DECLR,R_EECLR;
	output out_force;
	output reg [31:0]out_pc;
	output [3:0]IG;
	output reg out_NIE;
	reg [1:0]rcode;
	wire [31:0]int_addr;

	always @(*) begin
		if(in_BK)begin
			out_NIE <= 0;//		
		end

		if(in_eret)begin
			out_pc <= int_addr;
			out_NIE <= 1;
			case(rcode)
				2'b00:IG <= 4'b0001;
				2'b01:IG <= 4'b0010;
				2'b10:IG <= 4'b0100;
				2'b11:IG <= 4'b1000;
			endcase
		end
		else begin
			out_pc <= in_EPC;
			out_NIE <= 1;
			IG <= 0;
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