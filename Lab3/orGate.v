module orGate(data1, data2, dataOut, clk);

	input clk;
	input [7:0] data1, data2;
	output [7:0] dataOut;
	
	assign dataOut = data1 | data2;
endmodule