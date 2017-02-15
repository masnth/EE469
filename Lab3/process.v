module process(enable, control, v, c, n, z, data1, data2, dataOut, clk);

// only run when key 1 is pressed (RUN COMMAND)
	input clk;
	input enable;
	input [2:0] control;
	input [31:0] data1, data2;
	output reg [31:0] dataOut;
	
	output v; //overflow
	output c; //carryout
	output n; //negative
	output z; //zero
	
	wire bits = 2'b11;
	wire [31:0] subOut;
	wire [31:0] shiftOut;
	wire [31:0] result;
	
	subtract s (data1, data2, n, z, subOut, clk); 
	leftShifter l (data1, bits, shiftOut, clk);
	add(data1, data2, result, v, c, clk);

	
	always @ (*) begin
		if (enable) begin
		case(control) 
			3'b000: dataOut = 0; 								  //NOP
			3'b001: dataOut = result; 							  //NOP
			3'b010: dataOut = subOut; //subtract
			3'b011: dataOut = data1 & data2;  //and
			3'b100: dataOut = data1 | data2;	  //or
			3'b101: dataOut = data1 ^ data2;  //xor
			3'b110: dataOut = shiftOut;//LSL
			
			default: dataOut = dataOut;
		endcase
		end
	end
endmodule 	
	