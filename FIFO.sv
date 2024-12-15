// FIFO Design
module fifo(clk,rst,rdata,wdata,r_en,w_en,full,empty);
input clk,rst,w_en,r_en;
output reg full, empty;
  input [7:0] wdata;
  output reg [7:0] rdata;
  reg [5:0]w_ptr;
  reg [5:0]r_ptr;
  reg [7:0] mem [31:0];
  integer i;
  
  //writing data into the FIFO
  always@(posedge clk,posedge rst)
    if(rst) begin
      for(i=0;i<=32;i=i+1)
        mem[i]<=8'b0;
    end
  else if(w_en & ~full)
    mem[w_ptr]<=wdata;
  
  //reading data from FIFO
  always@(posedge clk,posedge rst)
    if(rst) begin
      rdata<=8'b0;
    end
  else if(r_en & ~empty)
    rdata <= mem[r_ptr];
  
  //Pointer Block
  always@(posedge clk,posedge rst)
    if(rst)
      w_ptr<=6'b0;
  else if(w_en & ~full)
    w_ptr<=w_ptr+1;
  
  always@(posedge clk,posedge rst)
    if(rst)
      r_ptr<=6'b0;
  else if(r_en & ~empty)
    r_ptr<=r_ptr+1;
  
  assign empty = (r_ptr==w_ptr);
  assign full = ((w_ptr[4:0]==r_ptr[4:0]) && (w_ptr[5] != r_ptr[5]));
  
                 endmodule
