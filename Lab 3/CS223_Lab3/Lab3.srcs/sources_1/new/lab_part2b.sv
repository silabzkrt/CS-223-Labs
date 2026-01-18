`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Bilkent Universty
// Engineer: Sıla Bozkurt
// 
// Create Date: 25.11.2025 11:56:30
// Design Name: 
// Module Name: lab_part2b
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module lab_part2b(
    input  logic        clk,     // 100MHz System Clock
    input  logic [15:0] sw,      // 16-bit Value to Display
    output logic        a,b,c,d,e,f,g, 
    output logic [3:0]  an
    );

    // 1. Clock Divider for Refresh Rate (~1kHz)
    // 100MHz / 100,000 = 1kHz
    logic [16:0] scan_counter;
    logic        scan_clk;

    always_ff @(posedge clk) begin
        if (scan_counter >= 49_999) begin
            scan_counter <= 0;
            scan_clk <= ~scan_clk;
        end else begin
            scan_counter <= scan_counter + 1;
        end
    end

    // 2. Multiplexing Logic
    logic [1:0] digit_sel;
    always_ff @(posedge scan_clk) begin
        digit_sel <= digit_sel + 1;
    end

    logic [3:0] current_hex;
    
    always_comb begin
        case(digit_sel)
            2'b00: begin
                an = 4'b1110;           // Rightmost
                current_hex = sw[3:0];
            end
            2'b01: begin
                an = 4'b1101;
                current_hex = sw[7:4];
            end
            2'b10: begin
                an = 4'b1011;
                current_hex = sw[11:8];
            end
            2'b11: begin
                an = 4'b0111;           // Leftmost
                current_hex = sw[15:12];
            end
            default: begin
                an = 4'b1111;
                current_hex = 4'b0000;
            end
        endcase
    end

    // 3. Decoder Instance
    hexadecimal_7segment decoder (
        .sw(current_hex),
        .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g)
    );

endmodule