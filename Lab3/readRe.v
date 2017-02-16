module readRe(enable, data1, data2, dataIn, resultIn, resultOut,  select, clk);

// only run when key 0 is press (ENTER COMMAND) 

	input clk;
	input enable;
	input [31:0] resultIn;
	input [1:0] select;
	input [31:0] dataIn;
	output reg [31:0] data1, data2;
	output reg [31:0] resultOut;

	always@(*) begin
		if (enable) begin
		case(select) 
			2'b00: data1 = dataIn;
			2'b01: data2 = dataIn;
			2'b10: resultOut = resultIn;
			2'b11: resultOut = resultIn;
			default: begin 
							data1 = data1; 
							data2 = data2;
							resultOut = resultOut; 
						end
		endcase
		end
	end
endmodule 

module readRe_testbench();

	reg clk;
	reg enable;
	reg [31:0] resultIn;
	reg [1:0] select;
	reg [31:0] dataIn;
	wire [31:0] data1, data2;
	wire [31:0] resultOut;
	
	parameter CLOCK_PERIOD=100;
	initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end


   readRe dux (enable, data1, data2, dataIn, resultIn, resultOut,  select, clk);

	initial begin
	
	enable <= 0; select <= 2'b00; dataIn <= 15; resultIn <= 25; @(posedge clk);
	enable <= 1; select <= 2'b01; dataIn <= 15; resultIn <= 25; @(posedge clk);
	enable <= 1; select <= 2'b10; dataIn <= 15; resultIn <= 25; @(posedge clk);
	enable <= 1; select <= 2'b11; dataIn <= 15; resultIn <= 25; @(posedge clk);
	enable <= 1; select <= 2'b00; dataIn <= 15; resultIn <= 25; @(posedge clk);
	enable <= 1; select <= 2'b00; dataIn <= 15; resultIn <= 25; @(posedge clk);
	enable <= 1; select <= 2'b00; dataIn <= 15; resultIn <= 25; @(posedge clk);
	
	$stop();
	end
	
endmodule
			
