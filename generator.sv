class generator;
  transactor trans;
  mailbox gen2drv;
  
  function new(mailbox gen2drv);
	this.gen2drv=gen2drv;
  endfunction
  
  task main();
    repeat (no_txn) begin
    transactor trans = new();
    assert(trans.randomize());
    gen2drv.put(trans);
    end
  endtask
  
endclass
