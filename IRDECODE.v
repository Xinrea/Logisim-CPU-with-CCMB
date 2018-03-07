//==================================================================================================
//  Filename      : IRDECODE.v
//  Created On    : 2018-03-06 10:45:54
//  Last Modified : 2018-03-08 01:59:04
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
			2'b00:out_addr <= 32'h0000;//45//ac
			2'b01:out_addr <= 32'h00DB;//78//178
			2'b10:out_addr <= 32'h012B;//AB//224
			2'b11:out_addr <= 32'h017B;//DE//310
		endcase
	end
endmodule