`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.10.2025 07:58:53
// Design Name: 
// Module Name: half_subtractor
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


module half_subtractor (
    input  logic sw[1:0],
    output logic D,      // difference
    output logic Bout,   // borrow out
    output logic led[1:0]
);
    assign D    = sw[0] ^ sw[1]; 
    assign led[0] = D;    
    assign Bout = (~sw[0]) & sw[1];
    assign led[1] = Bout;    
endmodule