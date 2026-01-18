`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2025 08:59:34
// Design Name: 
// Module Name: logicfunc
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


module logicfunc(
    input logic [4:0]sw,
    output logic led[0:0]
    );
    logic [3:0] decoder_out;
    
    logic [7:0] mux_in;     
    
    logic [2:0] mux_select = {sw[4], sw[3], sw[2]};
    
    logic y;


    dec_2to4 decoder (
        .in(sw[1:0]),
        .en(1'b1),
        .y(decoder_out)
    );

 
    assign mux_in[0] = 1'b1;
    
    assign mux_in[1] = decoder_out[0];
    
    assign mux_in[2] = sw[1];
    
    assign mux_in[3] = 1'b0;
    
    assign mux_in[4] = 1'b1;
    
    assign mux_in[5] = 1'b0;
    
    assign mux_in[6] = decoder_out[1];
    
    assign mux_in[7] = ~sw[1];
    
    mux_8to1 mux (
        .in(mux_in), 
        .sel(mux_select), 
        .y(led[0]) 
    );
    
//    assign led[0] = (~sw[1] & ~sw[0]) | (~sw[0] & ~sw[2] & sw[3]) | (sw[0] & ~sw[2] & ~sw[3] & sw[4] ) | (sw[0] & sw[1] & sw[2] & ~sw[4]) | (~sw[0] & ~sw[1] & ~sw[3] & ~sw[4]);
endmodule