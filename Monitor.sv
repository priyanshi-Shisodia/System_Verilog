//MONITOR
class monitor;
  
virtual fifo_if vif;
mailbox rcvr2sb;
  
  function new(virtual fifo_if vifo,mailbox rcvr2sb);
    this.vif = vif;
    if(rcvr2sb==null)
      begin
        $finish;
      end
    else
      this.rcvr2sb = rcvr2sb;
  endfunction :new
  
task start();
  fork
  forever begin
    transactor trans;
    trans = new();
    $display("=======Mode of Operation=======");
    @posedge(vif.MONITOR.clk);
    wait(vif.MONITOR.monitor.r_en || vif.MONITOR.monitor.w_en)
    @posedge(vif.MONITOR.clk);
    if(vif.MONITOR.monitor.w_en)
      begin
        trans.w_en = vif.MONITOR.monitor.w_en;
        trans.r_en = vif.MONITOR.monitor.r_en;
        trans.wdata = vif.MONITOR.monitor.wdata;
        trans.full = vif.MONITOR.monitor.full;
        trans.empty = vif.MONITOR.monitor.empty;
        
        if(trans.full)
          $display("\w_en = %h     Memory is full",vif.MONITOR.monitor.w_en);
        else
          $display("\w_en=%h  \wdata=%h",vif.MONITOR.monitor.w_en,vif.MONITOR.monitor.wdata);
      end
    else begin
      trans.r_en = vif.MONITOR.monitor.r_en;
      trans.w_en = vif.MONITOR.monitor.w_en;
      trans.rdata = vif.MONITOR.monitor.rdata;
      trans.full = vif.MONITOR.monitor.full;
      trans.empty = vif.MONITOR.monitor.empty;
      if(trans.empty)
        $display("\r_en=%h    Memory is empty",vif.MONITOR.monitor.r_en);
      else
        $display("\r_en=%h   \rdata=%h",vif.MONITOR.monitor.r_en, vif.MONITOR.monitor.rdata);
    end
    rcvr2sb.put(trans);
  end
  join_none
endtask:start
endclass

        
