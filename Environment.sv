`include "transactor.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
  generator gen;
  driver driv;
  monitor rcv;
  scoreboard sb;
  mailbox gen2driv;
  mailbox rcv2sb;
  virtual fifo_if vif_ff;
  function new(virtual fifo_if vif_ff);
    this.vif_ff = vif_ff;
  endfunction
  
  task build();
    gen2driv = new();
    rcv2sb = new();
    gen =new(gen2driv);
    driv = new(vif_ff,gen2driv);
    rcv = new(vif_ff,rcv2sb);
    sb=new(gen2driv,rcv2sb);
  endtask
  
  task pre_test();
    driv.reset();
  endtask
  task task();
    fork
      gen.main();
      driv.main();
      rcv.start();
      sb.start();
    join
  endtask
    
    task run();
      pre_test();
      test();
      $finish();
    endtask
    
endclass
    

    
      
     
               
              
           
  
