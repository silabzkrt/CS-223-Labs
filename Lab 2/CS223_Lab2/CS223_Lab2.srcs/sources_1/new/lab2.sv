`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2025 10:25:43
// Design Name: 
// Module Name: lab2
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

`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Module Name: lab_top
// Description: CS223 Lab 2 için 4 parçayı butonlarla seçen ana modül.
// Button Mapping:
//   - btnU : Part 1 (function_g) [cite: 47]
//   - btnD : Part 2 (dec_2to4) [cite: 50]
//   - btnL : Part 3 (logicfunc) 
//   - btnR : Part 4 (bit_shifter) [cite: 109, 110]
//////////////////////////////////////////////////////////////////////////////////

module lab2 (
    input  logic [4:0] sw,     // 5 Switch (Tüm modüller için ortak)
    input  logic       btnU,   // Part 1 Seçim Butonu
    input  logic       btnD,   // Part 2 Seçim Butonu
    input  logic       btnL,   // Part 3 Seçim Butonu
    input  logic       btnR,   // Part 4 Seçim Butonu
    output logic [4:0] led     // 5 LED (Paylaşımlı)
    );
    
    logic part1;         
    logic [3:0] part2;         
    logic part3 [0:0]; 
    logic [4:0] part4;     
    logic [1:0] mode;                   
    
    

    function_g g_mux_inst (
        .w1(sw[0]), 
        .w2(sw[1]), 
        .w3(sw[2]),
        .g(part1)  
    );
    
    dec_2to4 decoder_inst (
        .in(sw[1:0]),          // Giriş için sw[1:0] kullanalım
        .en(sw[2]),            // 'en' için sw[2] kullanalım
        .y(part2)     // Çıkış portunuzun adı 'y'
    );
    
    logicfunc logicfunc_inst (
        .sw(sw[4:0]),
        .led(part3)
    );
    

    bit_shifter bit_shifter_inst (
        .sw(sw[4:0]),
        .led(part4)
    );
    
    
    always_comb begin
        if (btnL)      mode = 2'b10; // Part 3 (logicfunc)
        else if (btnR) mode = 2'b11; // Part 4 (bit_shifter)
        else if (btnU) mode = 2'b00; // Part 1 (function_g)
        else if (btnD) mode = 2'b01; // Part 2 (dec_2to4)
        else           mode = 2'b10; // Varsayılan mod: Part 3
    end
    

    always_comb begin
        led = 5'b00000; // Varsayılan olarak LED'ler sönük
        
        case (mode)
            // Mode 00: Part 1 (function_g)
            2'b00: begin
                led[0] = part1;
            end
            
            // Mode 01: Part 2 (dec_2to4)
            2'b01: begin
                led[3:0] = part2;
            end
            
            // Mode 10: Part 3 (logicfunc)
            2'b10: begin
                led[0] = part3[0]; 
            end
            
            // Mode 11: Part 4 (bit_shifter)
            2'b11: begin
                led[4:0] = part4; 
            end
            
            default: begin
                led = 5'b00000;
            end
        endcase
    end
    
endmodule