interface fifo_if(input logic w_clk, r_clk, w_rst, r_rst);
  
  logic w_en;
  logic r_en;
  logic [7:0]d_in;
  logic [7:0]d_out;
  logic empty, full;
  
endinterface
