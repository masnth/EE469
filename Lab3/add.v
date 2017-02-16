module add(data1, data2, result, v, c, clk);

	input clk;
	input [31:0] data1, data2;
	output reg [31:0] result;
	output reg v, c;
	
	reg [32:0] temp;
	
	always @(*) begin
		temp = data1  + data2;
			if( temp > 2147483647) begin
				c = 1'b1;
				v = 1'b1;
			end
			
			else if ( temp <= 2147483647) begin
				c = 1'b0;
				v = 1'b0;
			end
		result = temp[31:0];
	end
endmodule
	
