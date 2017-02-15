module subtract(data1, data2, n, z, dataOut, clk);

	input clk;
	input [31:0] data1, data2;
	output reg [31:0] dataOut;
	output reg n, z;
	
	always@ (*) begin
		if(data1 > data2) begin
			dataOut = data1 - data2;
			n = 1'b0;
			z = 1'b0;
		end else if(data2 > data1) begin
			dataOut = data1 - data2;
			n = 1'b1;
			z = 1'b0;
		end else if(data1 == data2) begin
			dataOut = data1 - data2;
			n = 1'b0;
			z = 1'b1;
		end
			
	end
endmodule

	
	
	
	
