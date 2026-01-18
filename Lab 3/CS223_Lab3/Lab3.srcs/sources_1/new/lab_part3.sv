`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Bilkent University
// Engineer: Sıla Bozkurt
// 
// Create Date: 25.11.2025 15:50:45
// Design Name: 
// Module Name: lab_part3
// Project Name: 
// Target Devices: Basys3
// Tool Versions: 
// Description: 16-bit Lab Counter with Alarm (Part 3)
//              - Cascades two 8-bit multifunction registers
//              - Doubles (shift left) or halves (shift right) count
//              - Displays count on 4-digit 7-segment display
//              - Alarm flashes LEDs when count exceeds threshold
// 
// Dependencies: multifunction_register, lab_part2b, clock_divider
// 
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module lab_part3 (
    input logic clk,       
    input logic [15:0] sw, 
    output logic a, b, c, d, e, f, g, 
    output logic [3:0] an,
    output logic dp,
    output logic [15:0] led
);

    logic [26:0] clk_div;
    always_ff @(posedge clk) begin
        clk_div <= clk_div + 1;
    end
    
    logic clk_disp;
    assign clk_disp = clk_div[16]; 

    logic pulse_update;
    assign pulse_update = (clk_div[25:0] == 0);

    logic [2:0] op_select;
    logic counter_reset;
    logic [15:0] load_data;
    
    assign op_select = sw[15:13]; 
    assign counter_reset = sw[12];
    assign load_data = {4'b0000, sw[11:0]};

    logic [15:0] counter_q;
    logic shift_in_low, shift_in_high;
    logic [2:0] actual_select;

    always_comb begin
        shift_in_low = 1'b0;
        shift_in_high = 1'b0;
        
        if (op_select == 3'b001) begin // Shift Left (Double)
            shift_in_low = 1'b0;
            shift_in_high = counter_q[7]; // MSB of low moves to LSB of high
        end else if (op_select == 3'b010) begin // Shift Right (Halve)
            shift_in_high = 1'b0;
            shift_in_low = counter_q[8];  // LSB of high moves to MSB of low
        end
    end

    always_comb begin
        if (counter_reset) actual_select = 3'bXXX;
        else if (pulse_update) actual_select = op_select;
        else actual_select = 3'b000; 
    end

    multifunction_register reg_low (
        .clk(clk), 
        .reset(counter_reset), 
        .select(actual_select), 
        .shift_in(shift_in_low), 
        .D(load_data[7:0]), 
        .Q(counter_q[7:0])
    );

    multifunction_register reg_high (
        .clk(clk), 
        .reset(counter_reset), 
        .select(actual_select), 
        .shift_in(shift_in_high), 
        .D(load_data[15:8]), 
        .Q(counter_q[15:8])
    );

    logic [1:0] digit_sel;
    always_ff @(posedge clk_disp) begin
        digit_sel <= digit_sel + 1;
    end

    logic [3:0] hex_to_show;
    always_comb begin
        case(digit_sel)
            2'b00: begin an = 4'b1110; hex_to_show = counter_q[3:0];   end // Rightmost
            2'b01: begin an = 4'b1101; hex_to_show = counter_q[7:4];   end
            2'b10: begin an = 4'b1011; hex_to_show = counter_q[11:8];  end
            2'b11: begin an = 4'b0111; hex_to_show = counter_q[15:12]; end // Leftmost
        endcase
    end

    hexadecimal_7segment decoder (
        .sw(hex_to_show), 
        .a(a), 
        .b(b), 
        .c(c), 
        .d(d), 
        .e(e), 
        .f(f), 
        .g(g)
    );

    assign dp = 1'b1; 
    logic alarm_active;
    assign alarm_active = (counter_q > 16'h0BCC); 
    assign led = alarm_active ? (clk_div[24] ? 16'hFFFF : 16'h0000) : counter_q;

endmodule