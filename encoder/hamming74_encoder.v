module hamming74_encoder(
    input [3:0] data,        // [d3 d2 d1 d0]
    output [6:0] encoded     // [p1 p2 d0 p3 d1 d2 d3]
);
    // data bits
    assign encoded[2] = data[0];    // d0
    assign encoded[4] = data[1];    // d1
    assign encoded[5] = data[2];    // d2
    assign encoded[6] = data[3];    // d3
    
    // parity bits
    assign encoded[0] = encoded[2] ^ encoded[4] ^ encoded[6];   // p1
    assign encoded[1] = encoded[2] ^ encoded[5] ^ encoded[6];   // p2
    assign encoded[3] = encoded[4] ^ encoded[5] ^ encoded[6];   // p3
endmodule