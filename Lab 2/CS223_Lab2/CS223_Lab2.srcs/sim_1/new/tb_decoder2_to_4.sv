`timescale 1ns / 1ps
module tb_decoder_2to4;

    logic [1:0] in;
    logic       en;


    wire  [3:0] y;

    dec_2to4 dut (
        .in(in),
        .en(en),
        .y(y)
    );


    initial begin
        $display("--- Starting Decoder Testbench ---");
        $display("Time | En | In | Y_Out");
        $display("----------------------------");
        

        $monitor("%4t | %b  | %b | %b", $time, en, in, y);


        $display("--- Test Case 1: Enable OFF ---");
        en= 1'b0;
        

        in = 2'b00;
        #10;
        in = 2'b10;
        #10;
        in = 2'b11;
        #10;


        $display("--- Test Case 2: Enable ON ---");
        en = 1'b1;
        
        for (int i = 0; i < 4; i = i + 1) begin
            in = i;
            #10; 
        end

        $display("----------------------------");
        $display("--- Testbench Finished ---");
        $finish; 
    end

endmodule
