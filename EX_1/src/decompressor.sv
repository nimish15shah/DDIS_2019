`ifndef DECOMPRESSOR_DEF
  `define DECOMPRESSOR_DEF
module decompressor #(parameter WORD_L= 8, IN_PORT_L= 4, OUT_PORT_L= 8) (
    input [OUT_PORT_L -1 : 0] header, // header that has 1s at the positions of non-zero words
    input [IN_PORT_L - 1 : 0] [WORD_L - 1 : 0] compressed_inputs, // actual non-zero words
    output[OUT_PORT_L - 1 : 0][WORD_L - 1 : 0] decomporessed_outpurs
  ); 
  
  //-------------------------------------------
  //        Block diagram
  //
  //  header                        compressed_inputs
  //                               _____ _____ _____ _____
  //  00101110                    |_____|_____|_____|_____|
  //    ||                                    ||
  //    \/                                    \/
  //  decompress_sel ->      ____  ____  ____  ____  ____  ____       
  //                         \__/  \__/  \__/  \__/  \__/  \__/                 
  //                         _____ _____ _____ _____ _____ _____ _____ _____    
  //  decomporessed_outpurs |_____|_____|_____|_____|_____|_____|_____|_____|   
  //-------------------------------------------


  logic [OUT_PORT_L - 1 : 0] [$clog2(IN_PORT_L) - 1 : 0] decompress_sel;

endmodule


`endif //DECOMPRESSOR_DEF
