module sign_extend_16b(output wire [31:0] out, input [15:0] in);
	assign out[15:0] = in;
	
	genvar i;
	generate 
		for (i=16; i < 32; i = i+1) begin: eachBit
			assign out[i] = in[15];
		end
	endgenerate
endmodule

module sign_extend_26b(output wire [31:0] out, input [25:0] in);
	assign out[25:0] = in;
	
	genvar i;
	generate 
		for (i=26; i < 32; i = i+1) begin: eachBit
			assign out[i] = in[25];
		end
	endgenerate
endmodule

module sign_extend_19b(output wire [31:0] out, input [18:0] in);
	assign out[18:0] = in;
	
	genvar i;
	generate 
		for (i=19; i < 32; i = i+1) begin: eachBit
			assign out[i] = in[18];
		end
	endgenerate
endmodule

module sign_extend_12b(output wire [31:0] out, input [11:0] in);
	assign out[11:0] = in;
	
	genvar i;
	generate 
		for (i=12; i < 32; i = i+1) begin: eachBit
			assign out[i] = in[11];
		end
	endgenerate
endmodule