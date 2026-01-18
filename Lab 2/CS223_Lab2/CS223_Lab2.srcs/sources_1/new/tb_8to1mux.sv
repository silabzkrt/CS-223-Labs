`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2025 10:27:17
// Design Name: 
// Module Name: tb_8to1mux
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


1ps

module eighttoonemux_tb;

    logic [10:0] sw;
    logic [0:0]  led;
    logic        expected_led;
    integer      i, j;

    eighttoonemux dut (
        .sw(sw),
        .led(led)
    );

    initial begin
        sw = 0;
        
        for (i = 0; i < 8; i = i + 1) begin
            sw[10:8] = i; 
            
            for (j = 0; j < 8; j = j + 1) begin
                sw[j] = 1'b0;
            end
            
            #10;
            
            for (j = 0; j < 8; j = j + 1) begin
                sw[j] = 1'b1;
                expected_led = (j == i);
                #10;
                if (led[0] !== expected_led) begin
                    $display("Error: S=%b, D[%0d]=1, led=%b, expected=%b", 
                             sw[10:8], j, led[0], expected_led);
                end
                sw[j] = 1'b0;
            end
            
            
            sw[10:8] = i;
            sw[7:0] = 8'hFF;
            expected_led = 1'b1;
            #10;
            if (led[0] !== expected_led) begin
                 $display("Error: S=%b, D=FF, led=%b, expected=%b", 
                             sw[10:8], led[0], expected_led);
            end

            sw[7:0] = 8'h00;
            expected_led = 1'b0;
             #10;
            if (led[0] !== expected_led) begin
                 $display("Error: S=%b, D=00, led=%b, expected=%b", 
                             sw[10:8], led[0], expected_led);
            end
        end

        $display("Test complete.");
        $stop;
    end

endmodule