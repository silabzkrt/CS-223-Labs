`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.11.2025 19:53:46
// Design Name: 
// Module Name: hexadecimal_7segment
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

module hexadecimal_7segment(
    input  logic [3:0] sw,
    output logic a, b, c, d, e, f, g
    );

    always_comb begin
        case(sw)
            // 0 = ON, 1 = OFF (Common Anode logic)
            4'h0: {a,b,c,d,e,f,g} = 7'b0000001; 
            4'h1: {a,b,c,d,e,f,g} = 7'b1001111; 
            4'h2: {a,b,c,d,e,f,g} = 7'b0010010; 
            4'h3: {a,b,c,d,e,f,g} = 7'b0000110; 
            4'h4: {a,b,c,d,e,f,g} = 7'b1001100; 
            4'h5: {a,b,c,d,e,f,g} = 7'b0100100; 
            4'h6: {a,b,c,d,e,f,g} = 7'b0100000; 
            4'h7: {a,b,c,d,e,f,g} = 7'b0001111; 
            4'h8: {a,b,c,d,e,f,g} = 7'b0000000; 
            4'h9: {a,b,c,d,e,f,g} = 7'b0000100; 
            4'hA: {a,b,c,d,e,f,g} = 7'b0001000; 
            4'hB: {a,b,c,d,e,f,g} = 7'b1100000; 
            4'hC: {a,b,c,d,e,f,g} = 7'b0110001; 
            4'hD: {a,b,c,d,e,f,g} = 7'b1000010; 
            4'hE: {a,b,c,d,e,f,g} = 7'b0110000; 
            4'hF: {a,b,c,d,e,f,g} = 7'b0111000; 
            default: {a,b,c,d,e,f,g} = 7'b1111111; // OFF
        endcase
    end
endmodule