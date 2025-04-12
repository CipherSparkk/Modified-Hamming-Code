module hamming_2d_interleaved (
    input [43:0] data_in,      // 44-bit for input data
    output [104:0] encoded_out, // 105-bit for encoded output
    input [104:0] received_in,  // 105-bit for received data (for decoder)
    output [43:0] corrected_out,// 44-bit for corrected output
    output error_flag           // 1 if uncorrectable error detected
);

  // Encoder  
  wire [43:0] interleaved_data;
  interleaver_44bit interleave (.data_in(data_in), .data_out(interleaved_data));

  wire [104:0] row_encoded;
  hamming_2d_encoder encoder (.data_in(interleaved_data), .encoded_out(row_encoded));
  assign encoded_out = row_encoded;

  // Decoder 
  wire [104:0] col_decoded;
  hamming_2d_decoder decoder (
    .received_in(received_in),
    .corrected_out(col_decoded),
    .error_flag(error_flag)
  );

  wire [43:0] deinterleaved_data;
  deinterleaver_44bit deinterleave (
    .data_in(col_decoded[43:0]), 
    .data_out(corrected_out)
  );
endmodule
