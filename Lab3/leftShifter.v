module leftShifter(data, bits, dataOut, clk);
	
	input         clk;
	input  [31:0] data;
	input  [1:0]  bits;
	output reg [31:0] dataOut;
	
	always@ (posedge clk) begin
		if (bits == 2'b01)
			dataOut <= {1'b0, data[31:1]};
		else if (bits == 2'b10)
			dataOut <= {1'b0,1'b0, data[31:2]};
		else if (bits == 2'b11)
			dataOut <= {1'b0,1'b0,1'b0, data[31:3]};
		else 
			dataOut <= data;
	end
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
			
