`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2025 11:00:45
// Design Name: 
// Module Name: half_subtracter
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


module half_subtracter(
    input a, b,
    output diff, borrow
    );
    assign diff = a ^ b;
    assign borrow = (~a) & b;
endmodule
