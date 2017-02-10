module andGate(data1, data2, dataOut, clk);

	input clk;
	input  [31:0] data1, data2;
	output [31:0] dataOut;
	
	assign dataOut = data1 & data2;
endmodule
