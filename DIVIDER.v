//==================================================================================================
//  Filename      : DIVIDER.v
//  Created On    : 2018-03-05 15:13:49
//  Last Modified : 2018-03-05 16:14:19
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module DIVIDER(clk_in,changef, clk_out);//加了个choose

input clk_in;//system clock, reset button
input changef;
output reg clk_out;
reg [31:0] cnt;//counter

initial
	begin
		clk_out = 0;
		cnt  = 0;
	end

always @(posedge clk_in) begin
			if(changef) begin
				if (cnt>=30)//actually 2500000 times
					begin
						clk_out <= ~clk_out;
						cnt <= 0;
					end
				else
					begin
						cnt <= cnt+1;
					end
			end
			else begin
				if (cnt>=2500000)//actually 2500000 times
					begin
						clk_out <= ~clk_out;
						cnt <= 0;
					end
				else
					begin
						cnt <= cnt+1;
					end
			end
end
endmodule