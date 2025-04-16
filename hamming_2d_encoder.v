module hamming_2d_encoder(
    input [43:0] data_in,
    output [59:0] encoded_out
);

    wire [6:0] row_encoded [3:0];
    wire [27:0] row_block;
    wire [14:0] col_encoded [3:0];

    // Instantiate 4x hamming74 encoder
    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : encode_rows
            hamming74_encoder row_enc(
                .data(data_in[i*11 +: 11][3:0]),
                .encoded(row_encoded[i])
            );
        end
    endgenerate

    // Collect 28-bit row-encoded block
    assign row_block = {
        row_encoded[3],
        row_encoded[2],
        row_encoded[1],
        row_encoded[0]
    };

    // Break into 4 columns of 7 bits, then apply hamming1511_encoder
    generate
        for (i = 0; i < 4; i = i + 1) begin : encode_cols
            wire [10:0] column_data;
            assign column_data = {
                row_encoded[3][i],
                row_encoded[2][i],
                row_encoded[1][i],
                row_encoded[0][i],
                7'b0000000 // pad remaining to make 11 bits
            };

            hamming1511_encoder col_enc(
                .data(column_data),
                .encoded(col_encoded[i])
            );
        end
    endgenerate

    // Combine 4x col_encoded into final 60-bit output
    assign encoded_out = {
        col_encoded[3],
        col_encoded[2],
        col_encoded[1],
        col_encoded[0]
    };

endmodule
