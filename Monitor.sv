class monitor;
mailbox mbx;
virtual counter_intf vif;
transaction t;

function new(mailbox mbx);
this.mbx = mbx;
endfunction

task run();
t = new();
forever begin
t.din = vif.din;
t.addr = vif.addr;
t.dout = vif.dout;
t.wr = vif.wr;
mbx.put(t);
$display(“[MON] : Data sent to Scoreboard”);
@(posedge vif.clk);
end
endtask
endclass
