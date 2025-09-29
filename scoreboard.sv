class scoreboard;
  mailbox rcv2sb;
  mailbox drv2sb;
  transactor trans_drv;
  transactor trans_rcvr;
  int cnt=1;
  
  function new(mailbox drv2sb, mailbox rcv2sb);
    this.drv2sb=drv2sb;
    this.rcv2sb=rcv2sb;
    trans_drv=new();
    trans_rcvr=new();
  endfunction;
  
  task main();
    forever begin
    drv2sb.get(trans_drv);
    rcv2sb.get(trans_rcvr);
    if(trans_rcvr.d_in == trans_drv.d_in)
    $display("EQUAL: %d", cnt++);
    else
    $display("NOT EQUAL");
    end
  endtask
  
  
  
endclass
