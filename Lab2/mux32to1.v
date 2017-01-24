module mux2to1(data1, data2, q, sel);

	input data1, data2;
	input sel;
	output q;
	
	tri q;
	
	bufif1 (q, data1, sel);
	bufif0 (q, data2, sel);
	
endmodule

module mux4to1(data1, data2, data3, data4, q, sel);

	input data1, data2, data3, data4;
	input [1:0] sel;
	output q;
	
	wire mux_1, mux_2;
	
	mux2to1 m1(data1, data2, mux_1, sel[0]);
	mux2to1 m2(data3, data4, mux_2, sel[0]);
	mux2to1 m3(mux_1, mux_2, q, sel[1]);
	
endmodule 

module mux16to1(data, q, sel);

	input [15:0] data;
	input [3:0] sel;
	output q;
	
	wire mux_1, mux_2, mux_3, mux_4;
	
	mux4to1 m1(data[0], data[1], data[2], data[3], mux_1, sel[3:2]); 
	mux4to1 m2(data[4], data[5], data[6], data[7], mux_2, sel[3:2]);
	mux4to1 m3(data[8], data[9], data[10], data[11], mux_3, sel[3:2]);
	mux4to1 m4(data[12], data[13], data[14], data[15], mux_4, sel[3:2]);
	mux4to1 m5(mux_1, mux_2, mux_3, mux_4, q, sel[1:0]);
	
endmodule

module mux32to1(data, q, sel);

	input [31:0] data;
	input [4:0] sel;
	output q;
	
	wire mux_1, mux_2;
	
	mux16to1 m1(data[31:16], mux_1, sel[3:0]);
	mux16to1 m2(data[15:0], mux_2, sel[3:0]);
	mux2to1  m3(mux_1, mux_2, q, sel[4]);

endmodule




	
	
	
	
	
