module addrAdder(addrCurr, addrNext, signal, clk);

	input clk;
	input  [6:0] addrCurr;
	input signal;
	output reg [6:0] addrNext;
	
	always@(*) begin
		if (signal) begin
			addrNext = addrCurr + 4;
		end
		else 
			addrNext = addrCurr + 1;
	end
endmodule
