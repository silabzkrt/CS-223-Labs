`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2025 09:22:23
// Design Name: 
// Module Name: fourtoonemux
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


module fourtoonemux(
    input s0, s1, i0, i1, i2, i3,
    output y
    );
    logic y1, y2;
    twotoonemux two_one_1(
        .s(s0),
        .i0(i0),
        .i1(i1),
        .y(y1));
    twotoonemux two_one_2(
        .s(s0),
        .i0(i2),
        .i1(i3),
        .y(y2));
    twotoonemux two_one_3(
        .s(s1),
        .i0(y1),
        .i1(y2),
        .y(y));
endmodule
