`ifndef DECOMPRESSOR_DEF
  `define DECOMPRESSOR_DEF
module decompressor #(parameter WORD_L= 8, IN_PORT_L= 4, OUT_PORT_L= 8) (
    input [OUT_PORT_L -1 : 0] header, // header that has 1s at the positions of non-zero words
    input [IN_PORT_L - 1 : 0] [WORD_L - 1 : 0] compressed_inputs, // actual non-zero words
    output[OUT_PORT_L - 1 : 0][WORD_L - 1 : 0] decompressed_outpurs
  ); 
  
  logic [OUT_PORT_L - 1 : 0] [$clog2(IN_PORT_L) - 1 : 0] decompress_sel;
  logic [OUT_PORT_L - 1 : 0][WORD_L - 1 : 0] decompressed_outpurs_pre;

  always_comb begin
    decompress_sel[0] = header[0];
    for (integer i=1; i< OUT_PORT_L ; i=i+1) begin
      decompress_sel[i] = decompress_sel[i-1] + header[i];
    end
  end

  always_comb begin
    foreach (decompressed_outpurs_pre[i]) begin
      if (header[i] == 1) begin
        decompressed_outpurs_pre[i] = compressed_inputs[decompress_sel[i]];
      end else begin
        decompressed_outpurs_pre[i] = '0; 
      end
    end
  end
  
  assign decompressed_outpurs = decompressed_outpurs_pre;

endmodule


`endif //DECOMPRESSOR_DEF
