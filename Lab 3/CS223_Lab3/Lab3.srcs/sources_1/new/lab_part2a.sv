`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Bilkent Universty
// Engineer: Sıla Bozkurt
// 
// Create Date: 25.11.2025 11:58:19
// Design Name: 
// Module Name: lab_part2a
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


module lab_part2a(
    input  logic [3:0] sw,       // The 4 switches for input
    output logic a,b,c,d,e,f,g,  // The 7 segment LEDs
    output logic [3:0] an       
    );

    hexadecimal_7segment my_decoder (
        .sw(sw),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e),
        .f(f),
        .g(g)
    );

    assign an = 4'b1110; 

endmodule