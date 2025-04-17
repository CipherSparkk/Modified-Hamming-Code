module hamming_2d_encoder(
    input [43:0] data_in,
    output [104:0] encoded_out
);
    // Split into 4 rows of 11 bits each
    wire [14:0] row_encoded [3:0];
    
    // Row encoding (15,11) - Fixed bit ranges to ensure correct packing
    hamming1511_encoder row_enc0(.data_in(data_in[10:0]),    .encoded(row_encoded[0]));
    hamming1511_encoder row_enc1(.data_in(data_in[21:11]),   .encoded(row_encoded[1]));
    hamming1511_encoder row_enc2(.data_in(data_in[32:22]),   .encoded(row_encoded[2]));
    hamming1511_encoder row_enc3(.data_in(data_in[43:33]),   .encoded(row_encoded[3]));

    // Interleave rows into columns (4x15 -> 15x4)
    wire [59:0] interleaved;
    interleaver_60bit interleave(
        // Important: Order matters - from MSB to LSB (row 3 to row 0)
        .data_in({row_encoded[3], row_encoded[2], row_encoded[1], row_encoded[0]}),
        .data_out(interleaved)
    );

    // Column encoding (7,4)
    wire [6:0] col_encoded [14:0];
    genvar i;
    generate
        for (i=0; i<15; i=i+1) begin : col_enc
            hamming74_encoder encoder(
                .data(interleaved[i*4 +: 4]),
                .encoded(col_encoded[i])
            );
        end
    endgenerate

    // Final output (105 bits) - Ensure consistent order of columns
    assign encoded_out = {
        col_encoded[14], col_encoded[13], col_encoded[12], col_encoded[11], col_encoded[10],
        col_encoded[9], col_encoded[8], col_encoded[7], col_encoded[6], col_encoded[5],
        col_encoded[4], col_encoded[3], col_encoded[2], col_encoded[1], col_encoded[0]
    };
endmodule