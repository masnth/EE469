module dec2to4 (i, en, o);
input [1:0] i;
input en;
output [3:0] o;

wire i0n, i1n;


not n1(i0n, i[0]);
not n2(i1n, i[1]);


and n4(o[0], i0n, i1n, en);
and n5(o[1], i[0], i1n, en);
and n6(o[2], i0n, i[1], en);
and n7(o[3], i[0], i[1], en);

endmodule

module dec2to4_testbench();
wire [3:0] o;
 reg [1:0] i;
 reg en;

 dec2to4 dut(i, en, o);

 initial begin
 $timeformat(-9, 1, " ns", 6); #1;
 i[0] = 1'b0; // time = 0
 i[1] = 1'b0;
 en = 1'b0;
 #9;
 en = 1'b1; // time = 10
 #10;
 i[0] = 1'b1;
 i[1] = 1'b0; // time = 20
 #10;
 i[0] = 1'b0;
 i[1] = 1'b1; // time = 30
 #10;
 i[0] = 1'b1;
 i[1] = 1'b1; // time = 40
 #5;
 en = 1'b0; // time = 45
 #5;
 end

endmodule

