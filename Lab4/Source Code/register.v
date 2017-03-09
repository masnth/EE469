module register(dataOut,  dataIn, enable, clk, rst);
	input clk, rst, enable;
	input [31:0] dataIn;
	output wire [31:0] dataOut;
	wire [31:0] dataOutBar;

	genvar i;
	
	generate 
		for (i=0; i<32; i=i+1) begin: eachDFF
			DFF_e D (.Q(dataOut[i]), .Qbar(dataOutBar[i]), .dataIn(dataIn[i]), .enable(enable), .clk(clk), .rst(rst));
		end
	endgenerate

endmodule

module DFF_e(Q, Qbar, dataIn, enable, clk, rst);
	input clk, rst, enable;
	input dataIn;
	output reg Q;
	output reg Qbar;

	always @ (posedge clk or negedge rst)
		if (!rst) begin
			Q <= 1'b0;
			Qbar <= 1'b1;
		end
		else if(enable) begin 
			Q <= dataIn;
			Qbar <= ~dataIn;
		end
endmodule 

module DFF_e4(output reg [3:0] Q, input [3:0] dataIn, input enable, clk, rst);
	always @(posedge clk or negedge rst)
		if (!rst)
			Q <= 4'b0;
		else if (enable) begin
			Q[0] <= dataIn[0];
			Q[1] <= dataIn[1];
			Q[2] <= dataIn[2];
			Q[3] <= dataIn[3];
		end	
endmodule 
