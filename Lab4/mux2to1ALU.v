module mux2to1ALU(clk, imm_sig, regData, instData, dataOut);

	input clk;
	input imm_sig;
	input [31:0] regData;
	input [31:0] instData;
	output reg [31:0] dataOut;
	
	always@(posedge clk) begin
		if (imm_sig) 
			dataOut = {20'b0,instData};
		else
			dataOut = regData;
	end
endmodule
