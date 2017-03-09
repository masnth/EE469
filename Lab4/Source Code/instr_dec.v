module instr_decoder(instruction, aluControl, shamt, imm_sig, rn, rd, rm, imm_value, Mem2Reg, 
Reg2Mem, isBranch, isCondBranch, isBR, reg_write, branch_adx, enableDFFOut, data_adx, clk);
	
	input clk;
	input [31:0] instruction;
	output reg [4:0] rn, rd, rm, branch_adx;
	output reg [11:0] imm_value;
	output reg Mem2Reg;
	output reg Reg2Mem;
	output reg imm_sig;
	output reg [2:0] aluControl;
	output reg [5:0] shamt;
	output reg isBranch, isBR, isCondBranch;
	output reg reg_write;
	output reg [10:0] data_adx; 
	output reg enableDFFOut;
	
	parameter [2:0] op_nop = 3'b000, op_add = 3'b001, op_sub = 3'b010, op_and = 3'b011,
op_or = 3'b100, op_eor = 3'b101, op_lsl = 3'b110;	
	
always@(*) begin 
	case (instruction[31:21])
	// ADDI 
	11'b100100010000: begin
		imm_value = instruction[21:10];
		rn = instruction[9:5];	// second operand
		rd = instruction[4:0];	// destination
		Mem2Reg  = 1'b0;			// Mem2Reg = Mem2Reg
		Reg2Mem = 1'b0;			// Reg2Mem = Reg2Mem
		imm_sig = 1'b1;			// immediate value
		aluControl = op_add;	
		reg_write = 'b1;				// write to register
		enableDFFOut = 'b1;
		
		isBranch = 0;
		isCondBranch = 0;
		isBR = 0;
		
		end
	
	//SUBI
	11'b11010001000: begin
		imm_value = instruction[21:10];
		rn = instruction[9:5];	// second operand
		rd = instruction[4:0];	// destination
		Mem2Reg  = 1'b0;
		Reg2Mem = 1'b0;
		imm_sig = 1'b1;
		aluControl = op_sub;		
		reg_write = 'b1;				// write to register
		enableDFFOut = 'b1;
		
		isBranch = 0;
		isCondBranch = 0;
		isBR = 0;
		end
		
	//ANDI
	11'b10010010000: begin
		imm_value = instruction[21:10];
		rn = instruction[9:5];	// second operand
		rd = instruction[4:0];	// destination
		Mem2Reg  = 1'b0;
		Reg2Mem = 1'b0;
		imm_sig = 1'b1;
		aluControl = op_and;
		reg_write = 'b1;				// write to register
		enableDFFOut = 'b1;
		
		isBranch = 0;
		isCondBranch = 0;
		isBR = 0;
		end
		
	//ORRI
	11'b10110010000: begin
		imm_value = instruction[21:10];
		rn = instruction[9:5];	// second operand
		rd = instruction[4:0];	// destination
		Mem2Reg  = 1'b0;
		Reg2Mem = 1'b0;
		imm_sig = 1'b1;
		aluControl = op_or;
		reg_write = 'b1;				// write to register
		enableDFFOut = 'b1;
		
		isBranch = 0;
		isCondBranch = 0;
		isBR = 0;
		end
		
	//EORI
	11'b11010010000: begin
		imm_value = instruction[21:10];
		rn = instruction[9:5];	// second operand
		rd = instruction[4:0];	// destination
		Mem2Reg  = 1'b0;
		Reg2Mem = 1'b0;
		imm_sig = 1'b1;
		aluControl = op_eor;
		reg_write = 'b1;				// write to register
		enableDFFOut = 'b1;
		
		isBranch = 0;
		isCondBranch = 0;
		isBR = 0;
		end
		
	//ADD
	11'b10001011000: begin
		rm = instruction[20:16];
		rn = instruction[9:5];
		rd = instruction[4:0];
		Mem2Reg  = 1'b0;
		Reg2Mem = 1'b0;
		imm_sig = 1'b1;
		aluControl = op_add;
		reg_write = 'b1;				// write to register
		enableDFFOut = 'b1;
		
		isBranch = 0;
		isCondBranch = 0;
		isBR = 0;
		end
		
	//SUB
	11'b11001011000: begin
		rm = instruction[20:16];
		rn = instruction[9:5];
		rd = instruction[4:0];
		Mem2Reg  = 1'b0;
		Reg2Mem = 1'b0;
		imm_sig = 1'b0;
		aluControl = op_sub;
		reg_write = 'b1;				// write to register
		enableDFFOut = 'b1;
		
		isBranch = 0;
		isCondBranch = 0;
		isBR = 0;
		end
		
	//AND
	11'b10001010000: begin
		rm = instruction[20:16];
		rn = instruction[9:5];
		rd = instruction[4:0];
		Mem2Reg  = 1'b0;
		Reg2Mem = 1'b0;
		imm_sig = 1'b0;
		aluControl = op_and;
		reg_write = 'b1;				// write to register
		enableDFFOut = 'b1;
		
		isBranch = 0;
		isCondBranch = 0;
		isBR = 0;
		end
	
	//ORR
	11'b10101010000: begin
		rm = instruction[20:16];
		rn = instruction[9:5];
		rd = instruction[4:0];
		Mem2Reg  = 1'b0;
		Reg2Mem = 1'b0;
		imm_sig = 1'b0;
		aluControl = op_or;
		reg_write = 'b1;				// write to register
		enableDFFOut = 'b1;
		
		isBranch = 0;
		isCondBranch = 0;
		isBR = 0;
		end
	
	//EOR
	11'b11001010000: begin
		rm = instruction[20:16];
		rn = instruction[9:5];
		rd = instruction[4:0];
		Mem2Reg  = 1'b0;
		Reg2Mem = 1'b0;
		imm_sig = 1'b0;
		aluControl = op_eor;
		reg_write = 'b1;				// write to register
		enableDFFOut = 'b1;
		
		isBranch = 0;
		isCondBranch = 0;
		isBR = 0;
		end
	
	//LSL
	11'b11010011011: begin
		rm = instruction[20:16];
		rn = instruction[9:5];
		rd = instruction[4:0];
		shamt = instruction[15:10];
		Mem2Reg  = 1'b0;
		Reg2Mem = 1'b0;
		imm_sig = 1'b0;
		aluControl = op_lsl;
		reg_write = 'b1;				// write to register
		
		isBranch = 0;
		isCondBranch = 0;
		isBR = 0;
		end
	
	//LDURSW
	11'b10111000100: begin
		imm_value = ({3'b000,instruction[20:12]}); // offset
		rn = instruction[9:5]; // 
		rd = instruction[4:0];
		Mem2Reg  = 1'b1;
		Reg2Mem = 1'b0;
		imm_sig = 1'b1;
		reg_write = 'b1;				// write to register
		enableDFFOut = 'b0;
		aluControl = op_add;
		
		isBranch = 0;
		isCondBranch = 0;
		isBR = 0;
		end
	
	//STURW
	11'b10111000000: begin
		imm_value = ({3'b000,instruction[20:12]}); // offset
		rn = instruction[9:5]; //
		rm = instruction[4:0];  // register address
		Mem2Reg  = 1'b0;
		Reg2Mem = 1'b1;
		imm_sig = 1'b1;
		aluControl = op_add;
		reg_write = 'b1;				// write to register
		enableDFFOut = 'b0;
		
		isBranch = 0;
		isCondBranch = 0;
		isBR = 0;
		end
	
	//Branch
	11'b000101?????: begin
//		branch_adx = instruction[25:0];
		aluControl = op_nop;
		Mem2Reg  = 1'b0;
		Reg2Mem = 1'b0;
		imm_sig = 1'b0;
		aluControl = op_nop;
		reg_write = 'b0;				// write to register
		enableDFFOut = 'b0;
		
		isBranch = 1;
		isCondBranch = 0;
		isBR = 0;
		end
	
	//Branch Register
	11'b11010110000: begin
		aluControl = op_nop;
		Mem2Reg  = 1'b0;
		Reg2Mem = 1'b0;
		imm_sig = 1'b0;
		reg_write = 'b0;				// write to register
		enableDFFOut = 'b0;
		
		isBranch = 1;
		isCondBranch = 0;
		isBR = 1;
		end
	
	//B.GT
	11'b01010100???: begin
		if(instruction[4:0] == 5'b0) begin
			Mem2Reg  = 1'b0;
			Reg2Mem = 1'b0;
			imm_sig = 1'b0;
			aluControl = op_nop;
			reg_write = 'b0;				// write to register
			enableDFFOut = 'b0;
			
			isBranch = 1;
			isCondBranch = 1;
			isBR = 0;
		end
		end
	endcase
end
endmodule
