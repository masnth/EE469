module switchToData(hex, binary);

// formular for converting from hex to equivalent binary

	input hex;
	output reg [3:0] binary;
	
	always@ (*) begin
		if(hex == 1'b1)
			binary = 4'b0001;
		else if (hex == 1'b0)
			binary = 4'b0000;
	end
endmodule
