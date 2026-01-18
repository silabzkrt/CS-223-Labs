`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.12.2025 09:09:52
// Design Name: 
// Module Name: Debouncer
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


module Debouncer(
    input logic clk,
    input logic btn_in,
    output logic btn_out,
    output logic pulse_out 
    );
    logic [19:0] counter;
    logic state;
    logic state_prev;
    assign btn_out = state;
    assign pulse_out = (state && !state_prev);

    always_ff @(posedge clk) begin
        if (btn_in != state) begin
            counter <= counter + 1;
            // Use 20'hFFFFF for Board, 20'h00005 for Sim
            if (counter >= 20'hFFFFF) begin 
                state <= btn_in;
                counter <= 0;
            end
        end else begin
            counter <= 0;
        end
        state_prev <= state;
    end
endmodule
