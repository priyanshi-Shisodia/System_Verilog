//DRIVER
class driver;
  virtual fifo_if vif;
  mailbox gen2driv;
  
  function new(virtual fifo_if vif,mailbox gen2driv);
    this.vif = vif;
    this.gen2driv = gen2driv;
  endfunction
  
  task reset();
    vif.DRIVER.driver_cb.rst<=1;
    repeat(40)
      @(posedge vif.DRIVER.clk)
      vif.DRIVER.driver_cb.rst<=0;
  endtask : reset
  
  task main();
    fork :main
      forever
        begin
          transactor trans;
          trans=new();
          gen2driv.get(trans);
          
          @(posedge vif.DRIVER.clk)
          if(trans.w_en||trans.r_en)
            begin
              vif.DRIVER.driver_cb.w_en<=trans.w_en;
              vif.DRIVER.driver_cb.r_en<=trans.r_en;
              vif.DRIVER.driver_cb.wdata<=trans.wdata;
             // @posedge( vif.DRIVER.clk);
            end
          else
            begin
              vif.DRIVER.driver_cb.w_en<=trans.w_en;
              vif.DRIVER.driver_cb.r_en<=trans.r_en;
              trans.rdata = vif.MONITOR.monitor.rdata;
              //@posedge( vif.DRIVER.clk);
            end
        end
    join_none :main
  endtask
endclass
    
