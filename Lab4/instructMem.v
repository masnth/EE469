module instructMem(dataIn, dataOut, addrOut, addrIn, enWrite, clk);

	input clk;
	input [31:0] dataIn;
	input [6:0] addrOut, addrIn;
	input enWrite;
	output reg dataOut;
	
	reg [31:0] mem [127:0];
	
	
	always@(*) begin
		if (enWrite) begin
			mem[addrIn] = dataIn;
		end
		else
			dataOut = mem[addrOut];
	end
endmodule 

