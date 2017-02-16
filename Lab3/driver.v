module driver(SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, CLOCK_50);

	input CLOCK_50;
	input [9:0] SW;
	input [3:0] KEY;
	output [6:0] HEX0, HEX1, HEX2, HEX3;
	output [9:0] LEDR;
	
	wire [3:0]  switchData;
	wire [31:0] dataIn;
	wire [31:0] dataA;
	wire [31:0] dataB;
	wire [31:0] result;
	wire [31:0] resToHex;
	wire [31:0] toHexDis;
	wire v, c, n, z;
	
	inputData i (.hexDigit(SW[3:0]), .dataOut(dataIn));
	
	readRe r (.enable(~KEY[0]), .data1(dataA), .data2(dataB), .dataIn(dataIn), .resultIn(result), .resultOut(resToHex),  .select(SW[9:8]), .clk(CLOCK_50) );
	
	process p (.enable(~KEY[1]), .control(SW[6:4]), .bits(2'b11), .v(v), .c(c), .n(n), .z(z), .data1(dataA), .data2(dataB), .dataOut(result), .clk(CLOCK_50));
	
	hexDisplay h1 (.dataA(dataA), .dataB(dataB), .result(resToHex), .sel(SW[9:8]), .dataOut(toHexDis), .clk(CLOCK_50));
	
	HexControl h2 (toHexDis[31:28], HEX3);

	HexControl h3 (toHexDis[20:17], HEX2);
	
	HexControl h4 (toHexDis[10:7], HEX1);

	HexControl h5 (toHexDis[3:0], HEX0);


endmodule
	