module leftShifter(data, bits, dataOut, clk);
	
	input         clk;
	input  [31:0] data;
	input  [1:0]  bits;
	output reg [31:0] dataOut;
	
	always@ (*) begin
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

module leftShifter_testbench();

	reg         clk;
	reg  [31:0] data;
	reg  [1:0]  bits;
	wire [31:0] dataOut;
	
	leftShifter dux (data, bits, dataOut, clk);
	
	parameter CLOCK_PERIOD=100;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
	
	bits <= 2'b11; data <= 68; @(posedge clk);
	bits <= 2'b11; data <= 34; @(posedge clk);
	bits <= 2'b11; data <= 56; @(posedge clk);
	bits <= 2'b11; data <= 98; @(posedge clk);
	
	$stop();
	end
endmodule
	
			