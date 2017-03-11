module mux2to1(data1, data2, q, sel);

	output q;
	input sel,data1 , data2;
	wire w1,w2,w3;
	not n1(w1,sel);
	and a1(w2,w1,data1);
	and a2(w3,sel,data2);
	or o1(q,w2,w3);
	
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

module mux8to1(d0, d1, d2, d3, d4, d5, d6, d7, q, sel);
	input d0, d1, d2, d3, d4, d5, d6, d7;
	input[2:0] sel;
	output q;
	wire q1, q2;
	mux4to1 m1(d0, d1, d2, d3, q1, sel[1:0]);
	mux4to1 m2(d4, d5, d6, d7, q2, sel[1:0]);
	mux2to1 m3(q1, q2, q, sel[2]);
endmodule
	
module mux16to1(data, q, sel);

	input [15:0] data;
	input [3:0] sel;
	output q;
	
	wire mux_1, mux_2, mux_3, mux_4;
	
	mux4to1 m1(data[0], data[1], data[2], data[3], mux_1, sel[1:0]); 
	mux4to1 m2(data[4], data[5], data[6], data[7], mux_2, sel[1:0]);
	mux4to1 m3(data[8], data[9], data[10], data[11], mux_3, sel[1:0]);
	mux4to1 m4(data[12], data[13], data[14], data[15], mux_4, sel[1:0]);
	mux4to1 m5(mux_1, mux_2, mux_3, mux_4, q, sel[3:2]);
	
endmodule

module mux32to1(data, q, sel);

	input [31:0] data;
	input [4:0] sel;
	output q;
	
	wire mux_1, mux_2;
	
	mux16to1 m1(data[31:16], mux_1, sel[3:0]);
	mux16to1 m2(data[15:0], mux_2, sel[3:0]);
	mux2to1  m3(mux_2, mux_1, q, sel[4]);

endmodule




	
	
	
	
	
