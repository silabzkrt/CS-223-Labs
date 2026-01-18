`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2025 08:01:24
// Design Name: 
// Module Name: function_g
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

module function_g (
    input  logic sw [2:0],
    output logic led[0:0]
);

    logic i0, i1;

    assign i0 = sw[2];
    
    assign i1 = sw[0] | (~sw[2]);

    mux_2to1 dut_mux (
        .i0(i0),
        .i1(i1),
        .sel(sw[1]),
        .y(led[0])
    );

endmodule