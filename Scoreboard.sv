class scoreboard;
  
mailbox gen2driv;
mailbox rcvr2sb;
  integer compare;
  
  function new(mailbox gen2driv,mailbox rcvr2sb);
    this.gen2driv = gen2driv;
    this.rcvr2sb = rcvr2sb;
  endfunction :new
  
  task start();
    transactor trans_rcv,trans;
    trans_rcv = new();
    fork
    forever
    begin
      rcvr2sb.get(trans_rcv);
      gen2driv.get(trans);
      /* $display("==========Scoreboard========");
      begin
        compare =1'b0;
        if(trans.w_en==trans_rcv.w_en && trans.r_en==trans_rcv.r_en)
          compare =1;
      end
      if(trans_rcv.full || trans_rcv.empty) begin
        if(trans_rcv.full)
          $display("\w_en=%0h    memory is full",trans_rcv.w_en);
        else 
          $display("\w_en=%0h  \wdata=%0h",trans_rcv.w_en,trans_rcv.wdata);
      end
      if(trans_rcv.empty)
        $display("\r_en=%0h    memory is empty",trans_rcv.r_en);
      else
        $display("\r_en=%0h  \rdata=%0h",trans_rcv.r_en,trans_rcv.rdata);
      if(compare==1)
        $display("Yes");
      else
        $display("No");*/
    end
    join_none
  endtask :start
endclass

        
