module muxControl ( input, output reg [31:0] readData, input [4:0] sel);


 genvar i;
 
 generate
	for (i = 0; i < 32; i++) begin : eachDff
		mux32to1 mux (.data({reg1[i], reg2[i], reg3[i], reg4[i], reg5[i], reg6[i], reg7[i], reg8[i], reg9[i], 
		reg10[i], reg11[i], reg12[i], reg13[i], reg14[i], reg15[i], reg16[i], reg17[i], reg18[i],reg19[i],
		reg20[i], reg21[i], reg22[i], reg23[i], reg24[i], reg25[i], reg26[i], reg27[i],reg28[i], reg29[i], 
		reg30[i], reg31[i]}), .q(readData[i]), .sel(sel));
	end
 endgenerate
