module xorGate(data1, data2, dataOut, clk);

	input clk;
	input [7:0] data1, data2;
	output [7:0] dataOut;
	
	assign dataOut = data1 ^ data2;
endmodule
	
module xorGate_testbench;
	
	wire clk;
	reg [7:0] data1, data2;
	wire [7:0] dataOut;
	
	xorGate xor1 (data1, data2, dataOut, clk);

	
	initial begin 
	
	#5 data1 = 8'b01010101; data2 = 8'b01010000;
	#5
	
	$stop();
	end
endmodule 