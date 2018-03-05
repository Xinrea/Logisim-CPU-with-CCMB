//==================================================================================================
//  Filename      : ARCONTROL.v
//  Created On    : 2018-03-04 20:47:40
//  Last Modified : 2018-03-05 17:05:28
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module ARCONTROL(in_special,in_func,out_IM,out_alumode,out_aluin,out_regcontrol,out_syscall);
    input in_special;
    input [5:0]in_func;
    output reg out_IM = 0;
    output reg [3:0]out_alumode = 0;
    output reg [3:0]out_aluin = 0;
    output reg [4:0]out_regcontrol = 0;
    output reg out_syscall = 0;
    //添加指令及信号，请区分指令类型进行添加
    always @(*) begin
        if(in_special) begin
            case(in_func)
                6'b100000:begin//add
                    out_IM <= 0;
                    out_alumode <= 4'b0101;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                end
                6'b100001:begin//addu
                    out_IM <= 0;
                    out_alumode <= 4'b0101;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                end
                6'b100100:begin//and
                    out_IM <= 0;
                    out_alumode <= 4'b0111;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                end
                6'b100111:begin//nor
                    out_IM <= 0;
                    out_alumode <= 4'b1010;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                end
                6'b100101:begin//or
                    out_IM <= 0;
                    out_alumode <= 4'b1000;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                end
                6'b000000:begin//sll
                    out_alumode <= 4'b0000;
                    out_aluin <= 4'b1000;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                    out_IM <= 0;
                end
                6'b000011:begin//sra
                    out_alumode <= 4'b0001;
                    out_aluin <= 4'b1000;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                    out_IM <= 0;
                end
                6'b000010:begin//srl
                    out_alumode <= 4'b0010;
                    out_aluin <= 4'b1000;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                    out_IM <= 0;
                end
                6'b100010:begin//sub
                    out_alumode <= 4'b0110;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                    out_IM <= 0;
                end
                6'b001000:begin//jr
                    out_alumode <= 4'b0000;
                    out_aluin <= 4'b0000;
                    out_regcontrol <= 5'b00000;
                    out_syscall <= 0;
                    out_IM <= 0;
                end
                6'b001100:begin//syscall
                    out_alumode <= 4'b0000;
                    out_aluin <= 4'b0000;
                    out_regcontrol <= 5'b00000;
                    out_syscall <= 1;
                    out_IM <= 0;
                end
                6'b101010:begin//slt
                    out_alumode <= 4'b1011;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                    out_IM <= 0;
                end
                6'b101011:begin//sltu
                    out_alumode <= 4'b1011;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                    out_IM <= 0;
                end
                6'b000110:begin//srlv
                    out_alumode <= 4'b0010;
                    out_aluin <= 4'b1100;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                    out_IM <= 0;
                end
                6'b100110:begin//xor
                    out_alumode <= 4'b1001;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                    out_IM <= 0;
                end
            endcase
        end
        else begin
            case(in_func)
                6'b001000:begin//addi
                    out_alumode <= 4'b0101;
                    out_aluin <= 4'b0001;
                    out_regcontrol <= 5'b01110;
                    out_syscall <= 0;
                    out_IM <= 1;
                end
                6'b001001:begin//addiu
                    out_alumode <= 4'b0101;
                    out_aluin <= 4'b0001;
                    out_regcontrol <= 5'b01110;
                    out_syscall <= 0;
                    out_IM <= 0;
                end
                6'b001100:begin//andi
                    out_alumode <= 4'b0111;
                    out_aluin <= 4'b0001;
                    out_regcontrol <= 5'b01110;
                    out_syscall <= 0;
                    out_IM <= 0;
                end
                6'b001101:begin//ori
                    out_alumode <= 4'b1000;
                    out_aluin <= 4'b0001;
                    out_regcontrol <= 5'b01110;
                    out_syscall <= 0;
                    out_IM <= 0;
                end
                6'b000100:begin//beq
                    out_alumode <= 4'b0000;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b00000;
                    out_syscall <= 0;
                    out_IM <= 1;
                end
                6'b000101:begin//bne
                    out_alumode <= 4'b0000;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b00000;
                    out_syscall <= 0;
                    out_IM <= 1;
                end
                6'b000010:begin//j
                    out_alumode <= 4'b0000;
                    out_aluin <= 4'b0000;
                    out_regcontrol <= 5'b00000;
                    out_syscall <= 0;
                    out_IM <= 0;
                end
                6'b000011:begin//jal
                    out_alumode <= 4'b0000;
                    out_aluin <= 4'b0000;
                    out_regcontrol <= 5'b00100;
                    out_syscall <= 0;
                    out_IM <= 0;
                end
                6'b100011:begin//lw
                    out_alumode <= 4'b0101;
                    out_aluin <= 4'b0001;
                    out_regcontrol <= 5'b10110;
                    out_syscall <= 0;
                    out_IM <= 1;
                end
                6'b101011:begin//sw
                    out_alumode <= 4'b0101;
                    out_aluin <= 4'b0001;
                    out_regcontrol <= 5'b00000;
                    out_syscall <= 0;
                    out_IM <= 1;
                end
                6'b001010:begin//slti
                    out_alumode <= 4'b1011;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b01110;
                    out_syscall <= 0;
                    out_IM <= 1;
                end
                6'b100101:begin//lhu
                    out_alumode <= 4'b0101;
                    out_aluin <= 4'b0001;
                    out_regcontrol <= 5'b10110;
                    out_syscall <= 0;
                    out_IM <= 1;
                end
                6'b000001:begin//bgez
                    out_alumode <= 4'b1011;
                    out_aluin <= 4'b0000;
                    out_regcontrol <= 5'b00000;
                    out_syscall <= 0;
                    out_IM <= 1;
                end
            endcase
        end
    end
endmodule