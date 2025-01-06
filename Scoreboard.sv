class scoreboard;
mailbox mbx;
transaction tarr[256];
transaction t;

function new(mailbox mbx);
this.mbx = mbx;
endfunction

task run();
forever begin
mbx.get(t);

if (t.wr == 1'b1) begin
if (tarr[t.addr] == null) begin
tarr[t.addr] = new();
tarr[t.addr] = t;
$display(“[SCO] : Data stored”);
end
end else begin
if (tarr[t.addr] == null) begin
if (t.dout == 0)
$display(“[SCO] : Data read Test Passed”);
else
$display(“[SCO] : Data read Test Failed”);
end else begin
if (t.dout == tarr[t.addr].din)
$display(“[SCO] : Data read Test Passed”);
else
$display(“[SCO] : Data read Test Failed”);
end
end
end
endtask
endclass
