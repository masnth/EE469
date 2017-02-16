module hexDisplay(dataA, dataB, result, sel, dataOut, clk);

// control which data to be display on the hex display based on select input

	input clk;
	input [1:0] sel;
	input [31:0] dataA, dataB, result;
	output reg [31:0] dataOut;
	
	always@ (*) begin
		case(sel) 
			2'b00: dataOut = dataA;
			2'b01: dataOut = dataB;
			2'b10: dataOut = result;
			2'b11: dataOut = result;
		endcase
	end
endmodule

	
	