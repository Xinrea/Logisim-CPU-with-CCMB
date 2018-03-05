//==================================================================================================
//  Filename      : counter.v
//  Created On    : 2018-03-05 15:22:09
//  Last Modified : 2018-03-05 16:15:46
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module counter(in_EN,in_CLK,in_RST,in_J,in_JS,in_loaduse,out_total,out_J,out_JS,out_loaduse);
    input in_EN,in_CLK,in_RST,in_J,in_JS,in_loaduse;
    output reg [31:0]out_total;
    output reg [31:0]out_J;
    output reg [31:0]out_JS;
    output reg [31:0]out_loaduse;
    reg flag;
    initial begin
        out_total=0;
        out_J=0;
        out_JS=0;
        out_loaduse=0;
        flag=0;
    end

    always @(posedge in_CLK)begin
        if(in_RST)begin 
            flag=0;
            out_total=0;
            out_J=0;
            out_JS=0;
            out_loaduse=0;
        end
        else begin
            if(in_EN)begin
                out_total=out_total+1; 
                flag=0;
            end
            else if(!in_EN&&(flag == 0))begin
                out_total=out_total+1; 
                flag=1;
            end
            if(in_J)out_J=out_J+1;
            if(in_JS)out_JS=out_JS+1;
            if(in_loaduse)out_loaduse=out_loaduse+1;
        end

    end
endmodule
