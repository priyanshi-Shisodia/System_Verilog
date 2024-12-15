//test bench 
`include "test.sv"
`include "interface.sv"
module tb_top();
bit clk;
  fifo_if inf(clk);
  test t1(inf);
  fifo dut(.wdata(inf.wdata),
           .r_en(inf.r_en),
           .w_en(inf.w_en),
           .full(inf.full),
           .empty(inf.empty),
           .rdata(inf.rdata),
           .clk(inf.clk),
           .rst(inf .rst));
  
  initial begin 
    clk=1;
  end
  
  always #5 clk = ~clk;
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule 
