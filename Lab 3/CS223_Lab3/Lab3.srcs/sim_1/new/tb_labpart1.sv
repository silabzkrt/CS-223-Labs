`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2025 08:56:09
// Design Name: 
// Module Name: tb_labpart1
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

module tb_lab_part1();

    logic clk;
    logic [15:0] sw;  
    logic [15:0] led;   
    logic [2:0] select;
    logic reset;
    logic [7:0] data_in;
    logic shift_in;
    assign sw = {select, reset, 3'b000, shift_in, data_in};

    lab_part1 uut (
        .clk(clk),
        .sw(sw),
        .led(led)
    );

    always begin
        clk = 0; #5;
        clk = 1; #5;
    end

    initial begin
        reset = 1; select = 3'b000; data_in = 8'h00; shift_in = 0;
        #50; 
        reset = 0;
        #20;

        select = 3'b011;      
        data_in = 8'b10101010; 
        #100;                 

        select = 3'b001;      
        shift_in = 1;         
        #100;

        select = 3'b010;      
        shift_in = 0;         
        #100;

        select = 3'b000;      
        #100;

        $finish;
    end

endmodule
