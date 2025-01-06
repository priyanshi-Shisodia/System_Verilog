`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
generator gen;
driver drv;
monitor mon;
scoreboard sco;

virtual counter_intf vif;

mailbox gdmbx;
mailbox msmbx;

event gddone;

function new(mailbox gdmbx, mailbox msmbx);
this.gdmbx = gdmbx;
this.msmbx = msmbx;

gen = new(gdmbx);
drv = new(gdmbx);

mon = new(msmbx);
sco = new(msmbx);
endfunction

task run();
gen.done = gddone;
drv.done = gddone;

drv.vif = vif;
mon.vif = vif;

fork
gen.run();
drv.run();
mon.run();
sco.run();
join_any
endtask
endclass
    

    
      
     
               
              
           
  
