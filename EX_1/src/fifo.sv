`ifndef FIFO_DEF
  `define FIFO_DEF

  `define RESET_STATE 0
module fifo #(parameter WORD_L= 8, DEPTH= 8, PORT_L= 8) (
    input                                   clk,
    input                                   rst,

    input [PORT_L - 1 : 0] [WORD_L -1 : 0]  inputs,
    input                                   in_vld,
    output                                  fifo_rdy,

    output [PORT_L - 1 : 0] [WORD_L -1 : 0] outputs,
    output                                  fifo_vld,
    input                                   mac_rdy
  ); 
  
  localparam ADR_L = $clog2(DEPTH);
  logic [DEPTH - 1 : 0] [PORT_L - 1 : 0] [WORD_L - 1 : 0] fifo_reg;
  logic [ADR_L : 0]                                       wr_adr;
  logic [ADR_L : 0]                                       rd_adr;
  logic                                                   full;
  logic                                                   empty;
  logic                                                   wr_en;
  logic                                                   rd_en;
  
  //-------------------------------------------
  //       Flow control
  //-------------------------------------------
  always_comb begin
    if ((wr_adr [ADR_L - 1 : 0] == rd_adr[ADR_L - 1 : 0]) && (wr_adr[ADR_L] != rd_adr[ADR_L])) begin
      full = 1;
    end else begin
      full = 0;
    end
    if (wr_adr == rd_adr) begin
      empty = 1;
    end else begin
      empty = 0;
    end
  end
  
  assign fifo_rdy = ~full;
  assign fifo_vld = ~empty;
  assign wr_en    = fifo_rdy && in_vld;
  assign rd_en    = fifo_vld && mac_rdy;

  //-------------------------------------------
  //       Address generation
  //-------------------------------------------
  always_ff @(posedge clk) begin
    if (rst== `RESET_STATE) begin
      wr_adr <= '0;
      rd_adr <= '0;
    end else begin
      if (wr_en) begin
        wr_adr <= wr_adr + 1;
      end
      if (rd_en) begin
        rd_adr <= rd_adr + 1;
      end      
    end
  end
  

  //-------------------------------------------
  //       FIFO registers
  //-------------------------------------------
  always_ff @(posedge clk) begin
    if (rst== `RESET_STATE) begin
      fifo_reg <= '0;
    end else begin
      if (wr_en) begin
        fifo_reg[wr_adr[ADR_L-1 : 0]] <= inputs;
      end
    end
  end
  assign outputs = fifo_reg[rd_adr[ADR_L-1 : 0]];

endmodule
  `undef RESET_STATE
`endif //FIFO_DEF
