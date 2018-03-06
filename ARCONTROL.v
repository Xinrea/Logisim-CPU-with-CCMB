//==================================================================================================
//  Filename      : ARCONTROL.v
//  Created On    : 2018-03-04 20:47:40
//  Last Modified : 2018-03-06 14:53:53
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module ARCONTROL(in_special,in_func,in_cp0,out_IM,out_alumode,out_aluin_,out_regcontrol,out_syscall,out_cp0,out_cpw,out_eret);
    input in_special;
    input [5:0]in_func;
    input [4:0]in_cp0;
    output reg out_IM = 0;
    output reg [3:0]out_alumode = 0;
    output reg [3:0]out_aluin_ = 0;
    output reg [4:0]out_regcontrol = 0;
    output reg out_syscall = 0;
    output reg out_cp0 = 0;
    output reg out_cpw = 0;
    output reg out_eret = 0;
    reg [3:0]out_aluin;

    //添加指令及信号，请区分指令类型进行添加
    always @(*) begin
        out_aluin_[0] <= out_aluin[3];
        out_aluin_[1] <= out_aluin[2];
        out_aluin_[2] <= out_aluin[1];
        out_aluin_[3] <= out_aluin[0];
        if(in_special) begin
            case(in_func)
                6'b100000:begin//add#
                    out_IM <= 0;
                    out_alumode <= 4'b0101;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b100001:begin//addu#
                    out_IM <= 0;
                    out_alumode <= 4'b0101;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b100100:begin//and#
                    out_IM <= 0;
                    out_alumode <= 4'b0111;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b100111:begin//nor#
                    out_IM <= 0;
                    out_alumode <= 4'b1010;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b100101:begin//or#
                    out_IM <= 0;
                    out_alumode <= 4'b1000;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b000000:begin//sll
                    out_alumode <= 4'b0000;
                    out_aluin <= 4'b1000;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                    out_IM <= 0;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b000011:begin//sra
                    out_alumode <= 4'b0001;
                    out_aluin <= 4'b1000;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                    out_IM <= 0;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b000010:begin//srl
                    out_alumode <= 4'b0010;
                    out_aluin <= 4'b1000;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                    out_IM <= 0;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b100010:begin//sub#
                    out_alumode <= 4'b0110;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                    out_IM <= 0;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b001000:begin//jr
                    out_alumode <= 4'b0000;
                    out_aluin <= 4'b0000;
                    out_regcontrol <= 5'b00000;
                    out_syscall <= 0;
                    out_IM <= 0;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b001100:begin//syscall
                    out_alumode <= 4'b0000;
                    out_aluin <= 4'b0000;
                    out_regcontrol <= 5'b00000;
                    out_syscall <= 1;
                    out_IM <= 0;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b101010:begin//slt#
                    out_alumode <= 4'b1011;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                    out_IM <= 0;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b101011:begin//sltu
                    out_alumode <= 4'b1011;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                    out_IM <= 0;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b000110:begin//srlv#
                    out_alumode <= 4'b0010;
                    out_aluin <= 4'b1100;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                    out_IM <= 0;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b100110:begin//xor#
                    out_alumode <= 4'b1001;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b01101;
                    out_syscall <= 0;
                    out_IM <= 0;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
            endcase
        end
        else begin
            case(in_func)
                6'b001000:begin//addi#
                    out_alumode <= 4'b0101;
                    out_aluin <= 4'b0001;
                    out_regcontrol <= 5'b10101;
                    out_syscall <= 0;
                    out_IM <= 1;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b001001:begin//addiu#
                    out_alumode <= 4'b0101;
                    out_aluin <= 4'b0001;
                    out_regcontrol <= 5'b10101;
                    out_syscall <= 0;
                    out_IM <= 0;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b001100:begin//andi#
                    out_alumode <= 4'b0111;
                    out_aluin <= 4'b0001;
                    out_regcontrol <= 5'b10101;
                    out_syscall <= 0;
                    out_IM <= 0;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b001101:begin//ori#
                    out_alumode <= 4'b1000;
                    out_aluin <= 4'b0001;
                    out_regcontrol <= 5'b10101;
                    out_syscall <= 0;
                    out_IM <= 0;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b000100:begin//beq#
                    out_alumode <= 4'b0000;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b11011;
                    out_syscall <= 0;
                    out_IM <= 1;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b000101:begin//bne#
                    out_alumode <= 4'b0000;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b11011;
                    out_syscall <= 0;
                    out_IM <= 1;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b000010:begin//j#
                    out_alumode <= 4'b0000;
                    out_aluin <= 4'b0000;
                    out_regcontrol <= 5'b11011;
                    out_syscall <= 0;
                    out_IM <= 0;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b000011:begin//jal#
                    out_alumode <= 4'b0000;
                    out_aluin <= 4'b0000;
                    out_regcontrol <= 5'b11111;
                    out_syscall <= 0;
                    out_IM <= 0;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b100011:begin//lw#
                    out_alumode <= 4'b0101;
                    out_aluin <= 4'b0001;
                    out_regcontrol <= 5'b10110;
                    out_syscall <= 0;
                    out_IM <= 1;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b101011:begin//sw#
                    out_alumode <= 4'b0101;
                    out_aluin <= 4'b0001;
                    out_regcontrol <= 5'b11011;
                    out_syscall <= 0;
                    out_IM <= 1;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b001010:begin//slti#
                    out_alumode <= 4'b1011;
                    out_aluin <= 4'b0010;
                    out_regcontrol <= 5'b10101;
                    out_syscall <= 0;
                    out_IM <= 1;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b100101:begin//lhu#
                    out_alumode <= 4'b0101;
                    out_aluin <= 4'b0001;
                    out_regcontrol <= 5'b10110;
                    out_syscall <= 0;
                    out_IM <= 1;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b000001:begin//bgez
                    out_alumode <= 4'b1011;
                    out_aluin <= 4'b0000;
                    out_regcontrol <= 5'b11011;
                    out_syscall <= 0;
                    out_IM <= 1;
                    out_cp0 <= 0;
                    out_cpw <=0;
                    out_eret <= 0;
                end
                6'b010000:begin
                    if(in_cp0==0)begin//mfc0
                        out_alumode <= 0;
                        out_aluin <= 0;
                        out_regcontrol <= 5'b00100;
                        out_syscall <= 0;
                        out_IM <= 0;
                        out_cp0 <= 1;
                        out_cpw <=0;
                        out_eret <= 0;
                    end
                    else if(in_cp0==5'b00100) begin//mtc0
                        out_alumode <= 0;
                        out_aluin <= 0;
                        out_regcontrol <= 5'b00000;
                        out_syscall <= 0;
                        out_IM <= 0;
                        out_cp0 <= 0;
                        out_cpw <= 1;
                        out_eret <= 0;
                    end
                    else begin//eret
                        out_alumode <= 0;
                        out_aluin <= 0;
                        out_regcontrol <= 5'b00000;
                        out_syscall <= 0;
                        out_IM <= 0;
                        out_cp0 <= 0;
                        out_cpw <= 0;
                        out_eret <= 1;
                    end
                end
            endcase
        end
    end
endmodule