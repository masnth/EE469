module dec3to8(i, en, o);
input [2:0]i;
input en;
output [7:0]o;

wire i0n, i1n, i2n;

not n1(i0n, i[0]);
not n2(i1n, i[1]);
not n3(i2n, i[2]);

and d1(o[0], i0n, i1n, i2n, en);
and d2(o[1], i[0], i1n, i2n, en);
and d3(o[2], i0n, i[1], i2n, en);
and d4(o[3], i[0], i[1], i2n, en);
and d5(o[4], i0n, i1n, i[2], en);
and d6(o[5], i[0], i1n, i[2], en);
and d7(o[6], i0n, i[1], i[2], en);
and d8(o[7], i[0], i[1], i[2], en);

endmodule

module dec3to8_testbench();
wire [7:0] o;
reg [2:0] i;
reg en;

dec3to8 dut(i, en, o);

initial begin
 #1;
 i[0] = 1'b0; // time = 0
 i[1] = 1'b0;
 i[2] = 1'b0;
 en = 1'b0;
 #9;
 en = 1'b1; // time = 10
 #10;
 i[0] = 1'b1;
 i[1] = 1'b0;
 i[2] = 1'b0; // time = 20
 #10;
 i[0] = 1'b0;
 i[1] = 1'b1; // time = 30
 i[2] = 1'b0;
 #10;
 i[0] = 1'b1;
 i[1] = 1'b1; 
 i[2] = 1'b0; // time = 40
  #10;
 i[0] = 1'b0;
 i[1] = 1'b0; 
 i[2] = 1'b1; // time = 50
  #10;
 i[0] = 1'b1;
 i[1] = 1'b0; 
 i[2] = 1'b1; // time = 60
  #10;
 i[0] = 1'b0;
 i[1] = 1'b1; 
 i[2] = 1'b1; // time = 70
  #10;
 i[0] = 1'b1;
 i[1] = 1'b1; 
 i[2] = 1'b1; // time = 80
 #5;
 en = 1'b0; // time = 85
 #5;
 end
 
 endmodule
 