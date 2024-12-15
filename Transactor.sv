// TRANSACTOR
class transactor;
  rand bit r_en;
  rand bit w_en;
  rand bit [7:0] wdata;
  bit [7:0] rdata;
  bit full;
  bit empty;
 // constraint rd_wr_en{ r_en != w_en; }
  
endclass
