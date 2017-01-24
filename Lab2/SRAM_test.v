module sramTest(LEDR, CLOCK_50);
	output [9:0] LEDR;
	input CLOCK_50;
	
	wire [15:0] data,readOut;
	wire [10:0] addr;
	wire read, noe;
	
	//write w(data, addr, read, noe, writeDone, CLOCK_50);
	//read r(LEDR, addr, read, noe, data, tBase[20], writeDone);
	
	testDriver td(readOut, data, addr, read, noe, tBase[20]);
	sram s(data, addr, read, noe);
	
	assign LEDR = {2'b00,readOut[7:0]};
	
	reg [24:0] tBase = 0;
	
	always @(posedge CLOCK_50) tBase <= tBase + 1'b1;
	
endmodule

module testDriver(readOut,dataIO, address, read, noe, clk);
	inout [15:0] dataIO;
	output wire [10:0] address;
	output reg [15:0]readOut;
	output read, noe;
	input clk;
	
	reg [7:0] data;
	reg read, noe;
	reg [7:0]addr;
	
	assign dataIO = noe ? {8'b00000000,data} : 16'bZ;
	assign address = {3'b000, addr};
	
	reg [2:0] state = 3'b0; // Write states: 001 set read to low, 010 set read to high, 000 update data and addr, 011 transitioning to reads
									// Read States: 100 write is done start reads, 101 change address, 110 read to buffer
		
	initial
		begin
			noe = 1;
			addr = 8'b11111111;
			data = 8'b10000000;
			readOut = 16'b0;
			read = 1;
		end
	
	always @(posedge clk)
		begin
			case (state)
			3'b000:
				begin
					addr = addr + 1'b1;
					data = data - 1'b1;
					state = 3'b001;
				end
			3'b001:
				begin
					read = 0;
					state = 3'b010;
				end
			3'b010:
				begin
					read = 1;
					if (addr == 8'b01111111)
						state = 3'b011;
					else
						state = 3'b000;
				end
			3'b011:
				begin
					addr = 8'b11111111;					
					state = 3'b100;
					noe = 0;
				end
			3'b100:
				begin
					addr = addr + 1'b1;
					state = 3'b101;
				end
			3'b101:
				begin
					readOut = dataIO;
					if (addr == 8'b01111111)
						state = 3'b110;
					else 
						state = 3'b100;
				end
			3'b110:
				begin
					state = 3'b011;
				end
			
			endcase
		end
	
endmodule

