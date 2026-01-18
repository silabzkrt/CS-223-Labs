`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.11.2025 16:17:44
// Design Name: 
// Module Name: tb_labpart3
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
module tb_labpart3();

    logic clk;
    logic [15:0] sw;
    logic [15:0] led;
    logic a, b, c, d, e, f, g;
    logic [3:0] an;
    logic dp;

    // Internal Variables
    logic [2:0] select;
    logic reset;
    logic [11:0] val_in;

    assign sw = {select, reset, val_in};

    // Instantiate your design
    lab_part3 uut (
        .clk(clk), .sw(sw), .led(led),
        .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g),
        .an(an), .dp(dp)
    );

    // Clock Generation
    always begin
        clk = 0; #5;
        clk = 1; #5;
    end

    // The Main Test
    initial begin
        // 1. Start with Reset
        select = 0; val_in = 0; reset = 1; 
        #50;
        reset = 0;
        for (int i = 0; i < 16; i++) begin
            reset = 0; 
            select = 3'b011;       // 011 = Load Mode
            val_in = i[11:0];      // 000...0000, 000...0001, etc.
//            select = 3'b000; #10
//            select = 3'b001; #10
//            select = 3'b010; #10
//            select = 3'b011; #10
//            select = 3'b100; #10
//            select = 3'b101; #10
            
        end
    end

endmodule