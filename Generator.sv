class generator;
mailbox mbx;
transaction t;
event done;
integer i;

function new(mailbox mbx);
this.mbx = mbx;
endfunction

task run();
t = new();
for (i = 0; i < 100; i++) begin
t.randomize();
mbx.put(t);
$display(“[GEN] : Data sent to driver”);
@(done);
end
endtask
endclass
