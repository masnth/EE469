module dec5to32(in, en, out);

input [4:0] in;
input en;
output [31:0] out;
wire [3:0] enb;

dec2to4 a1(.i(in[4:3]), .en(en), .o(enb));
dec3to8 a2(.i(in[2:0]), .en(enb[0]), .o(out[7:0]));
dec3to8 a3(.i(in[2:0]), .en(enb[1]), .o(out[15:8]));
dec3to8 a4(.i(in[2:0]), .en(enb[2]), .o(out[23:16]));
dec3to8 a5(.i(in[2:0]), .en(enb[3]), .o(out[31:24]));


endmodule

module dec5to32_testbench();
wire [31:0] out;
reg [4:0] in;
reg en;

dec5to32 dut(in, en, out);

initial begin
 #1;
 in[0] = 1'b0; // time = 0
 in[1] = 1'b0;
 in[2] = 1'b0;
 in[3] = 1'b0;
 in[4] = 1'b0;
 en = 1'b0;
 #9;
 en = 1'b1; // time = 10
 #10;
 in[0] = 1'b1;
 in[1] = 1'b0;
 in[2] = 1'b0; // time = 20
 in[3] = 1'b0;
 in[4] = 1'b0;
 #10;
 in[0] = 1'b0;
 in[1] = 1'b1; // time = 30
 in[2] = 1'b0;
 in[3] = 1'b0;
 in[4] = 1'b0;
 #10;
 in[0] = 1'b1;
 in[1] = 1'b1; 
 in[2] = 1'b0; // time = 40
 in[3] = 1'b0;
 in[4] = 1'b0;
  #10;
 in[0] = 1'b0;
 in[1] = 1'b0; 
 in[2] = 1'b1; // time = 50
 in[3] = 1'b0;
 in[4] = 1'b0;
  #10;
 in[0] = 1'b1;
 in[1] = 1'b0; 
 in[2] = 1'b1; // time = 60
 in[3] = 1'b0;
 in[4] = 1'b0;
  #10;
 in[0] = 1'b0;
 in[1] = 1'b1; 
 in[2] = 1'b1; // time = 70
 in[3] = 1'b0;
 in[4] = 1'b0;
  #10;
 in[0] = 1'b1;
 in[1] = 1'b1; 
 in[2] = 1'b1; // time = 80
 in[3] = 1'b0;
 in[4] = 1'b0;
 #10;
 in[0] = 1'b1;
 in[1] = 1'b1; 
 in[2] = 1'b1; // time = 90
 in[3] = 1'b0;
 in[4] = 1'b0;
 #10;
 in[0] = 1'b0;
 in[1] = 1'b0; 
 in[2] = 1'b0; // time = 100
 in[3] = 1'b1;
 in[4] = 1'b0;
 #10;
 in[0] = 1'b1;
 in[1] = 1'b0; 
 in[2] = 1'b0; // time = 120
 in[3] = 1'b1;
 in[4] = 1'b0;
 #10;
 in[0] = 1'b0;
 in[1] = 1'b1; 
 in[2] = 1'b0; // time = 130
 in[3] = 1'b1;
 in[4] = 1'b0;
 #10;
 in[0] = 1'b0;
 in[1] = 1'b0; 
 in[2] = 1'b1; // time = 140
 in[3] = 1'b1;
 in[4] = 1'b0;
 #10;
 in[0] = 1'b1;
 in[1] = 1'b0; 
 in[2] = 1'b1; // time = 150
 in[3] = 1'b1;
 in[4] = 1'b0;
 #10;
 in[0] = 1'b0;
 in[1] = 1'b1; 
 in[2] = 1'b1; // time = 160
 in[3] = 1'b1;
 in[4] = 1'b0;
 #10;
 in[0] = 1'b1;
 in[1] = 1'b1; 
 in[2] = 1'b1; // time = 170
 in[3] = 1'b1;
 in[4] = 1'b0;
 #5;
 en = 1'b0; // time = 175
 #5;
 end
 
 endmodule
	