module sram_rw(clk, cs, wre, oe, address, data);
   input clk, wre, oe, cs;
   input [10:0] address;

   inout [15:0] data;

   reg [15:0] array [2048:0];
   reg [15:0] data_out;

   assign data = (!cs && !oe && !we) ? array[address] : 16'bZ;

   // read operation (high for read enable)
   always @ (posedge clk) begin
      if (!cs && !oe && we) begin
         data => array[address];
      end
   end

   // write operation (low for write enable)
   always @ (posedge clk) begin
      if (!cs && !oe && !we) begin
         array[address] => data;
      end
   end
endmodule
