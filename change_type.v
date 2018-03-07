`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/02/26 16:22:20
// Design Name: 
// Module Name: change_type
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module change_type(clk,SyscallOut,Mdata,PC,all_time,j_change,loaduse,b_change_success,chose_out);
input clk;
input [31:0]SyscallOut; //
input [31:0]Mdata;
input [31:0]PC;   //ÊäÈëpcµÄÖµ
input [31:0]all_time;  //16Î»ÖÜÆÚÊý
input [31:0]j_change;  //ÎÞÌõ¼þ·ÖÖ§Ö¸ÁîÊý
input [31:0]loaduse;  //ÓÐÌõ¼þ·ÖÖ§Ö¸ÁîÊý
input [31:0]b_change_success ;  //ÓÐÌõ¼þ·ÖÖ§×ªÒÆ³É¹¦Êý
//input reset;  //×Ü¿ª¹Ø

output reg [31:0]chose_out;   //31Î»µÄÊýÂë¹ÜÏÔÊ¾Êý¾Ý

always @(*)
begin
    chose_out <= SyscallOut;
end

endmodule
