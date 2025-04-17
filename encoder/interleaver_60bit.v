module interleaver_60bit(
    input [59:0] data_in,  // Original: 4 rows × 15 bits (row-major order)
    output [59:0] data_out  // Interleaved: 15 cols × 4 bits (col-major order)
);
    // Transpose 4×15 matrix into 15×4 matrix
    // Each row in data_in is 15 bits:
    // Row 0: data_in[14:0]
    // Row 1: data_in[29:15]
    // Row 2: data_in[44:30]
    // Row 3: data_in[59:45]
    
    // Fixed bit selections - ensure each bit is correctly mapped
    assign data_out[3:0]   = {data_in[45], data_in[30], data_in[15], data_in[0]};  // Column 0 (LSB of each row)
    assign data_out[7:4]   = {data_in[46], data_in[31], data_in[16], data_in[1]};  // Column 1
    assign data_out[11:8]  = {data_in[47], data_in[32], data_in[17], data_in[2]};  // Column 2
    assign data_out[15:12] = {data_in[48], data_in[33], data_in[18], data_in[3]};  // Column 3
    assign data_out[19:16] = {data_in[49], data_in[34], data_in[19], data_in[4]};  // Column 4
    assign data_out[23:20] = {data_in[50], data_in[35], data_in[20], data_in[5]};  // Column 5
    assign data_out[27:24] = {data_in[51], data_in[36], data_in[21], data_in[6]};  // Column 6
    assign data_out[31:28] = {data_in[52], data_in[37], data_in[22], data_in[7]};  // Column 7
    assign data_out[35:32] = {data_in[53], data_in[38], data_in[23], data_in[8]};  // Column 8
    assign data_out[39:36] = {data_in[54], data_in[39], data_in[24], data_in[9]};  // Column 9
    assign data_out[43:40] = {data_in[55], data_in[40], data_in[25], data_in[10]}; // Column 10
    assign data_out[47:44] = {data_in[56], data_in[41], data_in[26], data_in[11]}; // Column 11
    assign data_out[51:48] = {data_in[57], data_in[42], data_in[27], data_in[12]}; // Column 12
    assign data_out[55:52] = {data_in[58], data_in[43], data_in[28], data_in[13]}; // Column 13
    assign data_out[59:56] = {data_in[59], data_in[44], data_in[29], data_in[14]}; // Column 14 (MSB of each row)
endmodule