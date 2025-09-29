class driver;
  transactor trans;
  virtual fifo_if vif_ff;
  mailbox gen2drv;
  mailbox drv2sb;
  
  function new(virtual fifo_if vif_ff, mailbox gen2drv, mailbox drv2sb);
    this.vif_ff = vif_ff;
    this.gen2drv = gen2drv;
    this.drv2sb = drv2sb;
  endfunction
  
  task main();
    repeat(no_txn)@(posedge vif_ff.w_clk)begin
      if(!vif_ff.full)begin
        gen2drv.get(trans);
        drv2sb.put(trans);
        vif_ff.w_en=1;
        vif_ff.d_in=trans.d_in;
        $display("[DRIVER] %d %d--%d",vif_ff.d_in,vif_ff.w_en,no_txn);
      end
      else begin
        vif_ff.w_en=0;
        wait(!vif_ff.full);
        gen2drv.get(trans);
        drv2sb.put(trans);
        vif_ff.w_en=1;
        vif_ff.d_in=trans.d_in;
      end
    end
    @(posedge vif_ff.w_clk)
    vif_ff.w_en=0;
    
  endtask
               
               
endclass
