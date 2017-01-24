module DFlipFlop (Q, D, clk, rst);
	input [31:0] D;
	input clk, rst;
	output [31:0] Q;
	reg [31:0] Q;
	
	always @ (posedge clk or negedge clk)
	if (!rst)
		Q <= 32'b0;
	else
		Q <= D;
		
endmodule
