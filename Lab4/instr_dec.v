module instr_decoder();
	input
	output
	
	case (instruction[31:21])
	// ADDI 
	1001000100x: begin
		imm_value = instruction[21:10];
		rn = instruction[9:5];	// second operand
		rd = instruction[4:0];	// destination
		end
	
	//SUBI
	1101000100x: begin
		imm_value = instruction[21:10];
		rn = instruction[9:5];	// second operand
		rd = instruction[4:0];	// destination
		end
		
	//ANDI
	1001001000x: begin
		imm_value = instruction[21:10];
		rn = instruction[9:5];	// second operand
		rd = instruction[4:0];	// destination
		end
		
	//ORRI
	0101101000x: begin
		imm_value = instruction[21:10];
		rn = instruction[9:5];	// second operand
		rd = instruction[4:0];	// destination
		end
		
	//EORI
	1101001000x: begin
		imm_value = instruction[21:10];
		rn = instruction[9:5];	// second operand
		rd = instruction[4:0];	// destination
		end
		
	//ADD
	10000101100: begin
		rm = instruction[20:16];
		rn = instruction[9:5];
		rd = instruction[4:0];
		end
		
	//SUB
	11001011000: begin
		rm = instruction[20:16];
		rn = instruction[9:5];
		rd = instruction[4:0];
		end
		
	//AND
	10001010000: begin
		rm = instruction[20:16];
		rn = instruction[9:5];
		rd = instruction[4:0];
		end
	
	//ORR
	10101010000: begin
		rm = instruction[20:16];
		rn = instruction[9:5];
		rd = instruction[4:0];
		end
	
	//EOR
	11001010000: begin
		rm = instruction[20:16];
		rn = instruction[9:5];
		rd = instruction[4:0];
		end
	
	//LSL
	11010011011: begin
		rm = instruction[20:16];
		rn = instruction[9:5];
		rd = instruction[4:0];
		shamt = instruction[15:10];
		end
	
	//LDURSW
	11111000000: begin
		data_adx = instruction[20:12];
		rn = instruction[9:5];
		rd = instruction[4:0];
		end
	
	//STURW
	11111000010: begin
		data_adx = instruction[20:12];
		rn = instruction[9:5];
		rd = instruction[4:0];
		end
	
	//Branch
	000101xxxxx: begin
		address = instruction[25:0];
		end
	
	//Branch Register
	11010110000: begin
		
		end
	
	//B.GT
	01010100xxx: begin
	
		end
endmodule
