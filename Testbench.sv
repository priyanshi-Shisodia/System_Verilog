module tb;
environment env;
counter_intf vif();
mailbox gdmbx, msmbx;

fifo dut (vif.clk, vif.rst, vif.wr, vif.din, vif.addr, vif.dout);

always #5 vif.clk = ~vif.clk;

initial begin
vif.clk = 0;
vif.rst = 1;
vif.wr = 1;
#50;
vif.wr = 1;
vif.rst = 0;
#300;
vif.wr = 0;
#200;
vif.rst = 0;
#50;
end

initial begin
gdmbx = new();
msmbx = new();

env = new(gdmbx, msmbx);
env.vif = vif;
env.run();
#600;
$finish;
end

initial begin
$dumpvars;
$dumpfile(“dump.vcd”);
end
endmodule
