`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.11.2025 19:54:15
// Design Name: 
// Module Name: lab3_test
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


module lab_part3_display_test(
    input  logic        clk,
    input  logic [15:0] sw,
    output logic        a,b,c,d,e,f,g,
    output logic [3:0]  an,
    output logic [15:0] led
    );
    
    // Simply pass switches to display
    assign led = sw;  // Show switches on LEDs too
    
    lab_part2b display (
        .clk(clk),
        .sw(sw),
        .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g),
        .an(an)
    );
    
endmodule

