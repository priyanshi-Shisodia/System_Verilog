//GENERATOR
class generator;
  //`include "transactor.sv"
  rand transactor trans;
  mailbox gen2driv;
  int repeat_count;
  int count;
  function new(mailbox gen2driv);
    this.gen2driv = gen2driv;
  endfunction
  
  task main();
    repeat(repeat_count)
      begin
        trans=new();
        trans.randomize();
        gen2driv.put(trans);
      end
  endtask
endclass
