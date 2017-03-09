module instructionFetch(instruction, isBranch, unCondBranch, isCondBranch, isBR, RegBranch, clk, rst);
		input isBranch, unCondBranch, isCondBranch, isBR;
		input [31:0] RegBranch;
		input clk, rst;
		output wire [31:0] instruction;
		wire [31:0] instructionO;
		
		assign instruction = instructionO;
		
		wire i_rw, i_noe, i_cs;
		wire [31:0] inst_addr;
		wire DC;
		wire [31:0] inst_adx_br, inst_adx_non, muxBrOut;
		wire [31:0] NormalOut, BROut;
		wire [31:0] UnCondBranch, CondBranch;
		wire [31:0] PCout, PC_in;
		
		
		
		sign_extend_26b s1(UnCondBranch, instructionO[25:0]);
		sign_extend_19b s2(CondBranch, instructionO[23:5]);
		
		//mux2_1x32 m1(pcIn, pcAdder, branchAdder, branch);
		
		//instr_decoder i1(instruction, imm_sig, rn, rd, rm, imm_value, enLoad, enStore, clk);
		
		CLA_32 Branch(inst_adx_br, DC, DC, PCout, muxBrOut, 'd0);
		CLA_32 nonBranch(inst_adx_non, DC, DC, PCout, 32'd1, 'd0);
		
		
		//mux for non BR 
		mux2_1x32 nonBR(NormalOut, inst_adx_non, inst_adx_br, isBranch);
		
		// mux for uncond branch / cond branch
		mux2_1x32 isCondBr(muxBrOut, UnCondBranch, CondBranch, isCondBranch);
		
		// mux for B / BR
		mux2_1x32 branchOut(BROut, PCout, RegBranch, isBR);
		
		mux2_1x32 PCmux(PC_in, NormalOut, BROut, isBR);
		
		instructMem i1(instructionO, PCout[6:0], i_rw, 'b0, clk, i_cs);
		pCounter p1(.adx_out(PCout), .adx_in(PC_in), .clk(clk), .rst(rst));
		
endmodule


module instructFetch_testbench();
	reg clk, noe;
	wire addr, read, cs;
	//wire [31:0] mem [127:0];
	reg rst, isBranch, isCondBranch, isBR;
	
	instructionFetch dut(instruction, isBranch, unCondBranch, isCondBranch, isBR, RegBranch, clk, rst);
	parameter clkDelay = 'd10;
	initial begin
	clk <= 0;
	forever #(clkDelay/2) clk <= ~clk;
	end
	
	initial begin 
		noe = 1'b1;
		clk = 1'b0;
		rst = 'b1;
		isBranch = 0;
		isCondBranch = 0;
		isBR = 0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		rst = 'b0; 
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);		
	end
	
	
	
endmodule