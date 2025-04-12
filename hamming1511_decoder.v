module hamming1511_decoder (
    input  [14:0] encoded,       // [p1 p2 d0 p3 d1 d2 d3 p4 d4 d5 d6 d7 d8 d9 d10]
    output reg [10:0] data_out,  // [d10 d9 d8 d7 d6 d5 d4 d3 d2 d1 d0]
    output reg error_detected
);
    wire [3:0] syndrome;
    // Syndrome calculation
    assign syndrome[0] = encoded[0] ^ encoded[2] ^ encoded[4] ^ encoded[6] ^ encoded[8] ^ encoded[10] ^ encoded[12] ^ encoded[14];
    assign syndrome[1] = encoded[1] ^ encoded[2] ^ encoded[5] ^ encoded[6] ^ encoded[9] ^ encoded[10] ^ encoded[13] ^ encoded[14];
    assign syndrome[2] = encoded[3] ^ encoded[4] ^ encoded[5] ^ encoded[6] ^ encoded[11] ^ encoded[12] ^ encoded[13] ^ encoded[14];
    assign syndrome[3] = encoded[7] ^ encoded[8] ^ encoded[9] ^ encoded[10] ^ encoded[11] ^ encoded[12] ^ encoded[13] ^ encoded[14];

    always @(*) begin
        // Default assignments
        data_out = {
            encoded[14],
            encoded[13],
            encoded[12], 
            encoded[11], 
            encoded[10], 
            encoded[9],  
            encoded[8],  
            encoded[6],  
            encoded[5], 
            encoded[4],  
            encoded[2]   
        };
        error_detected = (syndrome != 0);

        // Correct bit error (if any)
        case (syndrome)
            4'b0000: error_detected = 1'b0; // No error
            4'b0001: error_detected = 1'b1; // p1 error (encoded[0])
            4'b0010: error_detected = 1'b1; // p2 error (encoded[1])
            4'b0011: begin                  // d0 error (encoded[2])
                data_out[0] = ~data_out[0];
                error_detected = 1'b1;
            end
            4'b0100: error_detected = 1'b1; // p3 error (encoded[3])
            4'b0101: begin                  // d1 error (encoded[4])
                data_out[1] = ~data_out[1];
                error_detected = 1'b1;
            end
            4'b0110: begin                  // d2 error (encoded[5])
                data_out[2] = ~data_out[2];
                error_detected = 1'b1;
            end
            4'b0111: begin                  // d3 error (encoded[6])
                data_out[3] = ~data_out[3];
                error_detected = 1'b1;
            end
            4'b1000: error_detected = 1'b1; // p4 error (encoded[7])
            4'b1001: begin                  // d4 error (encoded[8])
                data_out[4] = ~data_out[4];
                error_detected = 1'b1;
            end
            4'b1010: begin                  // d5 error (encoded[9])
                data_out[5] = ~data_out[5];
                error_detected = 1'b1;
            end
            4'b1011: begin                  // d6 error (encoded[10])
                data_out[6] = ~data_out[6];
                error_detected = 1'b1;
            end
            4'b1100: begin                  // d7 error (encoded[11])
                data_out[7] = ~data_out[7];
                error_detected = 1'b1;
            end
            4'b1101: begin                  // d8 error (encoded[12])
                data_out[8] = ~data_out[8];
                error_detected = 1'b1;
            end
            4'b1110: begin                  // d9 error (encoded[13])
                data_out[9] = ~data_out[9];
                error_detected = 1'b1;
            end
            4'b1111: begin                  // d10 error (encoded[14])
                data_out[10] = ~data_out[10];
                error_detected = 1'b1;
            end
            default: error_detected = 1'b0; // Unreachable if syndrome is 4-bit
        endcase
    end
endmodule
