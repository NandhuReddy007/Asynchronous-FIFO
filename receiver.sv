class receiver;
  
virtual fifo_if vif_ff;
mailbox rcv2sb;
transactor trans;
  
  function new(virtual fifo_if vif_ff, mailbox rcv2sb);
    this.vif_ff=vif_ff;
    this.rcv2sb=rcv2sb;
  endfunction
  
  task main();
    wait(!vif_ff.empty)
    vif_ff.r_en=1;
    forever begin
    trans=new();
    @(posedge vif_ff.r_clk)
    if(!vif_ff.empty && vif_ff.r_en)begin
    trans.d_in=vif_ff.d_out;
    rcv2sb.put(trans) ;
    $display("[receiver] :%d", trans.d_in, $time);
    end
    else begin
    vif_ff.r_en = 0;
    end
    end
   
  endtask
  
endclass
