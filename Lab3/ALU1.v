module ALU(out, v, c, n ,z, a, b, control, clk, rst);
	input clk, rst;
	input [31:0] a, b; // data input
	input [2:0] control; // control bits
	output reg [31:0] out; // result
	
	output reg v; // overflow
	output wire c;	// carry out
	output reg n; // negative
	output reg z; // zero
	
	wire [31:0] outADD, outSUB, outSHL;
	wire c1;
	
	ls l1(outSHL, a, b[1:0], clk);
	addx32 a1(outADD, c1, a, b); //(control[0]&~control[1]&~control[2]), clk);
	subx32 s1(outSUB, c1, a, b); //(control[0]&control[1]&~control[2]), clk);
	
	always @ (control)
	case (control)
	3'b000: //NOP
			out = 0;
	3'b001: // ADD
			out = outADD;
	3'b010: // SUB
			out = outSUB;
	3'b011: // AND
			out = a & b;
	3'b100: // ORR
			out = a | b;
	3'b101: // XOR
			out = a ^ b;
	3'b110: // LSL
			out = outSHL;
	endcase

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
module addx32(output wire [31:0] out, output wire c, input [31:0] a, b); //input enable, clk);
	wire [31:0] cin;
	genvar i;
	generate
		FA f1 (.s(out[0]), .cout(cin[0]), .a(a[0]), .b(b[0]), .cin(1'b0));
		for (i = 1; i < 32; i = i+1) begin: eachFA
			FA f(.s(out[i]), .cout(cin[i]), .a(a[i]), .b(b[i]), .cin(cin[i-1]));
		end
	endgenerate 
	assign c = cin[31];
endmodule	

// 32 bit sub
// do a - b
module subx32(output wire[31:0] out, output wire c, input [31:0] a, b); // input enbale, clk);
	wire [31:0] cin;
	genvar i;
	generate
		FA f1 (out[0], cin[0], a[0], ~b[0], 1'b1);
		for (i = 1; i < 32; i = i+1) begin: eachFA
			FA f (out[i], cin[i], a[i], ~b[i], cin[i-1]);
		end
	endgenerate
	assign c = cin[31];
endmodule	

// mux 
module mux(out, a0, a1, sel, clk);
	input clk;
	input a0, a1, sel;
	output reg out;
	always @(posedge clk)
		if (sel == 1'b0)
			out = a0;
		else 
			out = a1;
endmodule

// left shift 1 bit.
module ls(out, in, bitS, clk);
	input [31:0] in;
	input [1:0] bitS;
	input clk;
	
	output wire [31:0] out;
	wire [31:0] out2b;
	genvar i;
	generate
		mux m20(out2b[0], in[0], 1'b0, bitS[1], clk);
		mux m21(out2b[1], in[1], 1'b0, bitS[1], clk);
		mux m11(out[0], out2b[0], 1'b0, bitS[0], clk);
		mux m12(out[1], out2b[1], out2b[0], bitS[0], clk);
		for (i = 2; i < 32; i=i+1) begin:eachMux
			mux m2(out2b[i], in[i], in[i-2], bitS[1], clk); //out, a0, a1, sel, clk
			mux m1(out[i], out2b[i], out2b[i-1], bitS[0], clk);
		end
	endgenerate
endmodule
	
