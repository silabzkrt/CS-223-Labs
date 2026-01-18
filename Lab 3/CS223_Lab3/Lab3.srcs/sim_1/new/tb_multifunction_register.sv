`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Bilkent Universty
// Engineer: Sıla Bozkurt
// 
// Create Date: 23.11.2025 17:12:58
// Design Name: 
// Module Name: tb_multifunction_register
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

module tb_multifunction_register();

    logic clk;
    logic reset;
    logic [2:0] select;
    logic [7:0] D;
    logic shift_in;
    logic [7:0] Q; 

    multifunction_register dut (
        .clk(clk),
        .reset(reset),
        .select(select),
        .D(D),
        .shift_in(shift_in),
        .Q(Q)
    );

    always begin
        clk = 0; #5; 
        clk = 1; #5;
    end

    initial begin
        reset = 1; select = 0; D = 0; shift_in = 0; #10;
        reset = 0; #10;
        select = 3'b000; D = 8'hFF; shift_in = 0; #10;
        
        select = 3'b011; D = 8'b10101010; #10;
        
        select = 3'b000; D = 8'h00; #10;
        
        select = 3'b001; shift_in = 0; #10;
        select = 3'b001; shift_in = 1; #10;
        select = 3'b001; shift_in = 1; #10;
        select = 3'b010; shift_in = 0; #10;
        select = 3'b010; shift_in = 1; #10;
        
        select = 3'b011; D = 8'b10000001; #10;
        select = 3'b100; #10;
        select = 3'b100; #10;
        select = 3'b101; #10;
        select = 3'b101; #10;
        select = 3'b110; #10;
        
        select = 3'b011; D = 8'hFF; #10;
        select = 3'b111; #10;

        $finish;
    end

endmodule