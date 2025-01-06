class driver;
mailbox mbx;
event done;
transaction t;
virtual counter_intf vif;

function new(mailbox mbx);
this.mbx = mbx;
endfunction

task run();
t = new();
forever begin
mbx.get(t);
vif.din = t.din;
vif.addr = t.addr;
$display(“[DRV] : Interface Trigger”);
->done;
@(posedge vif.clk);
end
endtask
endclass
    
