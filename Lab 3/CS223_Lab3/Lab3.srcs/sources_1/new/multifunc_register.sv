`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.11.2025 16:51:07
// Design Name: 
// Module Name: multifunction_register
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


module multifunction_register(
    input logic clk,
    input logic reset,
    input logic [2:0] select, 
    input logic [7:0] D,      // for parallel input
    input logic shift_in,     
    output logic [7:0] Q
    );
    
    logic [7:0] next_state;
    
    mux8to1 mux_0 (
        .sel(select),
        .i0(Q[0]),
        .i1(shift_in),
        .i2(Q[1]),
        .i3(D[0]),
        .i4(Q[7]),
        .i5(Q[1]),
        .i6(1'b0),
        .i7(1'b0),
        .y(next_state[0])
    );

    mux8to1 mux_1 (
        .sel(select),
        .i0(Q[1]),
        .i1(Q[0]),
        .i2(Q[2]),
        .i3(D[1]),
        .i4(Q[0]),
        .i5(Q[2]),
        .i6(1'b0),
        .i7(1'b0),
        .y(next_state[1])
    );

    mux8to1 mux_2 (
        .sel(select),
        .i0(Q[2]),
        .i1(Q[1]),
        .i2(Q[3]),
        .i3(D[2]),
        .i4(Q[1]),
        .i5(Q[3]),
        .i6(1'b0),
        .i7(1'b0),
        .y(next_state[2])
    );

    mux8to1 mux_3 (
        .sel(select),
        .i0(Q[3]),
        .i1(Q[2]),
        .i2(Q[4]),
        .i3(D[3]),
        .i4(Q[2]),
        .i5(Q[4]),
        .i6(1'b0),
        .i7(1'b0),
        .y(next_state[3])
    );

    mux8to1 mux_4 (
        .sel(select),
        .i0(Q[4]),
        .i1(Q[3]),
        .i2(Q[5]),
        .i3(D[4]),
        .i4(Q[3]),
        .i5(Q[5]),
        .i6(1'b0),
        .i7(1'b0),
        .y(next_state[4])
    );

    mux8to1 mux_5 (
        .sel(select),
        .i0(Q[5]),
        .i1(Q[4]),
        .i2(Q[6]),
        .i3(D[5]),
        .i4(Q[4]),
        .i5(Q[6]),
        .i6(1'b0),
        .i7(1'b0),
        .y(next_state[5])
    );

    mux8to1 mux_6 (
        .sel(select),
        .i0(Q[6]),
        .i1(Q[5]),
        .i2(Q[7]),
        .i3(D[6]),
        .i4(Q[5]),
        .i5(Q[7]),
        .i6(1'b0),
        .i7(1'b0),
        .y(next_state[6])
    );

    mux8to1 mux_7 (
        .sel(select),
        .i0(Q[7]),
        .i1(Q[6]),
        .i2(shift_in),
        .i3(D[7]),
        .i4(Q[6]),
        .i5(Q[0]),
        .i6(1'b0),
        .i7(1'b0),
        .y(next_state[7])
    );
    
    d_flip_flop ff_0 (.clk(clk), .reset(reset), .d(next_state[0]), .q(Q[0]));
    d_flip_flop ff_1 (.clk(clk), .reset(reset), .d(next_state[1]), .q(Q[1]));
    d_flip_flop ff_2 (.clk(clk), .reset(reset), .d(next_state[2]), .q(Q[2]));
    d_flip_flop ff_3 (.clk(clk), .reset(reset), .d(next_state[3]), .q(Q[3]));
    d_flip_flop ff_4 (.clk(clk), .reset(reset), .d(next_state[4]), .q(Q[4]));
    d_flip_flop ff_5 (.clk(clk), .reset(reset), .d(next_state[5]), .q(Q[5]));
    d_flip_flop ff_6 (.clk(clk), .reset(reset), .d(next_state[6]), .q(Q[6]));
    d_flip_flop ff_7 (.clk(clk), .reset(reset), .d(next_state[7]), .q(Q[7]));
endmodule
