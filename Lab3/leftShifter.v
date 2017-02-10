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
			