`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/02/26 14:11:04
// Design Name: 
// Module Name: led
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
module led(reset,pro_reset,in_addr,leds);
input reset; //×Ü¿ª¹Ø£¬Êý¾ÝÕý³£ÏÔÊ¾
input [2:0]pro_reset;   //3¸ö¿ª¹Ø×éºÏÀ´Ñ¡Ôñ¸÷ÖÖ²ÎÊý£º±ÈÈçPCµÄÖµ£¬±ÈÈçÊ±ÖÓÖÜÆÚÊý£¬ÓÐÌõ¼þ·ÖÖ§×ªÒÆÊýµÈµÈ
//001´ú±í²é¿´pcÖµ
//010´ú±í²é¿´ÖÜÆÚÊý
//011´ú±í²é¿´ÓÐÌõ¼þ·ÖÖ§×ªÒÆÊý
//100´ú±í²é¿´ÓÐÌõ¼þ·ÖÖ§×ªÒÆ³É¹¦Êý
//101´ú±í²é¿´ÎÞÌõ¼þ·ÖÖ§Ö¸ÁîÊý
input [11:0]in_addr;    //µØÖ·ÊäÈë²¦Âë¿ª¹Ø,12Î»µØÖ·Öµ£¬×Ü¹²4KµÄÄÚ´æ
output [15:0]leds;  //16Î»µÄledµÆµÄÏÔÊ¾

assign leds[15]=reset;  //ÖØÖÃÖ¸Ê¾µÆ,×î×ó±ß

assign leds[14:3]=in_addr;  //ÏÔÊ¾µØÖ·ÖµµÄledµÆ

endmodule
