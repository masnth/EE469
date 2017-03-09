module sramf(data, addr, write_data, we, oe, clk);
	input oe, we, clk; // we write enable(active high), oe out enable (active low)
	input [10:0] addr;

	output [15:0] data;
	
	input [15:0] write_data;

	reg [15:0] sramArray [2047:0];
	
	assign data = oe ?  sramArray[addr] : 16'bZ;

	always @ (posedge clk) begin
			if (we)
				sramArray[addr] <= write_data;
	end
		
	initial begin
		sramArray[0] <= 16'd9;
		sramArray[1] <= 16'd3;
		sramArray[2] <= 16'd8;
	end
endmodule

module sramf_testbench();

	reg oe, we, clk; // we write enable(active high), oe out enable (active low)
	reg [10:0] addr;

	wire [15:0] data;
	
	reg [15:0] write_data;
	
	parameter CLOCK_PERIOD=100;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	sramf dux (data, addr, write_data, we, oe, clk);
	
	initial begin 
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		
	$stop();
	end
endmodule 


		
		
