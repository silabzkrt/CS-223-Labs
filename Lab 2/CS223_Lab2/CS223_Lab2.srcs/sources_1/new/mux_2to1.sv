`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2025 08:38:06
// Design Name: 
// Module Name: mux_2to1
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


module mux_2to1 (
    input  logic i0,  // Input when sel=0
    input  logic i1,  // Input when sel=1
    input  logic sel, // Select line
    output logic y    // Output
);

    assign y = (~sel & i0) | (sel & i1);

endmodule
