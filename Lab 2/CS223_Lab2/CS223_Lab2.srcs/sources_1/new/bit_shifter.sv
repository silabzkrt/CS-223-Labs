`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2025 09:59:39
// Design Name: 
// Module Name: bit_shifter
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


module bit_shifter (
    input  logic [4:0] sw,
    output logic [4:0] led
    );
always_comb begin
        if (sw[4]) begin
            led[3:0] = {1'b0, sw[3:1]};
            led[4] = sw[0];
        end
        else begin
            led[3:0] = sw;
            led[4] = 1'b0;
        end
    end
endmodule
