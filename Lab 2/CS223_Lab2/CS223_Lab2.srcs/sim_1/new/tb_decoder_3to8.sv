`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2025 16:22:51
// Design Name: 
// Module Name: tb_decoder_3to8
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


module tb_decoder_3to8;

    logic [2:0] in_tb;
    logic       en_tb;
    wire  [7:0] y_out_tb;

    decoder_3to8 dut (
        .in(in_tb),
        .en(en_tb),
        .y_out(y_out_tb)
    );

    initial begin
        $display("--- Starting 3-to-8 Decoder Testbench ---");
        $display("Time | En | In  | Y_Out");
        $display("---------------------------------------");
        

        $monitor("%4t | %b  | %b | %b", $time, en_tb, in_tb, y_out_tb);


        $display("--- Test Case 1: Enable OFF ---");
        en_tb = 1'b0;
        

        in_tb = 3'b000;
        #10;
        in_tb = 3'b101;
        #10;
        in_tb = 3'b111;
        #10;

        $display("--- Test Case 2: Enable ON ---");
        en_tb = 1'b1;
        

        for (int i = 0; i < 8; i = i + 1) begin
            in_tb = i;
            #10; 
        end

        $display("---------------------------------------");
        $display("--- Testbench Finished ---");
        $finish; 
    end

endmodule
