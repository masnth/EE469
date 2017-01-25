module register(dataOut,  dataIn, clk, rst);
	input clk, rst;
	input [31:0] dataIn;
	output wire [31:0] dataOut;
	wire [31:0] dataOutBar;

	genvar i;
	
	generate 
		for (i=0; i<32; i=i+1) begin: flipflop
			DFF D (dataOut[i], dataOutBar[i], dataIn[i], clk, rst);
		end
	endgenerate

endmodule

module DFF(Q, Qbar, dataIn, clk, rst);
	input clk, rst;
	input dataIn;
	output reg Q;
	output reg Qbar;
	reg ps, ns;
	always @ (posedge clk or negedge rst)
		if (~rst) begin
			Q = 1'b0;
			Qbar = 1'b1;
		end
		else begin 
			Q = dataIn;
			Qbar = ~dataIn;
		end
endmodule 
