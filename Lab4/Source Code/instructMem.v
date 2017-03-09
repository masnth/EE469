module instructMem(dataIO, addr, read, noe, clk, cs, reset);
	input clk;
	input read, noe, cs;
	input [6:0] addr;
	input reset;

	output reg [31:0] dataIO;

	reg [31:0] mem [127:0];
	
	
	
	always @ (*) begin
		if(reset) begin
			mem[0] <= 32'b00000000000000000000000000001010; //10
			mem[1] <= 32'b00000000000000000000000000001001; //9
			mem[2] <= 32'b00000000000000000000000000001000; //8
			mem[3] <= 32'b00000000000000000000000000000111; //7
			mem[4] <= 32'b00000000000000000000000000000110; //6
			mem[5] <= 32'b00000000000000000000000000000101; //5 
			mem[6] <= 32'b00000000000000000000000000000100; //4
			mem[7] <= 32'b00000000000000000000000000000011; //3
			mem[8] <= 32'b00000000000000000000000000000010; //2
			mem[9] <= 32'b00000000000000000000000000000001; //1
			mem[10] <= 32'b00000000000000000000000000000000; //0
		end
		else 
		dataIO = noe ? 32'bZ : mem[addr];                                                
	end
endmodule

module instructMem_testbench();

	reg clk;
	reg read, noe, cs;
	reg [6:0] addr;
	reg reset;
	wire [31:0] dataIO;
	
	instructMem dux (dataIO, addr, read, noe, clk, cs, reset); 
	
	parameter CLOCK_PERIOD=100;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1; @(posedge clk)
		reset <= 0; noe <= 0; addr <= 0; @(posedge clk);
		reset <= 0; noe <= 0; addr <= 1; @(posedge clk);
		reset <= 0; noe <= 0; addr <= 2; @(posedge clk);
	$stop();
	end
endmodule 
