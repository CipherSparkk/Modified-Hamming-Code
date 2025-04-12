module hamming1511_encoder (
    input [10:0] data,
    output [14:0] encoded
);
    wire p1, p2, p3, p4;
    
    assign encoded[2]  = data[0];  // d0
    assign encoded[4]  = data[1];  // d1
    assign encoded[5]  = data[2];  // d2
    assign encoded[6]  = data[3];  // d3
    assign encoded[8]  = data[4];  // d4
    assign encoded[9]  = data[5];  // d5
    assign encoded[10] = data[6];  // d6
    assign encoded[11] = data[7];  // d7
    assign encoded[12] = data[8];  // d8
    assign encoded[13] = data[9];  // d9
    assign encoded[14] = data[10]; // d10

    // Compute parity bits
    assign p1 = encoded[2] ^ encoded[4] ^ encoded[6] ^ encoded[8] ^ encoded[10] ^ encoded[12] ^ encoded[14];
    assign p2 = encoded[2] ^ encoded[5] ^ encoded[6] ^ encoded[9] ^ encoded[10] ^ encoded[13] ^ encoded[14];
    assign p3 = encoded[4] ^ encoded[5] ^ encoded[6] ^ encoded[11] ^ encoded[12] ^ encoded[13] ^ encoded[14];
    assign p4 = encoded[8] ^ encoded[9] ^ encoded[10] ^ encoded[11] ^ encoded[12] ^ encoded[13] ^ encoded[14];

    assign encoded[0] = p1;  // position 1
    assign encoded[1] = p2;  // position 2
    assign encoded[3] = p3;  // position 4
    assign encoded[7] = p4;  // position 8
endmodule
