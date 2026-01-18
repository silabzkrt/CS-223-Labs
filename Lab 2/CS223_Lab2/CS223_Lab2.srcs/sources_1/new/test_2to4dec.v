`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2025 08:52:52
// Design Name: 
// Module Name: test_2to4dec
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


module test_2to4dec(
    input logic [2:0] sw,
    output logic[3:0]led
    );
    dec_2to4 dec(
        .in(sw[1:0]),
        .en(sw[2]),
        .y(led[0])
    );
endmodule
