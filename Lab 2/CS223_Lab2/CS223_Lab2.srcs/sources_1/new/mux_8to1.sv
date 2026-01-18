`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2025 08:58:19
// Design Name: 
// Module Name: mux_8to1
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


module mux_8to1(
    input  logic [7:0] in,
    input logic [2:0] sel,
    output logic y
 
);
    logic w_mux0_out, w_mux1_out;           
    
    mux_4to1 mux0 (
        .D(in[3:0]), 
        .S(sel[1:0]), 
        .Y(w_mux0_out)
    );

    mux_4to1 mux1 (
        .D(in [7:4]), 
        .S(sel[1:0]), 
        .Y(w_mux1_out)
    );

    assign y = (w_mux0_out & ~sel[2]) | (w_mux1_out & sel[2]);

endmodule