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
module change_type(clk,SyscallOut,Mdata,PC,all_time,j_change,loaduse,b_change_success,pro_reset,chose_out);
input clk;
input [31:0]SyscallOut; //
input [31:0]Mdata;
input [31:0]PC;   //ÊäÈëpcµÄÖµ
input [31:0]all_time;  //16Î»ÖÜÆÚÊý
input [31:0]j_change;  //ÎÞÌõ¼þ·ÖÖ§Ö¸ÁîÊý
input [31:0]loaduse;  //ÓÐÌõ¼þ·ÖÖ§Ö¸ÁîÊý
input [31:0]b_change_success ;  //ÓÐÌõ¼þ·ÖÖ§×ªÒÆ³É¹¦Êý
//input reset;  //×Ü¿ª¹Ø
input [2:0]pro_reset;   //3¸ö¿ª¹Ø×éºÏÀ´Ñ¡Ôñ¸÷ÖÖ²ÎÊý

output reg [31:0]chose_out;   //31Î»µÄÊýÂë¹ÜÏÔÊ¾Êý¾Ý

always @(posedge clk)
begin
   case(pro_reset)
    3'b001:begin
      chose_out[31:0]<=PC;
    end
    3'b010:begin
      chose_out[31:0]<=all_time;
    end
    3'b011:begin
      chose_out[31:0]<=j_change;
    end
    3'b100:begin
      chose_out[31:0]<=b_change_success;
    end
    3'b101:begin
      chose_out[31:0]<=loaduse;
    end
    3'b110:begin
      chose_out[31:0]<=Mdata;
    end
    default:chose_out <= SyscallOut;
  endcase
end

endmodule
