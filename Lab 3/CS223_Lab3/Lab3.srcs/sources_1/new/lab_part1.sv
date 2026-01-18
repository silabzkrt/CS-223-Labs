`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Bilkent Universty
// Engineer: Sıla Bozkurt
// 
// Create Date: 25.11.2025 11:56:30
// Design Name: 
// Module Name: lab_part1
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


module lab_part1( //top module
    input logic clk,           
    input logic [15:0] sw,     
    output logic [15:0] led    
    );

    // Per Lab Manual Part 3 suggestions:
    // SW[15:13] -> Select Lines
    // SW[12]    -> Reset
    // SW[7:0]   -> Data Inputs (D)
    // SW[8]     -> Shift In 
    
    logic [2:0] select_wire;
    logic reset_wire;
    logic [7:0] D_wire;
    logic shift_in_wire;
    logic [7:0] Q_wire;
    logic slow_clk;

    assign select_wire   = sw[15:13]; // Switches 15, 14, 13
    assign reset_wire    = sw[12];    // Switch 12
    assign shift_in_wire = sw[8];     // Switch 8
    assign D_wire        = sw[7:0];   // Switches 7 down to 0
    
    // Connect output Q to the rightmost LEDs
    assign led[7:0] = Q_wire;
    
    assign led[15:8] = 8'b00000000;


    // The Basys3 clock is 100 MHz, in order  to slow it down:
    clock_divider clk_div_inst (
        .clk_in(clk),
        .reset(sw[12]),
        .clk_out(slow_clk)
    );


    multifunction_register my_reg_inst (
        .clk(slow_clk),         
        .reset(sw[12]),
        .select(select_wire),
        .D(D_wire),
        .shift_in(shift_in_wire),
        .Q(Q_wire)
    );

endmodule
