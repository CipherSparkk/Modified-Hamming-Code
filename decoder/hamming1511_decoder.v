module hamming1511_decoder (
    input [14:0] received,
    output reg [10:0] data_out,
    output reg error_detected
);
    // Syndrome calculation
    wire s0 = received[0] ^ received[2] ^ received[4] ^ received[6] ^ received[8] ^ received[10] ^ received[12] ^ received[14];
    wire s1 = received[1] ^ received[2] ^ received[5] ^ received[6] ^ received[9] ^ received[10] ^ received[13] ^ received[14];
    wire s2 = received[3] ^ received[4] ^ received[5] ^ received[6] ^ received[11] ^ received[12] ^ received[13] ^ received[14];
    wire s3 = received[7] ^ received[8] ^ received[9] ^ received[10] ^ received[11] ^ received[12] ^ received[13] ^ received[14];
    
    wire [3:0] syndrome = {s3,s2,s1,s0};

    always @(*) begin
        // Default output - extract data bits from received codeword
        data_out = {
            received[14], // d10
            received[13], // d9
            received[12], // d8
            received[11], // d7
            received[10], // d6
            received[9],  // d5
            received[8],  // d4
            received[6],  // d3
            received[5],  // d2
            received[4],  // d1
            received[2]   // d0
        };
        
        error_detected = (syndrome != 0);

        if (syndrome != 0) begin
            // Error correction based on syndrome
            case(syndrome)
                4'b0001: begin /* p0 error - no data correction needed */ end
                4'b0010: begin /* p1 error - no data correction needed */ end
                4'b0011: data_out[0]  = ~data_out[0];  // d0 error
                4'b0100: begin /* p2 error - no data correction needed */ end
                4'b0101: data_out[1]  = ~data_out[1];  // d1 error
                4'b0110: data_out[2]  = ~data_out[2];  // d2 error
                4'b0111: data_out[3]  = ~data_out[3];  // d3 error
                4'b1000: begin /* p3 error - no data correction needed */ end
                4'b1001: data_out[4]  = ~data_out[4];  // d4 error
                4'b1010: data_out[5]  = ~data_out[5];  // d5 error
                4'b1011: data_out[6]  = ~data_out[6];  // d6 error
                4'b1100: data_out[7]  = ~data_out[7];  // d7 error
                4'b1101: data_out[8]  = ~data_out[8];  // d8 error
                4'b1110: data_out[9]  = ~data_out[9];  // d9 error
                4'b1111: data_out[10] = ~data_out[10]; // d10 error
                default: ; // Should not reach here
            endcase
        end
    end
endmodule