module fifo_16_8 #(
  parameter WIDTH = 8,
  parameter DEPTH = 16)
  (input w_clk,
  input r_clk,
  input w_rst,
  input r_rst,
  input r_en,
  input w_en,
  input [WIDTH-1:0] d_in,
  output full,
  output empty,
  output reg [WIDTH-1:0] d_out);
  
  integer k;
  reg [4:0] r_addr, w_addr;
  reg [4:0] r_addr_sync1, r_addr_sync2; // Synchronizers for read address to write domain
  reg [4:0] w_addr_sync1, w_addr_sync2; // Synchronizers for write address to read domain
  reg [WIDTH-1:0] memory [DEPTH-1:0];
  
  always @(posedge w_clk) begin

    if (w_rst) begin
      for (k = 0; k < DEPTH; k = k + 1)
      memory[k] <= 0;
    end
    else begin
      if (w_en && ~full)
        memory[w_addr[3:0]] <= d_in;
      end
    end
  
    always @(posedge r_clk) begin
      if (r_rst) begin
        d_out <= 1'b0;
      end
      else begin
        // Read from memory when enabled and not empty
        if (r_en && ~empty)
        d_out <= memory[r_addr [3: 0] ];
        $display("FROM MEM :%d", memory[r_addr[3:0]]);
    end
  end
  // Write address generation (w_clk domain)
  always @(posedge w_clk) begin
  if (w_rst) begin
  w_addr <= 0;
  end
  else if (w_en && ~full) begin
  w_addr <= w_addr + 1'b1;
  end
  end
  
// Read address generation (r_clk domain)
  always @(posedge r_clk) begin
    if (r_rst) begin
      r_addr <= 0;
    end
    else if (r_en && ~empty) begin
      r_addr <= r_addr + 1'b1;
    end
    end
  
  // Synchronize read address to write clock domain (for full flag)
    always @(posedge w_clk) begin
      if (w_rst) begin
        r_addr_sync1 <= 0;
        end
      else begin
        r_addr_sync1 <= r_addr; // First stage synchronizer
      end
  end
  
  always @(posedge w_clk) begin
    if (w_rst) begin
      r_addr_sync2 <= 0;
    end
    else begin
      r_addr_sync2 <= r_addr_sync1; // Second stage synchronizer

    end// Synchronize write address to read clock domain (for empty flag)
  end
  
  always @(posedge r_clk) begin
    if (r_rst) begin
      w_addr_sync1 <= 0;
    end
    else begin
      w_addr_sync1 <= w_addr;// First stage synchronizer
    end
  end
  
  always @(posedge r_clk) begin
    if (r_rst) begin
      w_addr_sync2 <= 0;
    end
    else begin
      w_addr_sync2 <= w_addr_sync1; 
    end
    end
  
  assign empty = (r_addr == w_addr_sync2) ? 1'b1 : 1'b0;
 
  assign full=((w_addr[3:0] == r_addr_sync2[3:0]) && (w_addr[4] != r_addr_sync2[4]) ) ? 1'b1 : 1'b0;
  
endmodule
