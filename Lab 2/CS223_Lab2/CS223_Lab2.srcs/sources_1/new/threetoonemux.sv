`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Bilkent Universty
// Engineer: Sıla Bozkurt
// 
// Create Date: 28.10.2025 09:18:36
// Design Name: 3x1 Multiplexer
// Module Name: threetoonemux
// Project Name: Cs 223 Lab2
// Target Devices: Bassys3
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


module threetoonemux(
    input i0,i1,i2,s0,s1,
    output y
    );
    assign y = (i0&~s0&~s1)|(i1&~s0&s1)|(i2&s0&~s1);
endmodule