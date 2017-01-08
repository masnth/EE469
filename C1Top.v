`include "Counter1.v"
module rTestberch;

	wire [3:0]up, down;
	wire clk, rst;
	
	Counter1 dut(down, up, clk, rst);
	
	tester test(clk, rst, down);
	
	initial begin
			$dumpfile("ripple.vcd");
			$dumpvars(1, dut);
	end
	
endmodule



module tester(clk, rst, r);
	
	input [3:0]r;
	output reg clk, rst;
	parameter Delay = 1;
	integer i;
	
	initial begin 
			$display("\t\tclk\trst\tr3\tr2\tr1\tr0\tTime");
			$monitor("\t\t %b \t %b \t %b \t %b \t %b \t %b \t %g",
						clk, rst, r[3], r[2], r[1], r[0], $time);			
	end
		
	initial begin
		clk = 1'b0;
		rst = 1'b0;
		for(i = 0; i < 64; i++) begin
			#Delay clk = ~clk;
			rst = ~((i == 50) | (i == 0));
		end
		$finish;
	end

endmodule