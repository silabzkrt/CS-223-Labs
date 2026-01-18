`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Bilkent Universty
// Engineer: Sıla Bozkurt
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
    input  logic clk,
    input  logic reset,
    input  logic [2:0] select,
    input  logic [7:0] D,      // Parallel Load Data
    input  logic shift_in,     // Serial Input
    output logic [7:0] Q       // Register Output
    );

    logic [7:0] next_state;

    // --- Bit 0 ---
    // i0=Q[0], i1=shift_in (Right->Left), i2=Q[1] (Left->Right), i3=D[0] (Load)
    // i4=Q[7] (RotL), i5=Q[1] (RotR)
    mux8to1 m0 (.sel(select), .i0(Q[0]), .i1(shift_in), .i2(Q[1]), .i3(D[0]), .i4(Q[7]), .i5(Q[1]), .i6(1'b0), .i7(1'b0), .y(next_state[0]));
    d_flip_flop f0 (.clk(clk), .reset(reset), .d(next_state[0]), .q(Q[0]));

    // --- Bit 1 ---
    mux8to1 m1 (.sel(select), .i0(Q[1]), .i1(Q[0]), .i2(Q[2]), .i3(D[1]), .i4(Q[0]), .i5(Q[2]), .i6(1'b0), .i7(1'b0), .y(next_state[1]));
    d_flip_flop f1 (.clk(clk), .reset(reset), .d(next_state[1]), .q(Q[1]));

    // --- Bit 2 ---
    mux8to1 m2 (.sel(select), .i0(Q[2]), .i1(Q[1]), .i2(Q[3]), .i3(D[2]), .i4(Q[1]), .i5(Q[3]), .i6(1'b0), .i7(1'b0), .y(next_state[2]));
    d_flip_flop f2 (.clk(clk), .reset(reset), .d(next_state[2]), .q(Q[2]));

    // --- Bit 3 ---
    mux8to1 m3 (.sel(select), .i0(Q[3]), .i1(Q[2]), .i2(Q[4]), .i3(D[3]), .i4(Q[2]), .i5(Q[4]), .i6(1'b0), .i7(1'b0), .y(next_state[3]));
    d_flip_flop f3 (.clk(clk), .reset(reset), .d(next_state[3]), .q(Q[3]));

    // --- Bit 4 ---
    mux8to1 m4 (.sel(select), .i0(Q[4]), .i1(Q[3]), .i2(Q[5]), .i3(D[4]), .i4(Q[3]), .i5(Q[5]), .i6(1'b0), .i7(1'b0), .y(next_state[4]));
    d_flip_flop f4 (.clk(clk), .reset(reset), .d(next_state[4]), .q(Q[4]));

    // --- Bit 5 ---
    mux8to1 m5 (.sel(select), .i0(Q[5]), .i1(Q[4]), .i2(Q[6]), .i3(D[5]), .i4(Q[4]), .i5(Q[6]), .i6(1'b0), .i7(1'b0), .y(next_state[5]));
    d_flip_flop f5 (.clk(clk), .reset(reset), .d(next_state[5]), .q(Q[5]));

    // --- Bit 6 ---
    mux8to1 m6 (.sel(select), .i0(Q[6]), .i1(Q[5]), .i2(Q[7]), .i3(D[6]), .i4(Q[5]), .i5(Q[7]), .i6(1'b0), .i7(1'b0), .y(next_state[6]));
    d_flip_flop f6 (.clk(clk), .reset(reset), .d(next_state[6]), .q(Q[6]));

    // --- Bit 7 ---
    // i1=Q[6] (Shift Left), i2=shift_in (Shift Right)
    // i4=Q[6] (RotL), i5=Q[0] (RotR)
    mux8to1 m7 (.sel(select), .i0(Q[7]), .i1(Q[6]), .i2(shift_in), .i3(D[7]), .i4(Q[6]), .i5(Q[0]), .i6(1'b0), .i7(1'b0), .y(next_state[7]));
    d_flip_flop f7 (.clk(clk), .reset(reset), .d(next_state[7]), .q(Q[7]));

endmodule