// Top-level module that defines the I/Os for the DE-1 SoC board

module CPU (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR,
SW);
	input CLOCK_50; 
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output [9:0] LEDR;
	input [3:0] KEY; 
	input [9:0] SW;
	
	// Generate clk off of CLOCK_50, whichClock picks rate.
	wire [31:0] clk;
	parameter whichClock = 18;
	//clk_divider cdiv (CLOCK_50, clk);
	
	
	// wire for control of reg file
	wire [31:0] r_data1, r_data2; // register read data
	wire rst; // 
	wire [4:0] r_reg1, r_reg2, w_reg; // address for read form register, w_reg: write address 
	wire [31:0] w_dataOut; // data to write to register
	wire w_enable; // write enable for register
//	wire [31:0] m_data; 
//	wire sel; // 
	
	// wire for control of SRAM
	wire [15:0] s_data; // data from sram
	wire [10:0] s_addr; // address for data from sram
	wire s_rw, s_noe, s_cs; // sram read, write, chip select(select sram or not), noe: out enable(active low)
	
	//wire for ALU
	wire [31:0] out; // result from alu
	wire v, c, n, z;

//	wire [31:0] inst_addr; 
	wire [31:0] instructionOut, instructionO;
	wire [31:0] operand1; // operand 2 - op1
	wire [31:0] dataOut; // 32 extend of sram
	wire isBranchOutF, BGTout;
	
	
	// w_reg: write addres
	// w_dataOut: data to write to reg file
	// reg_writeOut: 1 write in, 0 read out
	// declare devices and connects them into one bus
	regfile r1 (r_data1, r_data2, clk, rst, 
					r_reg1, r_reg2, w_reg, w_dataOut, 
									reg_writeOut);
									
									
	sramf sram (s_data, out[10:0], r_data1[15:0], Reg2MemOut, Mem2RegOut, clk);
	
	
	// declare the driver;
	// memoryDriver aDriver (rst, r_reg1, r_reg2, w_reg, m_data, w_enable, s_data, s_addr, 
	//							s_rw, s_noe, s_cs, r_data1, r_data2, sel, clk, SW[9]);
	
	// ALU connection
	ALU alu(out, VOut, COut, NOut , ZOut, operand1, r_data2, aluControlOut, shamtOut, clk, SW[9]);	 // instruction from SRAM, data from regFile
	
	
	
	instructionFetch i1(instructionOut, isBranchOutF, BGTout, isBROut, r_data2, clk, SW[9]);
	
	
	// r_reg2 = rn (also offset for load, store)      = r_data2
	// w_reg  = rd (destination address in register)  = 
	// r_reg1 = rm (this or imi for operand 1)        = r_data1
	
	instr_decoder i2(instructionOut, aluControlOut, shamtOut, imm_sigOut, r_reg2, w_reg, r_reg1, imm_valueOut, Mem2RegOut, Reg2MemOut,
						isBranchOut, CondBranchOut, isBROut, reg_writeOut, branch_adxOut, enableDFFOut, data_adxOut, clk);
	
	// dataOut: data from sram
	// out: result from ALU
	mux2_1x32 m1(w_dataOut, dataOut, out, reg_writeOut); // mux data memory or alu result to regfile
	mux2_1x32 isConstant(operand1, r_data1, imm_value, imm_sigOut); // mux imi or register
	
	sign_extend_12b immediateValue(imm_value, imm_valueOut);
	sign_extend_16b sramExtend(dataOut, s_data);
	
	assign isBranchOutF = (CondBranchOut | isBranchOut); // branch or not
	assign BGTout = ((!ZOut & (NOut ^ VOut)) & CondBranchOut); // flag for BGT if satisfy
	DFF_e4 d1({Nflag,Cflag,Zflag,Vflag}, {NOut,COut,ZOut,VOut}, enableDFFOut, clk, SW[9]); // DFF of flag
	
	// instruction
	//	instructMem(instruction, inst_addr[6:0], s_rw, s_noe, s_cs)
	//	pCounter(adx_out, adx_in, clk, rst);
	
	
	// When KEY[0] is 0, output register 0 to 15, 16 to 31 if KEY[0] is one.
	// assign LEDR[7:0] = KEY[0] ? r_data2[7:0] : r_data1[7:0];
	
	
	
	
endmodule

module CPU_testbench();

	reg clk; // 50MHz clock.
	wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	wire [9:0] LEDR;
	reg [3:0] KEY; // True when not pressed, False when pressed
	reg [9:0] SW;

	CPU dux (clk, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	parameter CLOCK_PERIOD=100;

	initial begin

	clk <= 0;

	forever #(CLOCK_PERIOD/2) clk <= ~clk;

	end	
initial begin 
	
	SW[9] <= 1;@(posedge clk);
	SW[9] <= 0;@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	
$stop();
end
endmodule 

