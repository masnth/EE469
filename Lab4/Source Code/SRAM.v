module sramf(data, addr, write_data, we, oe, clk);
	input oe, we, clk;
	input [10:0] addr;

	output [15:0] data;
	
	input [15:0] write_data;

	reg [15:0] sramArray [2047:0];
	
	assign data = oe ?  sramArray[addr] : 16'bZ;

	always @ (posedge clk)
		begin
			if (we)
				sramArray[addr] <= write_data;
		end
		
	initial begin
		$readmemb("data.dat", sramArray);
	end
endmodule