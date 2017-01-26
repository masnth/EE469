//`include "register32.v"
//`include "muxControl.v"


module regfile (r_data1, r_data2, clk, rst, r_reg1, r_reg2, w_reg, w_data, w_enable);
	output [31:0] r_data1, r_data2;
	input [31:0] w_data;
	input [4:0] r_reg1, r_reg2, w_reg;
	input clk, rst, w_enable;
	wire [31:0] w_address;
	wire [31:0] [31:0] register_data;
	
	dec5to32 d1 (.in(w_reg), .out(w_address), .en(1'b1));
	register32 r1 (.out(register_data), .w_data(w_data), .w_enable(w_enable), .clk(clk), .rst(rst), .w_address(w_address));

	muxControl m1 (register_data[0], register_data[1], register_data[2], register_data[3], register_data[4], register_data[5], register_data[6], register_data[7],
		   register_data[8], register_data[9], register_data[10], register_data[11], register_data[12], register_data[13], register_data[14], register_data[15],
		   register_data[16], register_data[17], register_data[18], register_data[19], register_data[20], register_data[21], register_data[22], register_data[23],
		   register_data[24], register_data[25], register_data[26], register_data[27], register_data[28], register_data[29], register_data[30], register_data[31],
			r_data1, r_reg1);
	muxControl m2 (register_data[0], register_data[1], register_data[2], register_data[3], register_data[4], register_data[5], register_data[6], register_data[7],
		   register_data[8], register_data[9], register_data[10], register_data[11], register_data[12], register_data[13], register_data[14], register_data[15],
		   register_data[16], register_data[17], register_data[18], register_data[19], register_data[20], register_data[21], register_data[22], register_data[23],
		   register_data[24], register_data[25], register_data[26], register_data[27], register_data[28], register_data[29], register_data[30], register_data[31],
			r_data2, r_reg2);
	
endmodule

module registerfile_testBench;	
	wire [31:0] r_data1, r_data2;
	wire clk, rst;
	wire [4:0] r_reg1, r_reg2, w_reg;
	wire [31:0] w_data;
	wire w_enable;
	
	// declare device under test;
	regfile r1 (.r_data1(r_data1), .r_data2(r_data2), .clk(clk), .rst(rst), 
									.r_reg1(r_reg1), .r_reg2(r_reg2), .w_reg(w_reg), .w_data(w_data), 
									.w_enable(w_enable));
	
	// declare the tester;
	regfileTester aTester (clk, rst, r_reg1, r_reg2, w_reg, w_data, w_enable, r_data1, r_data2);
	
endmodule

module regfileTester(clkOut, rstOut, r_reg1Out, r_reg2Out, w_regOut, w_dataOut, w_enableOut, r_data1In, r_data2In);
	input [31:0] r_data1In, r_data2In;
	output reg clkOut, rstOut, w_enableOut;
	output reg [4:0] r_reg1Out, r_reg2Out, w_regOut;
	output reg [31:0] w_dataOut;
	
	parameter clockDelay = 10;
	parameter stimDelay = 15;
	
	integer i;
	
	initial
	
	begin 
	clkOut = 1'b0;
	rstOut = 1'b0;
	
	// Initial the control for the read operation.
	r_reg1Out = 5'b00000;
	r_reg2Out = 5'b10000;
	
	// Initial the input for the write operation.
	w_regOut = 5'b0;
	w_enableOut = 1'b0;
	
	// disalbe reset first.
	#stimDelay rstOut = 5'b1;
	
	// write to the first 15 registers;
	w_dataOut = 'hFFFF000F;
	
	for (i = 0; i < 16; i = i + 1) begin
		#stimDelay 	w_enableOut = 1'b1;
		#stimDelay 	w_enableOut = 1'b0; w_dataOut = w_dataOut - 'h1; w_regOut = w_regOut + 1'b1;
	end
	
	// write to the 16 to 32 register.
	w_dataOut = 'h0000FFF0;
	for (i = 0; i < 16; i = i + 1) begin
		#stimDelay 	w_enableOut = 1'b1;
		#stimDelay 	w_enableOut = 1'b0; w_dataOut = w_dataOut + 'h1; w_regOut = w_regOut + 1'b1;
	end
		
	// read through after the write finish.
	#(35*stimDelay);
	$stop;
	
	end
	
	// Flip the clockOut.
	always #clockDelay clkOut = ~clkOut;

	// Read the data from the register.
	always @(posedge clkOut) begin 
		if (r_reg1Out == 5'b01111) #stimDelay r_reg1Out = 5'b00000;

		#stimDelay r_reg1Out = r_reg1Out + 5'b1;
	end
	
	always @(posedge clkOut) begin 
		
		if (r_reg2Out == 5'b11111) #stimDelay r_reg2Out = 5'b10000;

		#stimDelay r_reg2Out = r_reg2Out + 5'b1;
	end
endmodule
