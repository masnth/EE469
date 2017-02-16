module add(data1, data2, result, v, c, clk, temp);

	input clk;
	input [31:0] data1, data2;
	output reg [31:0] result;
	output reg v, c;
	
	output reg [32:0] temp;
	
	always @(data1, data2) begin
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


module add_testbench();

	reg clk;
	reg [31:0] data1, data2;
	wire [31:0] result;
	wire v, c;
	wire [32:0] temp;
	
	add dux (data1, data2, result, v, c, clk, temp);
	
	parameter CLOCK_PERIOD=100;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin 
	
	 data1 = 15; data2 = 585676;      @(posedge clk);
	 data1 = 3547; data2 = 4896;		@(posedge clk);
	 data1 = 56; data2 = 456;  @(posedge clk);
	 data1 = 15; data2 = 45466;  @(posedge clk);
	 data1 = 489; data2 = 89768;  @(posedge clk);
	 data1 = 190; data2 = 5686894;  @(posedge clk);
	 data1 = 2147483647; data2 = 10;  @(posedge clk);
	                                  @(posedge clk);
	
	$stop();
	
	end
endmodule 

	

	

	