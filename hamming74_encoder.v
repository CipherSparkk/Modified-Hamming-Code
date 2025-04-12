// Standard Hamming (7,4) positions:
// Bit positions:  7  6  5  4  3  2  1
//                d3 d2 d1 p3 d0 p2 p1
module hamming74_encoder(
    input  [3:0] data,        // data bits
    output [6:0] encoded      // [p1 p2 d0 p3 d1 d2 d3]
);
    wire p1, p2, p3;
    assign p1 = data[0] ^ data[1] ^ data[3]; // parity for bits 3,5,7
    assign p2 = data[0] ^ data[2] ^ data[3]; // parity for bits 3,6,7
    assign p3 = data[1] ^ data[2] ^ data[3]; // parity for bits 5,6,7

    assign encoded = {
        data[3],      // bit 7
        data[2],      // bit 6
        data[1],      // bit 5
        p3,           // bit 4
        data[0],      // bit 3
        p2,           // bit 2
        p1            // bit 1
    };
endmodule
