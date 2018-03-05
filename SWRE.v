//==================================================================================================
//  Filename      : SWRE.v
//  Created On    : 2018-03-05 11:46:33
//  Last Modified : 2018-03-05 16:43:28
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module SWRE(in_CSW,in_B,in_R,in_WB,out_B);
	input [1:0]in_CSW;
	input [31:0]in_B,in_R,in_WB;
	output reg [31:0]out_B;

	always @(*) begin
		case(in_CSW)
			2'b00:out_B <= in_B;
			2'b01:out_B <= in_R;
			2'b10:out_B <= in_WB;
			2'b11:out_B <= in_R;
			default:out_B <= 0;
		endcase
	end
endmodule