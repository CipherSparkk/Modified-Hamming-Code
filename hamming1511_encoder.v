module hamming1511_encoder (
    input [10:0] data,
    output [14:0] encoded
);
  // Data bits
  assign encoded[10:0] = data;

  // Parity bits
  assign encoded[11] = data[0] ^ data[1] ^ data[2] ^ data[4] ^ data[5] ^ data[7] ^ data[9];
  assign encoded[12] = data[0] ^ data[1] ^ data[3] ^ data[4] ^ data[6] ^ data[7] ^ data[10];
  assign encoded[13] = data[0] ^ data[2] ^ data[3] ^ data[5] ^ data[6] ^ data[8] ^ data[10];
  // Global parity
  assign encoded[14] = ^data; 
endmodule
