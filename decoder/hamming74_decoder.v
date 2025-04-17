module hamming74_decoder(
    input [6:0] received,
    output reg [3:0] data_out,
    output reg error_flag
);
    wire [2:0] syndrome;
    
    // Calculate syndrome bits
    assign syndrome[0] = received[0] ^ received[2] ^ received[4] ^ received[6];
    assign syndrome[1] = received[1] ^ received[2] ^ received[5] ^ received[6];
    assign syndrome[2] = received[3] ^ received[4] ^ received[5] ^ received[6];

    always @(*) begin
        // Default data extraction - this is the base case where no errors are present
        data_out = {received[6], received[5], received[4], received[2]};
        error_flag = (syndrome != 0);
        
        if (syndrome != 0) begin
            // Error correction based on syndrome
            case (syndrome)
                3'b001: begin /* Parity bit p1 error - no data correction needed */ end
                3'b010: begin /* Parity bit p2 error - no data correction needed */ end
                3'b011: data_out[0] = ~data_out[0];          // d0 error
                3'b100: begin /* Parity bit p3 error - no data correction needed */ end
                3'b101: data_out[1] = ~data_out[1];          // d1 error
                3'b110: data_out[2] = ~data_out[2];          // d2 error
                3'b111: data_out[3] = ~data_out[3];          // d3 error
                default: ;                                   // Should not reach here
            endcase
        end
    end
endmodule