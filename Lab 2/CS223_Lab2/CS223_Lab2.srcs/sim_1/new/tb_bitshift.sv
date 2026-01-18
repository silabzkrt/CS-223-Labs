`timescale 1ns / 1ps

module bit_shifter_tb;

    logic [4:0] sw;
    logic [4:0] led;

    bit_shifter dut (
        .sw(sw),
        .led(led)
    );

    initial begin

        
        sw = 5'b00000;
        #10;
        sw = 5'b10000;
        #10;
        sw = 5'b00001;
        #10;
        sw = 5'b10001;
        #10;
        sw = 5'b00010;
        #10;
        sw = 5'b10010;
        #10;
        sw = 5'b00011;
        #10;
        sw = 5'b10011;
        #10;


    end

endmodule