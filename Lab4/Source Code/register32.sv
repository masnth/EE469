//`include "register.v"
module register32(out, w_data, w_enable, clk, rst, w_address);
	output [31:0] [31:0] out;
	input clk, rst, w_enable;
	input [31:0] w_address;
	input [31:0] w_data;
	
	genvar i;
	
	generate
		register register0 (.dataOut(out[0]), .dataIn(32'b0), 
							.enable(1'b0), .clk(clk), .rst(rst));   // Initial the register0 to make it always 0;
		for (i = 1; i < 32; i = i + 1) begin : eachRegister
			register register (.dataOut(out[i]), .dataIn(w_data), .enable(w_enable && w_address[i]),
									.clk(clk), .rst(rst));
		end
	endgenerate
	
endmodule
