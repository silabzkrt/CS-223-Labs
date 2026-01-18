`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.10.2025 08:10:02
// Design Name: 
// Module Name: full_adder_swnled
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


module full_adder_swnled(
input logic sw[1:0],
output logic led[1:0]
    );
    logic cin = 1'b0;
    assign led[0] = sw[0] ^ sw[1] ^ cin;
    assign led[1] = (sw[0] & sw[1]) | (cin & (sw[0] ^ sw[1]));
endmodule
