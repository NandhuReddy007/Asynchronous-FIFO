class environment;
	generator gen;
	driver drv;
	receiver rcv;
	scoreboard sb;
	mailbox gen2drv;
	mailbox rcv2sb;
	mailbox drv2sb;
	virtual fifo_if vif_ff;
  
	function new(virtual fifo_if vif_ff);
      this.vif_ff = vif_ff;
      endfunction
      task build();
      gen2drv=new();
      rcv2sb=new();
      drv2sb=new();
      gen=new(gen2drv) ;
      drv=new(vif_ff, gen2drv,drv2sb);
      rcv=new(vif_ff, rcv2sb);
      sb=new(drv2sb, rcv2sb);
	endtask
  
	task test();
      fork
      gen.main();
      drv.main();
      rcv.main();
      sb.main();
      join_none
     endtask
  
    task run();
      test();
      #500;
      $finish;
	endtask
endclass
