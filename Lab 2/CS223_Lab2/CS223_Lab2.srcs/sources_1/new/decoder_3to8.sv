`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2025 16:09:38
// Design Name: 
// Module Name: decoder_3to8
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


module decoder_3to8 (
    input  logic [1:0] in,    
    input  logic       en,    
    output logic [7:0] y_out  
);


    logic en_low;   
    logic en_high;  


    logic [3:0] y_low;
    logic [3:0] y_high;


    assign en_low  = en & ~in[2];

    assign en_high = en &  in[2];


    decoder_2to4 dec_low (
        .in(in[1:0]),
        .en(en_low),
        .y_out(y_low)
    );


    decoder_2to4 dec_high (
        .in(in[1:0]),
        .en(en_high),
        .y_out(y_high)
    );
    assign y_out = {y_high, y_low};

endmodule
