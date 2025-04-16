module deinterleaver_44bit(
    input [43:0] interleaved_data,
    output reg [43:0] deinterleaved_data
);

    always @(*) begin
        deinterleaved_data[0]  = interleaved_data[0];   // Row 0
        deinterleaved_data[1]  = interleaved_data[4];
        deinterleaved_data[2]  = interleaved_data[8];
        deinterleaved_data[3]  = interleaved_data[12];
        deinterleaved_data[4]  = interleaved_data[16];
        deinterleaved_data[5]  = interleaved_data[20];
        deinterleaved_data[6]  = interleaved_data[24];
        deinterleaved_data[7]  = interleaved_data[28];
        deinterleaved_data[8]  = interleaved_data[32];
        deinterleaved_data[9]  = interleaved_data[36];
        deinterleaved_data[10] = interleaved_data[40];

        deinterleaved_data[11] = interleaved_data[1];   // Row 1
        deinterleaved_data[12] = interleaved_data[5];
        deinterleaved_data[13] = interleaved_data[9];
        deinterleaved_data[14] = interleaved_data[13];
        deinterleaved_data[15] = interleaved_data[17];
        deinterleaved_data[16] = interleaved_data[21];
        deinterleaved_data[17] = interleaved_data[25];
        deinterleaved_data[18] = interleaved_data[29];
        deinterleaved_data[19] = interleaved_data[33];
        deinterleaved_data[20] = interleaved_data[37];
        deinterleaved_data[21] = interleaved_data[41];

        deinterleaved_data[22] = interleaved_data[2];   // Row 2
        deinterleaved_data[23] = interleaved_data[6];
        deinterleaved_data[24] = interleaved_data[10];
        deinterleaved_data[25] = interleaved_data[14];
        deinterleaved_data[26] = interleaved_data[18];
        deinterleaved_data[27] = interleaved_data[22];
        deinterleaved_data[28] = interleaved_data[26];
        deinterleaved_data[29] = interleaved_data[30];
        deinterleaved_data[30] = interleaved_data[34];
        deinterleaved_data[31] = interleaved_data[38];
        deinterleaved_data[32] = interleaved_data[42];

        deinterleaved_data[33] = interleaved_data[3];   // Row 3
        deinterleaved_data[34] = interleaved_data[7];
        deinterleaved_data[35] = interleaved_data[11];
        deinterleaved_data[36] = interleaved_data[15];
        deinterleaved_data[37] = interleaved_data[19];
        deinterleaved_data[38] = interleaved_data[23];
        deinterleaved_data[39] = interleaved_data[27];
        deinterleaved_data[40] = interleaved_data[31];
        deinterleaved_data[41] = interleaved_data[35];
        deinterleaved_data[42] = interleaved_data[39];
        deinterleaved_data[43] = interleaved_data[43];
    end

endmodule
