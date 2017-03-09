module instr_decoder(instruction, imm_sig, rn, rd, rm, imm_value, enLoad, enStore, clk);
	
	input clk;
	input [31:0] instruction;
	output reg [4:0] rn, rd, rm;
	output reg [11:0] imm_value;
	output reg enLoad;
	output reg enStore;
	output reg imm_sig;
	output reg [2:0] aluControl;
	
	parameter [2:0] op_nop = 3'b000; op_add = 3'b001; op_sub = 3'b010; op_and = 3'b011;
op_or = 3'b100; op_eor = 3'b101; op_lsl = 3'b110;	
	
always@(*) begin 
	case (instruction[31:21])
	// ADDI 
	1001000100x: begin
		imm_value = instruction[21:10];
		rn = instruction[9:5];	// second operand
		rd = instruction[4:0];	// destination
		enLoad  = 1'b0;
		enStore = 1'b0;
		imm_sig = 1'b1;
		aluControl = op_add;
		end
	
	//SUBI
	1101000100x: begin
		imm_value = instruction[21:10];
		rn = instruction[9:5];	// second operand
		rd = instruction[4:0];	// destination
		enLoad  = 1'b0;
		enStore = 1'b0;
		imm_sig = 1'b1;
		aluControl = op_sub;
		end
		
	//ANDI
	1001001000x: begin
		imm_value = instruction[21:10];
		rn = instruction[9:5];	// second operand
		rd = instruction[4:0];	// destination
		enLoad  = 1'b0;
		enStore = 1'b0;
		imm_sig = 1'b1;
		aluControl = op_and;
		end
		
	//ORRI
	1011001000x: begin
		imm_value = instruction[21:10];
		rn = instruction[9:5];	// second operand
		rd = instruction[4:0];	// destination
		enLoad  = 1'b0;
		enStore = 1'b0;
		imm_sig = 1'b1;
		aluControl = op_or;
		end
		
	//EORI
	1101001000x: begin
		imm_value = instruction[21:10];
		rn = instruction[9:5];	// second operand
		rd = instruction[4:0];	// destination
		enLoad  = 1'b0;
		enStore = 1'b0;
		imm_sig = 1'b1;
		aluControl = op_eor;
		end
		
	//ADD
	10001011000: begin
		rm = instruction[20:16];
		rn = instruction[9:5];
		rd = instruction[4:0];
		enLoad  = 1'b0;
		enStore = 1'b0;
		imm_sig = 1'b1;
		aluControl = op_add;
		end
		
	//SUB
	11001011000: begin
		rm = instruction[20:16];
		rn = instruction[9:5];
		rd = instruction[4:0];
		enLoad  = 1'b0;
		enStore = 1'b0;
		imm_sig = 1'b0;
		aluControl = op_sub;
		end
		
	//AND
	10001010000: begin
		rm = instruction[20:16];
		rn = instruction[9:5];
		rd = instruction[4:0];
		enLoad  = 1'b0;
		enStore = 1'b0;
		imm_sig = 1'b0;
		aluControl = op_and;
		end
	
	//ORR
	10101010000: begin
		rm = instruction[20:16];
		rn = instruction[9:5];
		rd = instruction[4:0];
		enLoad  = 1'b0;
		enStore = 1'b0;
		imm_sig = 1'b0;
		aluControl = op_or;
		end
	
	//EOR
	11001010000: begin
		rm = instruction[20:16];
		rn = instruction[9:5];
		rd = instruction[4:0];
		enLoad  = 1'b0;
		enStore = 1'b0;
		imm_sig = 1'b0;
		aluControl = op_eor;
		end
	
	//LSL
	11010011011: begin
		rm = instruction[20:16];
		rn = instruction[9:5];
		rd = instruction[4:0];
		shamt = instruction[15:10];
		enLoad  = 1'b0;
		enStore = 1'b0;
		imm_sig = 1'b0;
		aluControl = op_lsl;
		end
	
	//LDURSW
	10111000100: begin
		data_adx = instruction[20:12];
		rn = instruction[9:5];
		rd = instruction[4:0];
		enLoad  = 1'b1;
		enStore = 1'b0;
		imm_sig = 1'b0;
		end
	
	//STURW
	10111000000: begin
		data_adx = instruction[20:12];
		rn = instruction[9:5];
		rd = instruction[4:0];
		enLoad  = 1'b0;
		enStore = 1'b1;
		imm_sig = 1'b0;
		aluControl = op_nop;
		end
	
	//Branch
	000101xxxxx: begin
		address = instruction[25:0];
		aluControl = op_nop;
		end
	
	//Branch Register
	11010110000: begin
		aluControl = op_nop;
		end
	
	//B.GT
	01010100xxx: begin
		aluControl = op_nop;
		end
endmodule
