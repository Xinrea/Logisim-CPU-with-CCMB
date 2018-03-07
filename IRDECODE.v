//==================================================================================================
//  Filename      : IRDECODE.v
//  Created On    : 2018-03-06 10:45:54
//  Last Modified : 2018-03-06 10:48:36
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module IRDECODE(in_code,out_addr);
	input [1:0]in_code;
	output reg [31:0]out_addr;
	initial begin
		out_addr = 0;
	end
	always @(*) begin
		case(in_code)//generate interrupt processing addr
			2'b00:out_addr <= 32'h0000;//45
			2'b01:out_addr <= 32'h00DB;//78
			2'b10:out_addr <= 32'h010E;//AB
			2'b11:out_addr <= 32'h0141;//DE
		endcase
	end
endmodule