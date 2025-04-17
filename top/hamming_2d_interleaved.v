module hamming_2d_interleaved(
    input [43:0] data_in,
    output [104:0] encoded_out,
    input [104:0] received_in,
    output [43:0] decoded_out,
    output error_detected
);
    // Instantiate encoder
    hamming_2d_encoder encoder_inst (
        .data_in(data_in),
        .encoded_out(encoded_out)
    );

    // Instantiate decoder
    hamming_2d_decoder decoder_inst (
        .encoded_in(received_in),
        .decoded_out(decoded_out),
        .error_detected(error_detected)
    );
endmodule