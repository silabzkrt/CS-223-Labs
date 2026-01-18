`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.11.2025 19:56:11
// Design Name: 
// Module Name: lab3_testnoDisplay
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



//////////////////////////////////////////////////////////////////////////////////
// REGISTER TEST MODULE - Test just the registers without display
//////////////////////////////////////////////////////////////////////////////////

module lab_part3_register_test(
    input  logic        clk,
    input  logic [15:0] sw,
    output logic [15:0] led
    );
    
    logic [2:0]  select;
    logic        reset;
    logic [11:0] load_val;
    
    assign select   = sw[15:13];
    assign reset    = sw[12];
    assign load_val = sw[11:0];
    
    // Slow clock
    logic [26:0] clk_counter;
    logic slow_clk;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            clk_counter <= 27'b0;
        else
            clk_counter <= clk_counter + 1;
    end
    
    assign slow_clk = clk_counter[25];
    
    logic [15:0] Q_total;
    logic shift_in_lower, shift_in_upper;
    
    always_comb begin
        case (select)
            3'b001: begin
                shift_in_lower = 1'b0;
                shift_in_upper = Q_total[7];
            end
            3'b010: begin
                shift_in_lower = Q_total[8];
                shift_in_upper = 1'b0;
            end
            default: begin
                shift_in_lower = 1'b0;
                shift_in_upper = 1'b0;
            end
        endcase
    end
    
    multifunction_register reg_L (
        .clk(slow_clk),
        .reset(reset),
        .select(select),
        .D(load_val[7:0]),
        .shift_in(shift_in_lower),
        .Q(Q_total[7:0])
    );
    
    multifunction_register reg_H (
        .clk(slow_clk),
        .reset(reset),
        .select(select),
        .D({4'b0000, load_val[11:8]}),
        .shift_in(shift_in_upper),
        .Q(Q_total[15:8])
    );
    
    // Show everything on LEDs
    assign led = Q_total;
    
endmodule
