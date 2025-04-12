// Received codeword (Actual Order) : [ p1 p2 d0 p3 d1 d2 d3 ]

module hamming74_decoder(
    input [6:0] received,
    output [3:0] data_out,
    output error_flag
);
    wire [2:0] syndrome;
    // Extracting bits
    wire d0 = received[2];
    wire d1 = received[4];
    wire d2 = received[5];
    wire d3 = received[6];
    wire p1 = received[0];
    wire p2 = received[1];
    wire p3 = received[3];

    // Calculation for syndrome
    assign syndrome[0] = p1 ^ d0 ^ d1 ^ d3;
    assign syndrome[1] = p2 ^ d0 ^ d2 ^ d3; 
    assign syndrome[2] = p3 ^ d1 ^ d2 ^ d3;

    reg [6:0] corrected;

    always @(*) begin
    corrected = received;
    error_flag = (syndrome != 0);
    case (syndrome)
        3'b001: corrected[0] = ~received[0];       // p1 (Bit 1)
        3'b010: corrected[1] = ~received[1];       // p2 (Bit 2)
        3'b011: corrected[2] = ~received[2];       // d0 (Bit 3)
        3'b100: corrected[3] = ~received[3];       // p3 (Bit 4)
        3'b101: corrected[4] = ~received[4];       // d1 (Bit 5)
        3'b110: corrected[5] = ~received[5];       // d2 (Bit 6)
        3'b111: corrected[6] = ~received[6];       // d3 (Bit 7)
    endcase
    data_out = {corrected[6], corrected[5], corrected[4], corrected[2]};     // d3,d2,d1,d0
end
endmodule
