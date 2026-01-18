`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2025 11:12:10
// Design Name: 
// Module Name: full_subtractor
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

// 1-bit fullsubtractor
module full_subtractor( // using half subtractors
    input  logic [1:0] sw,       // sw[0]=a, sw[1]=b
    output logic [1:0] led       // led[0]=diff, led[1]=borrow
);
    // internal signals
    logic d1, b1, b2;
    logic bin;                   // borrow-in 

    assign bin = 1'b0; //it's 1 bit and it's always 0 since we only subtract 2 bits    

    // First half subtractor: a - b
    half_subtracter hs1 (
        .a(sw[0]), .b(sw[1]),
        .diff(d1), .borrow(b1)
    );

    // Second half subtractor: (a - b) - bin(0)
    half_subtracter hs2 (
        .a(d1), .b(bin),
        .diff(led[0]), .borrow(b2)
    ); // we find the final diff here and assign it to led[0]

    // Final borrow-out
    assign led[1] = b1 | b2; // here we assign bout final to led[1]   
endmodule
