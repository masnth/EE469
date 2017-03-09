module pCounter(adx_out, adx_in, clk, rst);
	input [31:0] adx_in;
	input clk, rst;
	output wire [31:0] adx_out;
	
	genvar i;
	
	generate 
		for (i = 0; i < 32; i = i + 1) begin : eachDFF
			DFF_rst mydff(adx_out[i], adx_in[i], clk, rst);
		end
	endgenerate
	
endmodule

module DFF_rst(q, D, clk, rst);
		input D, clk, rst;
		output reg q;

		always@ (posedge clk)
		begin
			if(rst)
				q <= 0;
			else
				q <= D;
		end
endmodule
