module hamming74_encoder(
    input [3:0] data_in,
    output [6:0] code_out
);
    wire p1, p2, p3;

    assign p1 = data_in[0] ^ data_in[1] ^ data_in[3];
    assign p2 = data_in[0] ^ data_in[2] ^ data_in[3];
    assign p3 = data_in[1] ^ data_in[2] ^ data_in[3];

    assign code_out = {p1, p2, data_in[0], p3, data_in[1], data_in[2], data_in[3]};
endmodule
