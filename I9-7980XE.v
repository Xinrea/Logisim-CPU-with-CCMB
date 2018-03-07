//==================================================================================================
//  Filename      : I9-7980XE.v
//  Created On    : 2018-03-05 13:39:32
//  Last Modified : 2018-03-06 16:36:13
//  Revision      : 
//
//  Description   : 
//
//
//==================================================================================================
module I9_7980XE(clk,in_RST,pro_reset,in_addr,changef,leds,SEG,AN);
	input clk,in_RST;
	input [2:0]pro_reset;
	input [11:0]in_addr;
    input changef;
	output [2:0]leds;
	output [7:0]SEG;
    output [7:0]AN;
    wire new_CLK;
    reg in_CLK;

    DIVIDER m_DIVIDER(clk,changef,new_CLK);
    wire EN;
    wire DECLR,FDCLR;
    wire [31:0]extra_data;
    wire loaduse;
    assign loaduse = DECLR;
    wire [31:0]ctotal,cJ,cJS,cloaduse,datatoshow;
    wire BEN,EX_BGEZ,EX_BEQ,EX_BNE,EX_J,EX_JR,EX_result,EX_equal;
    wire [31:0]EX_extended,EX_A,EX_IS,PCOUT;
    wire [31:0]MEM_R;
    reg [31:0]WB_WB = 0;
	wire [31:0]EX_R,EX_syscallout,EX_B2;
	wire [3:0]ALUREDI,SYSREDI;
	wire R_FDCLR,R_DECLR,R_EECLR;
//    led m_led(in_RST,pro_reset,in_addr,leds[15:4]);
    counter m_counter(EN,in_CLK,in_RST,EX_J,JS,loaduse,ctotal,cJ,cJS,cloaduse);
    change_type m_changetype(in_CLK,EX_syscallout,extra_data,PCOUT,ctotal,cJ,cloaduse,cJS,datatoshow);
    display m_display(clk,datatoshow,SEG,AN);

    always @(*) begin
    	if(~EN)in_CLK <= 1;
    	else in_CLK <= new_CLK;
    end

    wire FORCE;//for break and eret
    wire [31:0]FADDR;
	MPC m_MPC(BEN,in_CLK,in_RST,EX_BGEZ,EX_BEQ,EX_BNE,EX_J,EX_JR,EX_result,EX_equal,EX_extended,EX_A,EX_IS,FORCE,FADDR,JS,PCOUT);
	
	wire [31:0]instruction;
	IS m_IS(PCOUT[9:0],instruction);

	wire [31:0]ID_PCOUT,ID_IS;
	IFID m_IFID(BEN,in_CLK,R_FDCLR,PCOUT,instruction,ID_PCOUT,ID_IS);

	wire ID_J,ID_JW,ID_JR,ID_BEQ,ID_BNE,ID_BGEZ,ID_MemWrite,ID_half,ID_syscall,ID_IM,ID_cp0,ID_cpw,ID_eret;
	wire [3:0]ID_ALUmode;
	wire [3:0]ID_ALUinput;
	wire [4:0]ID_RegControl;
	CONTROL m_CONTROL(ID_IS,ID_J,ID_JW,ID_JR,ID_BEQ,ID_BNE,ID_BGEZ,ID_MemWrite,ID_half,ID_syscall,ID_IM,ID_ALUmode,ID_ALUinput,ID_RegControl,ID_cp0,ID_cpw,ID_eret);

	wire [31:0]ID_p1;
	wire [31:0]ID_imm;
	wire [4:0]ID_p2,ID_p3,ID_p4;
	DECODE m_DECODE(ID_IM,ID_IS,ID_p1,ID_imm,ID_p2,ID_p3,ID_p4);

	wire [4:0]WB_regcontrol;
	wire [31:0]WB_Memdata,WB_R,WB_PCOUT,ID_A,ID_B;
	wire [4:0]WB_p2,WB_p4;
	wire IE;
	wire [3:0]INM;
	wire WB_cp0,WB_cpw;
	wire NIE;
	wire [31:0]EPC;
	wire WB_eret;
	wire [1:0]code;
	wire [31:0]WB_BPCOUT;
	wire [31:0]EX_pcout,MEM_pcout;
	wire [31:0]WB_is;
	REGFILE m_REGFILE(in_CLK,ID_syscall,in_RST,WB_regcontrol,WB_Memdata,WB_R,WB_PCOUT,WB_cp0,ID_cpw,BK,NIE,WB_BPCOUT,WB_p2,WB_p4,ID_p4,ID_p3,ID_p2,ID_A,ID_B,IE,INM,EPC,WB_eret,code,EX_pcout,MEM_pcout,WB_is,ID_PCOUT);


	wire [25:0]ID_control;
	assign ID_control[0] = ID_IM;
	assign ID_control[4:1] = ID_ALUmode;
	assign ID_control[8:5] = ID_ALUinput;
	assign ID_control[13:9] = ID_RegControl;
	assign ID_control[14] = ID_BGEZ;
	assign ID_control[15] = ID_MemWrite;
	assign ID_control[16] = ID_half;
	assign ID_control[17] = ID_syscall;
	assign ID_control[18] = ID_J;
	assign ID_control[19] = ID_JW;
	assign ID_control[20] = ID_JR;
	assign ID_control[21] = ID_BEQ;
	assign ID_control[22] = ID_BNE;
	assign ID_control[23] = ID_cp0;
	assign ID_control[24] = ID_cpw;
	assign ID_control[25] = ID_eret;
	wire [31:0]EX_B,EX_p1;
	wire [4:0]EX_p2,EX_p3,EX_p4;
	wire [25:0]EX_control;
	IDEX m_IDEX(EN,in_CLK,R_DECLR,ID_IS,ID_p2,ID_p3,ID_p4,ID_PCOUT,ID_A,ID_B,ID_control,ID_p1,ID_imm,EX_IS,EX_p2,EX_p3,EX_p4,EX_pcout,EX_A,EX_B,EX_control,EX_p1,EX_extended);

	assign EX_BGEZ = EX_control[14];
	assign EX_BNE = EX_control[22];
	assign EX_BEQ = EX_control[21];
	assign EX_J = EX_control[18];
	assign EX_JR = EX_control[20];
	wire EX_lock;
	MALU m_MALU(in_CLK,in_RST,EX_control[17],EX_control[14],EX_control[4:1],EX_control[8:5],ALUREDI,SYSREDI,MEM_R,WB_WB,EX_A,EX_B,EX_extended,EX_p1,EX_R,EX_result,EX_syscallout,EX_equal,EX_lock);

	wire [1:0]CSW;
	SWRE m_SWRE(CSW,EX_B,MEM_R,WB_WB,EX_B2);

	wire MEM_lock;
	wire [31:0]MEM_is,MEM_ra,MEM_rb;
	wire [4:0]MEM_p2,MEM_p3,MEM_p4;
	wire [25:0]MEM_control;
	wire [31:0]MEM_BPCOUT;
	EXMEM m_EXMEM(EN,in_CLK,R_EECLR,EX_lock,EX_A,EX_B2,EX_IS,EX_p2,EX_p3,EX_p4,EX_pcout,EX_control,EX_R,PCOUT,MEM_lock,MEM_ra,MEM_rb,MEM_is,MEM_p2,MEM_p3,MEM_p4,MEM_pcout,MEM_control,MEM_R,MEM_BPCOUT);

	reg [11:0]addr;
	wire [1:0]mode;
	wire WB_Memwrite,WB_half;
	wire [31:0]MEM_Memdata;
	wire [31:0]WB_rb;
	assign mode[0] = 0;
	assign mode[1] = WB_half;
	always @(*) begin
		if(WB_Memwrite)addr <= WB_R[11:0];
		else begin
			addr <= MEM_R[11:0];
		end
	end
	DS m_DS(WB_Memwrite,in_CLK,in_RST,mode,addr,in_addr,WB_rb,MEM_Memdata,extra_data);

	wire WB_lock;
	assign EN = ~WB_lock;
	wire [31:0]WB_ra;
	wire [4:0]WB_p3;
	wire [25:0]WB_control;

	MEMWB m_MEMWB(EN,in_CLK,in_RST,MEM_lock,MEM_ra,MEM_rb,MEM_is,MEM_p2,MEM_p3,MEM_p4,MEM_pcout,MEM_control,MEM_R,MEM_Memdata,MEM_BPCOUT,WB_lock,WB_ra,WB_rb,WB_is,WB_p2,WB_p3,WB_p4,WB_PCOUT,WB_control,WB_R,WB_Memdata,WB_BPCOUT);
	assign WB_regcontrol = WB_control[13:9];
	assign WB_half = WB_control[16];
	assign WB_Memwrite = WB_control[15];
	assign WB_cp0 = WB_control[23];
	assign WB_cpw = WB_control[24];
	assign WB_eret = WB_control[25];
	wire CLW;
	always @(*) begin
		if(CLW)WB_WB <= WB_Memdata;
		else begin
			WB_WB <= WB_R;
		end
	end
	wire [3:0]IG;
	MINT m_MINT(clk,in_RST,code,BK,WB_eret,EPC,FDCLR,DECLR,R_FDCLR,R_DECLR,R_EECLR,FORCE,FADDR,IG,NIE);
	INTERRUPT m_INTERRUPT(in_RST,clk,pro_reset,IG,INM,IE,code,BK,leds);
	wire PEN;
	REDIRECTION m_REDIRECTION(EN,in_CLK,in_RST,EX_J,JS,MEM_control[11],WB_control[11],ID_IS,EX_IS,MEM_is,WB_is,DECLR,FDCLR,BEN,PEN,ALUREDI,SYSREDI,CSW,CLW);
endmodule