module hamming_2d_decoder(
    input [59:0] encoded_in,
    output [43:0] decoded_out
);

    wire [10:0] col_decoded [3:0];
    wire [3:0] col_error;
    wire [6:0] row_data [3:0];
    wire [3:0] row_error;

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : decode_cols
            hamming1511_decoder col_dec(
                .received(encoded_in[i*15 +: 15]),
                .data(col_decoded[i]),
                .error(col_error[i])
            );
        end
    endgenerate

    // Reconstruct 4 rows of 7 bits each from decoded column data
    generate
        for (i = 0; i < 4; i = i + 1) begin : group_rows
            assign row_data[i] = {
                col_decoded[3][i],
                col_decoded[2][i],
                col_decoded[1][i],
                col_decoded[0][i],
                3'b000  // ignore padding
            };
        end
    endgenerate

    // Decode rows using Hamming (7,4)
    wire [3:0] row_decoded [3:0];

    generate
        for (i = 0; i < 4; i = i + 1) begin : decode_rows
            hamming74_decoder row_dec(
                .received(row_data[i]),
                .data(row_decoded[i]),
                .error(row_error[i])
            );
        end
    endgenerate

    // Combine 4x 4-bit decoded rows into 44-bit output
    assign decoded_out = {
        row_decoded[3],
        row_decoded[2],
        row_decoded[1],
        row_decoded[0],
        28'b0 // Fill up to 44 bits (rest unused unless you expand input)
    };

endmodule
