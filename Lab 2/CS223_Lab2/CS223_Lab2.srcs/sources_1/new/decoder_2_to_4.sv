`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2025 13:19:23
// Design Name: 
// Module Name: 2_to_4_decoder
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


module decoder_2to4 (
    input  logic [1:0] in,
    input  logic       en,
    output logic [3:0] y
);

always_comb begin
        if (en == 1'b0) begin
            y = 4'b0000; // If not enabled, all outputs are 0
        end
        else begin
            case (in)
                2'b00:   y = 4'b0001; // y[0] is active
                2'b01:   y = 4'b0010; // y[1] is active
                2'b10:   y = 4'b0100; // y[2] is active
                2'b11:   y = 4'b1000; // y[3] is active
                default: y = 4'b0000;
            endcase
        end
   end
endmodule
