//INTERFACE
interface fifo_if(input logic clk)
  logic r_en;
  logic rst;
  logic r_en;
  logic [7:0] wdata;
  logic [7:0] rdata;
  logic full,empty;
  clocking driver_cb@(posedge clk)
    default input #1 output #1;
    output rst;
    output wdata;
    output r_en;
    output w_en;
    input full;
    input empty;
    input rdata;
  endclocking
  
  clocking monitor@(posedge clk);
    input rst;
    input r_en;
    input w_en;
    input rdata;
    input wdata;
    input full;
    input empty;
  endclocking
  
  modport DRIVER(clocking driver_cb,input clk);
  modport MONITOR(clocking monitor, input clk);
endinterface
 
