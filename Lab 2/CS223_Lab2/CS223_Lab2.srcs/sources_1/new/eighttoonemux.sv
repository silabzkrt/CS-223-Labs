`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2025 08:06:32
// Design Name: 
// Module Name: eighttoonemux
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
module eighttoonemux (
    input  logic sw[10:0] ,
    output logic led[0:0]
);
    logic w_mux0_out, w_mux1_out; 
    logic w_and0_out, w_and1_out; 
    logic w_s2_inv;              
    
    mux_4to1 mux0 (
        .D(sw[3:0]), 
        .S(sw[9:8]), 
        .Y(w_mux0_out)
    );

    mux_4to1 mux1 (
        .D(sw[7:4]), 
        .S(sw[9:8]), 
        .Y(w_mux1_out)
    );

    assign w_s2_inv = ~sw[10];
    assign w_and0_out = w_mux0_out & w_s2_inv;
    assign w_and1_out = w_mux1_out & sw[10];

    assign led[0] = w_and0_out | w_and1_out;

endmodule
