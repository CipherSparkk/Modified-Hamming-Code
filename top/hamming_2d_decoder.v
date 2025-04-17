module hamming_2d_decoder(
    input [104:0] encoded_in,
    output [43:0] decoded_out,
    output error_detected
);
    // Column decoding (7,4)
    wire [3:0] col_decoded [14:0];
    wire [14:0] col_errors;
    
    genvar i;
    generate
        for (i=0; i<15; i=i+1) begin : col_dec
            hamming74_decoder decoder(
                .received(encoded_in[i*7 +: 7]),
                .data_out(col_decoded[i]),
                .error_flag(col_errors[i])
            );
        end
    endgenerate

    // Deinterleave (15x4 -> 4x15)
    wire [59:0] deinterleaved;
    deinterleaver_60bit deinter(
        .data_in({
            col_decoded[14], col_decoded[13], col_decoded[12], col_decoded[11], col_decoded[10],
            col_decoded[9], col_decoded[8], col_decoded[7], col_decoded[6], col_decoded[5],
            col_decoded[4], col_decoded[3], col_decoded[2], col_decoded[1], col_decoded[0]
        }),
        .data_out(deinterleaved)
    );

    // Row decoding (15,11)
    wire [10:0] row_decoded [3:0];
    wire [3:0] row_errors;
    
    // Fixed bit ranges to match exact 15-bit boundaries
    hamming1511_decoder row0(.received(deinterleaved[14:0]),    .data_out(row_decoded[0]), .error_detected(row_errors[0]));
    hamming1511_decoder row1(.received(deinterleaved[29:15]),   .data_out(row_decoded[1]), .error_detected(row_errors[1]));
    hamming1511_decoder row2(.received(deinterleaved[44:30]),   .data_out(row_decoded[2]), .error_detected(row_errors[2]));
    hamming1511_decoder row3(.received(deinterleaved[59:45]),   .data_out(row_decoded[3]), .error_detected(row_errors[3]));

    // Final output (44 bits) - Ensure bits are packed correctly
    assign decoded_out = {row_decoded[3], row_decoded[2], row_decoded[1], row_decoded[0]};
    assign error_detected = |col_errors || |row_errors;
endmodule