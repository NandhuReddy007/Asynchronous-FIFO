`include "package_tb.sv"
`include "interface.sv"
`include "test.sv"

module tb_top();
  bit w_clk, r_clk, w_rst, r_rst;

  fifo_if inf(w_clk, r_clk, w_rst, r_rst);
  
  test t1(inf);

  fifo_16_8 dut(
    .w_clk(inf.w_clk), .r_clk(inf.r_clk),
    .w_rst(inf.w_rst), .r_rst(inf.r_rst),
    .r_en(inf.r_en), .w_en(inf.w_en),
    .d_in(inf.d_in), .full(inf.full),
    .empty(inf.empty), .d_out(inf.d_out)
  );

  
  property forced_write_when_full;
    @(posedge w_clk) disable iff(r_rst||w_rst)
    (inf.full && inf.w_en) |-> $stable(inf.d_in);
  endproperty
  
  property forced_read_when_empty;
    @(posedge r_clk) disable iff(r_rst||w_rst)
    (inf.empty && inf.r_en) |-> $stable(inf.d_out);
  endproperty
  
  a1: assert property(forced_write_when_full) begin $display("ASSERTION1 PASSED"); end
    else $display("ASSERTION1 FAILED");
  
  a2: assert property( forced_read_when_empty) begin $display("ASSERTION2 PASSED"); end
    else $display("ASSERTION2 FAILED");
    

  initial begin
    w_clk = 0;
    r_clk = 0;
    w_rst = 1;
    r_rst = 1;
    #10 w_rst = 0;
    #10 r_rst = 0;
    
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_top);
   
  end

  always #5 w_clk = ~w_clk;
  always #10 r_clk = ~r_clk;

endmodule

