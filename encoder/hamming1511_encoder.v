module hamming1511_encoder (
    input [10:0] data_in,  // [d10 d9 d8 d7 d6 d5 d4 d3 d2 d1 d0]
    output [14:0] encoded  // [p0 p1 d0 p2 d1 d2 d3 p3 d4 d5 d6 d7 d8 d9 d10]
);
    // Data bits
    assign encoded[2]  = data_in[0];   // d0
    assign encoded[4]  = data_in[1];   // d1
    assign encoded[5]  = data_in[2];   // d2
    assign encoded[6]  = data_in[3];   // d3
    assign encoded[8]  = data_in[4];   // d4
    assign encoded[9]  = data_in[5];   // d5
    assign encoded[10] = data_in[6];   // d6
    assign encoded[11] = data_in[7];   // d7
    assign encoded[12] = data_in[8];   // d8
    assign encoded[13] = data_in[9];   // d9
    assign encoded[14] = data_in[10];  // d10

    // Parity bits
    assign encoded[0] = encoded[2] ^ encoded[4] ^ encoded[6] ^ encoded[8] ^ encoded[10] ^ encoded[12] ^ encoded[14];
    assign encoded[1] = encoded[2] ^ encoded[5] ^ encoded[6] ^ encoded[9] ^ encoded[10] ^ encoded[13] ^ encoded[14];
    assign encoded[3] = encoded[4] ^ encoded[5] ^ encoded[6] ^ encoded[11] ^ encoded[12] ^ encoded[13] ^ encoded[14];
    assign encoded[7] = encoded[8] ^ encoded[9] ^ encoded[10] ^ encoded[11] ^ encoded[12] ^ encoded[13] ^ encoded[14];
endmodule