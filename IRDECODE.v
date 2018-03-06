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
	output reg out_addr;
	alwasy @(*) begin
		case(in_code)//generate interrupt processing addr
			2'b00:out_addr <= 4'h0000;
			2'b01:out_addr <= 4'h0000;
			2'b10:out_addr <= 4'h0000;
			2'b11:out_addr <= 4'h0000;
		endcase
	end
endmodule