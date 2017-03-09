module mux2to1ALU(clk, imm_sig, regData, instData, dataOut);
	// picking which data as the second data to ALU (from register or immidiate value from instruction)
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
