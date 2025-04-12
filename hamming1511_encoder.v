module hamming1511_encoder (
    input [10:0] data, 
    output [14:0] encoded  // [ p1 p2 d0 p3 d1 d2 d3 p3 d4 d5 d6 d7 d8 d9 d10 ]
);
    wire p1, p2, p3, p4;

    // data bits
    assign encoded[2]  = data[0]; 
    assign encoded[4]  = data[1];
    assign encoded[5]  = data[2]; 
    assign encoded[6]  = data[3]; 
    assign encoded[8]  = data[4]; 
    assign encoded[9]  = data[5];
    assign encoded[10] = data[6]; 
    assign encoded[11] = data[7]; 
    assign encoded[12] = data[8];
    assign encoded[13] = data[9];
    assign encoded[14] = data[10];

    // parity bits
    assign p1 = encoded[2] ^ encoded[4] ^ encoded[6] ^ encoded[8] ^ encoded[10] ^ encoded[12] ^ encoded[14];
    assign p2 = encoded[2] ^ encoded[5] ^ encoded[6] ^ encoded[9] ^ encoded[10] ^ encoded[13] ^ encoded[14];
    assign p3 = encoded[4] ^ encoded[5] ^ encoded[6] ^ encoded[11] ^ encoded[12] ^ encoded[13] ^ encoded[14];
    assign p4 = encoded[8] ^ encoded[9] ^ encoded[10] ^ encoded[11] ^ encoded[12] ^ encoded[13] ^ encoded[14];

    assign encoded[0] = p1; 
    assign encoded[1] = p2; 
    assign encoded[3] = p3; 
    assign encoded[7] = p4; 
endmodule
