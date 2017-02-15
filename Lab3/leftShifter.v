module leftShifter(data, bits, dataOut, clk);
	
	input         clk;
	input  [31:0] data;
	input  [1:0]  bits;
	output reg [31:0] dataOut;
	
	always@ (posedge clk) begin
		if (bits == 2'b01)
			dataOut <= {data[30:0], 1'b0};
		else if (bits == 2'b10)
			dataOut <= {data[29:0], 1'b0,1'b0};
		else if (bits == 2'b11)
			dataOut <= {data[28:0], 1'b0,1'b0,1'b0};
		else 
			dataOut <= data;
	end
endmodule
			