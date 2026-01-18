`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2025 09:13:30
// Design Name: 
// Module Name: dec_2to4
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


module dec_2to4(
    input logic [1:0] in,
    input en,
    output logic [3:0] y
    );
    always_comb begin
        if (en == 1'b0) begin
            y = 4'b0000; 
        end
        else begin
            case (in)
                2'b00:   y = 4'b0001; // y[0] is active
                2'b01:   y = 4'b0010; // y[1] is active
                2'b10:   y = 4'b0100; // y[2] is active
                2'b11:   y = 4'b1000; // y[3] is active
                default: y = 4'b0000; // Default case to prevent latches
            endcase
        end
    end

endmodule
