`timescale 1ns/1ps

module tb_hamming_2d_interleaved;

    reg [43:0] data_in;
    wire [104:0] encoded_out;  // 105-bit encoded output
    reg [104:0] received;      // 105-bit received data
    wire [43:0] decoded_out;
    wire error_detected;
    
    // Instantiate the interleaved system
    hamming_2d_interleaved dut (
        .data_in(data_in),
        .encoded_out(encoded_out),
        .received_in(received),
        .decoded_out(decoded_out),
        .error_detected(error_detected)
    );
    
    // Helper task to inject errors
        task inject_error;
        input integer bit_position;
        begin
            if (bit_position < 0 || bit_position > 104) begin
                $display("Error: Bit position %0d out of range (0-104)", bit_position);
                $finish;
            end
            received = encoded_out;
            received[bit_position] = ~received[bit_position];
            $display("Injected error at bit position %0d", bit_position);
        end
    endtask
    
    // Helper task to display test results
    task display_results;
        input [43:0] expected;
        begin
            $display("----------------------------------------");
            $display("Input data:         %h", data_in);
            $display("Encoded data:       %h", encoded_out);
            $display("Received data:      %h", received);
            $display("Decoded data:       %h", decoded_out);
            $display("Expected data:      %h", expected);
            $display("Error detected:     %b", error_detected);
            $display("Correction status:  %s", (decoded_out == expected) ? "PASS" : "FAIL");
            $display("----------------------------------------\n");
        end
    endtask
    
    initial begin
        // Test case 1: No errors
        data_in = 44'hA5A5A5A5A;
        #10;
        received = encoded_out; // No errors
        #10;
        display_results(data_in);
        
        // Test case 2: Single-bit error
        data_in = 44'h123456789;
        #10;
        inject_error(15);
        #10;
        inject_error(30);  
        #10;
        display_results(data_in);
        
        // Test case 3: Double-bit error in different rows
        data_in = 44'hFEDCBA987;
        #10;
        inject_error(5);  // First error
        inject_error(20); // Second error in a different position
        #10;
        display_results(data_in);
        
        // Test case 4: Burst error (adjacent bits)
        data_in = 44'h55AA55AA5;
        #10;
        inject_error(30); // First bit in burst
        inject_error(31); // Second bit in burst
        #10;
        display_results(data_in);
        
        $finish;
    end

endmodule