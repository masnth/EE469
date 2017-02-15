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
			2'b1x: resultOut = resultIn;
			default: begin 
							data1 = data1; 
							data2 = data2;
							resultOut = resultOut; 
						end
		endcase
		end
	end
endmodule 
			