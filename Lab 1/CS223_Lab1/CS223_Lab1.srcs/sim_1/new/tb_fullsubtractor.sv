`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2025 11:48:27
// Design Name: 
// Module Name: tb_fullsubtractor
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


module tb_full_subtractor;

    logic [1:0] sw;
    logic [1:0] led;

    // Instantiate DUT (Device Under Test)
    full_subtractor uut (
        .sw(sw),
        .led(led)
    );

    initial begin
        $display("Time | A B | Diff Borrow");
        $monitor("%4t | %b %b |   %b     %b", $time, sw[0], sw[1], led[0], led[1]);

        // Apply all input combinations
        sw = 2'b00; #10;
        sw = 2'b01; #10;
        sw = 2'b10; #10;
        sw = 2'b11; #10;

        $finish;
    end
endmodule