module mux2_1(out, a0, a1, sel);
	output out;
	input a0, a1;
	input sel;
	
	wire w1,w2,w3;
	
	not n1(w1,sel);
	and an1(w2,w1,a0);
	and an2(w3,sel,a1);
	or o1(out,w2,w3);
endmodule


module mux2_1x32(out, a0, a1, sel);
	output wire [31:0] out;
	input [31:0] a0, a1;
	input sel;
	
	genvar i;
	generate 
		for (i=0; i < 32; i=i+1) begin: eachMux
			mux2_1 m21(out[i], a0[i], a1[i], sel);
		end
	endgenerate
endmodule 

module mux4_1x32(out, a0, a1, a2, a3, sel);
	output wire [31:0] out;
	input [31:0] a0, a1, a2, a3;
	input [1:0] sel;
	
	wire [31:0] out0, out1;
	
	mux2_1x32 m1(out0, a0, a1, sel[0]);
	mux2_1x32 m2(out1, a2, a3, sel[0]);
	mux2_1x32 m3(out, out0, out1, sel[1]);
	
endmodule

module mux8_1x32(out, a0, a1, a2, a3 ,a4, a5, a6, a7, sel);
	output wire [31:0] out;
	input [31:0] a0, a1, a2, a3 ,a4, a5, a6, a7;
	input [2:0] sel;
	
	wire [31:0] out0, out1;
	
	mux4_1x32 m1(out0, a0, a1, a2, a3, sel[1:0]);
	mux4_1x32 m2(out1, a4, a5, a6, a7, sel[1:0]);
	mux2_1x32 m3(out, out0, out1, sel[2]);
	
endmodule




