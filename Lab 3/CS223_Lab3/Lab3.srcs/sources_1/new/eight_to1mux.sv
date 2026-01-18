`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.11.2025 16:41:30
// Design Name: 
// Module Name: eight_to1mux
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

module mux8to1 (
    input  logic [2:0] sel,
    input  logic i0, i1, i2, i3, i4, i5, i6, i7,
    output logic y
);
    always_comb begin
        case (sel)
            3'b000: y = i0;
            3'b001: y = i1;
            3'b010: y = i2;
            3'b011: y = i3;
            3'b100: y = i4;
            3'b101: y = i5;
            3'b110: y = i6;
            3'b111: y = i7;
            default: y = 1'b0;
        endcase
    end
endmodule