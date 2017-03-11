module regFile (r_data1, r_data2, clk, rst, r_reg1, r_reg2, w_reg, w_data, w_enable);

	output reg [31:0] r_data1, r_data2;
	input [31:0] w_data;
	input [4:0] r_reg1, r_reg2, w_reg;
	input clk, rst, w_enable;
	wire [31:0] w_address;
	reg [31:0] register_data [31:0];
	
	integer i;
	
	always @(posedge clk) begin
		if(rst) begin
			for (i = 0; i < 32 ; i = i + 1) begin
				register_data[i] <= 0;
				end
				end
		else if ( w_enable ) begin
			register_data[w_reg] <= w_data;
			r_data1 = register_data[r_reg1];
			r_data2 = register_data[r_reg2];
			end
		else begin
			r_data1 = register_data[r_reg1];
			r_data2 = register_data[r_reg2];
			end
	end

	
	endmodule
	
module regFile_testbench;
	wire [31:0] r_data1, r_data2;
	reg clk, rst;
	reg [4:0] r_reg1, r_reg2, w_reg;
	reg [31:0] w_data;
	reg w_enable;

	regFile dut (r_data1, r_data2, clk, rst, r_reg1, r_reg2, w_reg, w_data, w_enable);
		
	parameter CLOCK_PERIOD=100;

	initial begin

	clk <= 0;

	forever #(CLOCK_PERIOD/2) clk <= ~clk;

	end
		
	initial begin
	rst <= 1; @(posedge clk);
	rst <= 0; w_enable <= 1; w_data <= 64; w_reg <= 7'b1010111; @(posedge clk);
	@(posedge clk);
	@(posedge clk);
	w_enable <= 0; r_reg1 <= 5'b10000; r_reg2 <= 5'b10001; @(posedge clk);
	@(posedge clk);@(posedge clk);@(posedge clk);
	r_reg1 <= 7'b1010111;
	@(posedge clk);@(posedge clk);
	end
	endmodule
	
	
				