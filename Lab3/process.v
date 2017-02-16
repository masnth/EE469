module process(enable, control, bits, v, c, n, z, data1, data2, dataOut, clk);

// only run when key 1 is pressed (RUN COMMAND)
	input clk;
	input enable;
	input [2:0] control;
	input [31:0] data1, data2;
	output reg [31:0] dataOut;
	
	wire v1;
	wire c1;
	wire n1;
	wire z1;
	
	output reg v; //overflow
	output reg c; //carryout
	output reg n; //negative
	output reg z; //zero
	
	input [1:0] bits;
	wire [31:0] subOut;
	wire [31:0] shiftOut;
	wire [31:0] result;
	
	
	subtract s (data1, data2, n1, z1, subOut, clk); 
	leftShifter l (data1, bits, shiftOut, clk);
	add a (data1, data2, result, v1, c1, clk);

	
	always @ (*) begin
		if (enable) begin
		case(control) 
			3'b000: begin
						dataOut = 0; v = 0; c = 0; n = 0; z = 0;  //NOP
					  end
			3'b001: begin 
						dataOut = result; v = v1; c = c1; n = 0; z = 0;     // add
					  end							  
			3'b010: begin 
						dataOut = subOut; n = n1; z = z1; v = 0; c = 0;     // subtract
					  end
			3'b011: begin 
						dataOut = data1 & data2; v = 0; c = 0; n = 0; z = 0;  //and
					  end
			3'b100: begin 
						dataOut = data1 | data2; v = 0; c = 0; n = 0; z = 0; 	  //or
					  end
			3'b101: begin 
						dataOut = data1 ^ data2; v = 0; c = 0; n = 0; z = 0;    //xor
					  end
			3'b110: begin 
						dataOut = shiftOut;      v = 0; c = 0; n = 0; z = 0; 	  //LSL
					  end
			default: dataOut = dataOut;
		endcase
		end
	end
endmodule 	
	
module process_testbench();

	reg clk;
	reg enable;
	reg [2:0] control;
	reg [31:0] data1, data2;
	reg [1:0] bits;
	wire [31:0] dataOut;
	
	wire v; //overflow
	wire c; //carryout
	wire n; //negative
	wire z; //zero

	process dux (enable, control, bits, v, c, n, z, data1, data2, dataOut, clk);

	parameter CLOCK_PERIOD=100;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end	
	
	initial begin 
	
//       3'b000: dataOut = 0; 								  //NOP
//			3'b001: dataOut = result; 							  //NOP
//			3'b010: dataOut = subOut; //subtract
//			3'b011: dataOut = data1 & data2;  //and
//			3'b100: dataOut = data1 | data2;	  //or
//			3'b101: dataOut = data1 ^ data2;  //xor
//			3'b110: dataOut = shiftOut;//LSL
	enable <= 1'b0; control <= 3'b000; bits <= 2'b11; data1 <= 68; data2 <= 43; @(posedge clk);
	enable <= 1'b1; control <= 3'b000; bits <= 2'b11; data1 <= 68; data2 <= 43; @(posedge clk);
	enable <= 1'b1; control <= 3'b001; bits <= 2'b11; data1 <= 2147483647; data2 <= 43; @(posedge clk);
	enable <= 1'b1; control <= 3'b010; bits <= 2'b11; data1 <= 68; data2 <= 43; @(posedge clk);
	enable <= 1'b1; control <= 3'b011; bits <= 2'b11; data1 <= 68; data2 <= 43; @(posedge clk);
	enable <= 1'b1; control <= 3'b100; bits <= 2'b11; data1 <= 2147483647; data2 <= 43; @(posedge clk);
	enable <= 1'b1; control <= 3'b101; bits <= 2'b11; data1 <= 68; data2 <= 43; @(posedge clk);
	enable <= 1'b1; control <= 3'b110; bits <= 2'b11; data1 <= 68; data2 <= 43; @(posedge clk);
	@(posedge clk);
	$stop();
	end
endmodule
	
	
	