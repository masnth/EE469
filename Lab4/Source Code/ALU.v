

module ALU(out, v, c, n ,z, a, b, control, shamt, clk, rst);
	input clk, rst;
	input [31:0] a, b; // data input
	input [2:0] control; // control bits
	input [2:0] shamt; //shift amount
	
	output wire [31:0] out; // result
	
	output wire v; // overflow
	output wire c;	// carry out
	output wire n; // negative
	output wire z; // zero
	
	wire [31:0] outAND, outOR, outXOR, outADD, outSUB, outSHL;
	wire c1, c2, c3, c4, c5, c6;
	wire v1, v2, v3, v4, v5, v6;
	
	ls l1(outSHL, c1, v1, a, shamt);
	addx32 a1(outADD, c2, v2, a, b); //(control[0]&~control[1]&~control[2]), clk);
	subx32 s1(outSUB, c3, v3, a, b); //(control[0]&control[1]&~control[2]), clk);
	ANDR an2(outAND, c4, v4, a, b);
	ORR o1(outOR, c5, v5, a, b);
	XORR x1(outXOR, c6, v6, a, b);
	//assign c = (c1 | c2 | c3 | c4 | c5 | c6);
	//assign v = (v1 | v2 | v3 | v4 | v5 | v6);
	assign n = out[31];
	isZero i1(z, out);
	
	mux8to1 m1('d0, c2, c3, c4, c5, c6, c1, 'd0, c, control);
	mux8to1 m2('d0, v2, v3, v4, v5, v6, v1, 'd0, v, control);
	mux8_1x32 m3(out, 32'b0, outADD, outSUB, outAND, outOR, 
							outXOR, outSHL, 32'd1, control);


endmodule


// 1 bit full adder
module FA(s, cout, a, b, cin);
	output wire s, cout;
	input a, b, cin;
	assign s = a^b^cin;
	//assign s = s^c;
	assign 	cout = (a&b) | (a&cin) | (b&cin);
endmodule 

// 32 bit full adder
// check ripple carry adder (A+B)
module addx32(output wire [31:0] out, output wire c, output wire o, input [31:0] a, b); //input enable, clk);
	CLA_32 c1(out, c, o, a, b, 'd0);
endmodule	

// 32 bit sub
// do a - b
module subx32(output wire[31:0] out, output wire c, output wire o, input [31:0] a, b); // input enbale, clk);
	
	CLA_32 c1(out, c, o, a, ~b, 'd1);
endmodule	

// mux 
module mux(out, a0, a1, sel);
	//input clk;
	input a0, a1, sel;
	output reg out;
	always @(*)
		if (sel == 1'b0)
			out = a0;
		else 
			out = a1;
endmodule

// left shift 1 bit.
module ls(out, c, o, in, bitS);
	output wire c, o;
	input [31:0] in;
	input [2:0] bitS;
//	input clk;
	
	output wire [31:0] out;
	wire [31:0] out2b, out4b;
	genvar i;
	generate
		mux m40(out4b[0], in[0], 1'b0, bitS[2]);
		mux m41(out4b[1], in[1], 1'b0, bitS[2]);
		mux m42(out4b[2], in[2], 1'b0, bitS[2]);
		mux m43(out4b[3], in[3], 1'b0, bitS[2]);
		
		mux m20(out2b[0], out4b[0], 1'b0, bitS[1]);
		mux m21(out2b[1], out4b[1], 1'b0, bitS[1]);
		mux m22(out2b[2], out4b[2], out4b[0], bitS[1]);
		mux m23(out2b[3], out4b[3], out4b[1], bitS[1]);
		
		mux m10(out[0], out2b[0], 1'b0, bitS[0]);
		mux m11(out[1], out2b[1], out2b[0], bitS[0]);
		mux m12(out[2], out2b[2], out2b[1], bitS[0]);
		mux m13(out[3], out2b[3], out2b[2], bitS[0]);
		
		for (i = 4; i < 32; i=i+1) begin:eachMux
			mux m4(out4b[i], in[i], in[i-4], bitS[2]);
			mux m2(out2b[i], out4b[i], out4b[i-2], bitS[1]); //out, a0, a1, sel, clk
			mux m1(out[i], out2b[i], out2b[i-1], bitS[0]);
		end
	endgenerate
	assign c = 0;
	assign o = 0;
endmodule


//module AND
module ANDR(out, c, o, a0, a1);
	output wire c, o;
	output wire [31:0] out;
	input [31:0] a0, a1;
	assign out = a0 & a1;
	assign c = 0;
	assign o = 0;
endmodule

// module Or
module ORR(out, c, o, a0, a1);
	output wire c, o;
	output wire [31:0] out;
	input [31:0] a0, a1;
	assign out = a0 | a1;
	assign c = 0;
	assign o = 0;
endmodule


//XOR module
module XORR(out, c, o, a0, a1);
	output wire c, o;
	output wire [31:0] out;
	input [31:0] a0, a1;
	assign out = a0 ^ a1;
	assign c = 0;
	assign o = 0;
endmodule	

//zero
module isZero(out, in);
	output out;
	input [31:0] in;
	wire [31:0] in0, in1, in2, in3, in4;
//	wire [7:0] in1;
//	wire [3:0] in2;
//	wire [1:0] in3;
	assign in4 = in | 32'd0;
	assign in0 = in4[31:16] | in4[15:0];
	assign in1 = in0[15:8] | in0[7:0];
	assign in2 = in1[7:4] | in1[3:0];
	//assign in3 = in2[3:2] | in2[1:0];
	assign out = ~(in2[3] | in2[2] | in2[1] | in2[0]);
endmodule
	