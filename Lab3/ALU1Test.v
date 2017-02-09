//`include "ALU.v"

module aluTest(CLOCK_50);
	input CLOCK_50;
	wire clk, rst;
	wire [31:0] a, b, out;
	wire [2:0] control;
	assign clk = CLOCK_50;
	
	ALU a1(out, v, c, n ,z, a, b, control, clk, rst);
	test t(a, b, control, clk, rst);
	
endmodule 

module test(aOut, bOut, controlO, clk, rst);
	output reg [31:0] aOut, bOut, controlO;
	input rst;
	output reg clk;
	
	parameter clkDelay = 10;
	integer i = 0;
	
	initial begin
	clk = 1'b0;
	aOut = 32'd5;
	bOut = 32'd3;
	controlO = 3'b000;
	#clkDelay;	 
	#clkDelay;
	end
	always #clkDelay clk = ~clk;
	always @(posedge clk) begin
		i = i + 1;
		if (i == 2)	controlO = 3'b011;
		if (i == 4) controlO = 3'b010;
		
		if (i == 10) controlO = 3'b001;
		
		if (i == 20) controlO = 3'b110;
	end
		
endmodule
