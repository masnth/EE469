module instruction_fetch(instruction, isBranch, isCondBranch, isBR, RegBranch, clk, rst, PCout, PC_in, CondBranch, UnCondBranch, inst_adx_br, inst_adx_non, muxBrOut, NormalOut);
		input isBranch, isCondBranch, isBR;
		input [31:0] RegBranch;
		input clk, rst;
		output wire [31:0] instruction;
		wire [31:0] instructionO;
		output wire [31:0] inst_adx_br;
		output wire [31:0] inst_adx_non;
		output wire [31:0] muxBrOut, NormalOut;
		output wire [31:0] PCout, PC_in;
		output wire [31:0] CondBranch, UnCondBranch;
		
		assign instruction = instructionO;
		
		wire i_rw, i_noe, i_cs; 
		wire [31:0] inst_addr;
		wire DC;
		
		sign_extend_26b s1(UnCondBranch, instructionO[25:0]);
		sign_extend_19b s2(CondBranch, instructionO[23:5]);
		
		//mux2_1x32 m1(pcIn, pcAdder, branchAdder, branch);
		
		//instr_decoder i1(instruction, imm_sig, rn, rd, rm, imm_value, enLoad, enStore, clk);
		
		// mux for uncond branch / cond branch
		mux2_1x32 isCondBr(muxBrOut, UnCondBranch, CondBranch, isCondBranch); // mux condition. uncondition branch
		
//	   CLA_32 Branch(inst_adx_br, DC, DC, PCout, muxBrOut); // branch adder
//	   CLA_32 nonBranch(inst_adx_non, DC, DC, PCout, 32'd1); // normal adder
		adder Branch(PCout, muxBrOut, inst_adx_br);
		adder nonBranch(PCout, 32'd1, inst_adx_non);
		
		//mux for non BR 
		mux2_1x32 nonBR(NormalOut, inst_adx_non, inst_adx_br, isBranch); // mux between branch, non branch
		

		
		// mux for B / BR
		// mux2_1x32 branchOut(BROut, PCout, RegBranch, isBR); // mux branch, branch register
		
		mux2_1x32 PCmux(PC_in, NormalOut, RegBranch, isBR); // mux final before instruction memory
		
		
		pCounter p1(PCout, PC_in, clk, rst); // hold the next addr in instruction memory(DFF)
		
		instructMem i1(instructionO, PCout, i_rw, 1'b0, clk, i_cs, rst); // instant of instruction memory
		
endmodule


module instruction_fetch_testbench();

	reg isBranch, isCondBranch, isBR;
	reg [31:0] RegBranch;
	reg clk, rst;
	wire [31:0] instruction;
	wire [31:0] PCout, PC_in;
	wire [31:0] CondBranch, UnCondBranch;
	wire [31:0] inst_adx_br;
	wire [31:0] inst_adx_non;
	wire [31:0] muxBrOut, NormalOut;

	instruction_fetch dux (instruction, isBranch, isCondBranch, isBR, RegBranch, clk, rst, PCout, PC_in, CondBranch, UnCondBranch, inst_adx_br, inst_adx_non, muxBrOut, NormalOut);
	
	parameter CLOCK_PERIOD=100;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	initial begin 
	
	rst <= 1; @(posedge clk);
	rst <= 0; isBranch <= 1; isCondBranch <= 0; isBR <= 0; RegBranch <= 4; @(posedge clk);	
	rst <= 0; isBranch <= 1; isCondBranch <= 0; isBR <= 0; RegBranch <= 4; @(posedge clk);
	rst <= 0; isBranch <= 1; isCondBranch <= 1; isBR <= 0; RegBranch <= 4; @(posedge clk);
	rst <= 0; isBranch <= 0; isCondBranch <= 0; isBR <= 1; RegBranch <= 2; @(posedge clk);
	
	$stop();
	end
endmodule 
	
	