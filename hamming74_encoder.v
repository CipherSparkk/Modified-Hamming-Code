module hamming74_encoder (
    input [3:0] data,
    output [6:0] encoded
);
    // data bits
    assign encoded[0] = data[0];  
    assign encoded[1] = data[1];  
    assign encoded[2] = data[2];  
    assign encoded[3] = data[3];  
    // parity bit
    assign encoded[4] = data[0] ^ data[1] ^ data[3]; 
    assign encoded[5] = data[0] ^ data[2] ^ data[3];  
    assign encoded[6] = data[1] ^ data[2] ^ data[3];  
endmodule
