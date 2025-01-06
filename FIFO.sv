module fifo (
input reset, clk, rd, wr,
input [7:0] din,
output full, empty,
output reg [7:0] dout,
output reg [3:0] fifo_cnt
);

reg [7:0] fifo_ram [0:7];
reg [2:0] wr_ptr, rd_ptr;

//Defination of “empty” and “full”

assign empty = (fifo_cnt == 0);
assign full = (fifo_cnt == 8);

// Write
always @(posedge clk) begin
if (wr && !full) begin
fifo_ram[wr_ptr] <= din;
wr_ptr <= wr_ptr + 1;
fifo_cnt <= fifo_cnt + 1;
end
end

// Read
always @(posedge clk) begin
if (rd && !empty) begin
dout <= fifo_ram[rd_ptr];
rd_ptr <= rd_ptr + 1;
fifo_cnt <= fifo_cnt — 1;
end
end

//Pointer Block
always @(posedge clk or posedge reset) begin
if (reset) begin
wr_ptr <= 0;
rd_ptr <= 0;
end

else begin
if (wr && !full || wr && rd) wr_ptr <= wr_ptr + 1;
if (rd && !empty || rd && wr) rd_ptr <= rd_ptr + 1;
end
end

//FIFO Counter

always @(posedge clk or posedge reset) begin
if (reset)
fifo_cnt <= 0;
else
case ({rd, wr})
2'b01: fifo_cnt <= (fifo_cnt == 8) ? 8 : fifo_cnt + 1;
2'b10: fifo_cnt <= (fifo_cnt == 0) ? 0 : fifo_cnt — 1;
endcase
end

endmodule
