`include "DFLipFLop.v"
module Counter1 (down, out, clk, rst);
	
	output [3:0] out, down;
	//wire n0, n1, n2, n3;
	input clk, rst;
	
	DFlipFlop count0(down[0], out[0], out[0], clk, rst);
	DFlipFlop count1(down[1], out[1], out[1], down[0], rst);
	DFlipFlop count2(down[2], out[2], out[2], down[1], rst);
	DFlipFlop count3(down[3], out[3], out[3], down[2], rst);
endmodule

