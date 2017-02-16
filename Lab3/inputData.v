module inputData(hexDigit, dataOut);

// convert hex input form swithc into binary

	input [3:0] hexDigit;
	wire [31:0] binary;
	output reg [31:0] dataOut;
	
	switchToData d1(.hex(hexDigit[3]), .binary(binary[31:28]));
	switchToData d2(.hex(hexDigit[2]), .binary(binary[20:17]));
	switchToData d3(.hex(hexDigit[1]), .binary(binary[10:7]));
	switchToData d4(.hex(hexDigit[0]), .binary(binary[3:0]));
	
	always@ (*) begin
		dataOut[27:21] = 7'b0000000;
		dataOut[16:11] = 6'b000000;
		dataOut[6:4]   = 3'b000;
		dataOut[31:28] = binary[31:28];
		dataOut[20:17] = binary[20:17];
		dataOut[10:7]  = binary[10:7];
		dataOut[3:0]   = binary[3:0];
	end
endmodule

module inputData_testbench();

	reg [3:0] hexDigit;
	wire [31:0] dataOut;
	
	inputData dux (hexDigit, dataOut);
	
	initial begin 
		
		#5 hexDigit = 4'b1010;
		#5 hexDigit = 4'b1110;
		#5 hexDigit = 4'b1011;
		#5 hexDigit = 4'b0000;
		#5 hexDigit = 4'b1111;
		#5 hexDigit = 4'b1000;
		#5 hexDigit = 4'b0011;
		
		$stop();
		
		end
endmodule
