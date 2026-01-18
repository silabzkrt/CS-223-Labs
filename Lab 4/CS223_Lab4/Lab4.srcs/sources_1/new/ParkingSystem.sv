`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.12.2025 20:23:18
// Design Name: 
// Module Name: ParkingSystem
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

module ParkingSystem_Top(
    input logic clk,           // 100MHz Basys3 Clock
    input logic btnC,          // Reset
    input logic btnU,          // Compact
    input logic btnL,          // SUV
    input logic btnR,          // Electric
    input logic btnD,          // VIP
    output logic [15:0] led,   // LEDs
    output logic [6:0] seg,    // 7-Seg Cathodes
    output logic [3:0] an      // 7-Seg Anodes
    );

    logic reset;
    assign reset = btnC;

    // Clock Generation (100MHz -> 1Hz)
    logic clk_1hz;
    logic [26:0] counter_100M;
    logic blink_state;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            counter_100M <= 0; clk_1hz <= 0; blink_state <= 0;
        end else begin
            if (counter_100M >= 49_999_999) begin 
                counter_100M <= 0; 
                clk_1hz <= 1; 
                blink_state <= ~blink_state;
            end else begin
                counter_100M <= counter_100M + 1; 
                clk_1hz <= 0;
            end
        end
    end

    // Debouncers
    logic tick_c, tick_s, tick_e, tick_v; 
    Debouncer db1(clk, btnU, , tick_c);
    Debouncer db2(clk, btnL, , tick_s);
    Debouncer db3(clk, btnR, , tick_e);
    Debouncer db4(clk, btnD, , tick_v);

    
    // Internal Signals for Datapath connection
    logic occ_c, start_c, pop_c; logic [3:0] t_c = 0; logic [3:0] q_c = 0;
    logic occ_s, start_s, pop_s; logic [3:0] t_s = 0; logic [3:0] q_s = 0;
    logic occ_e, start_e, pop_e; logic [3:0] t_e = 0; logic [3:0] q_e = 0;
    logic occ_v, start_v, pop_v; logic [3:0] t_v = 0; logic [3:0] q_v = 0;

    // --- ZONE 1: COMPACT (5s) ---
    ParkingZoneFSM FSM_Compact (
        .clk(clk), .reset(reset), .req_entry(tick_c), 
        .timer_done(t_c == 0), .queue_valid(q_c > 0), 
        .led_occupied(occ_c), .timer_start(start_c), .queue_pop(pop_c)
    );
    // Datapath for Compact
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin t_c <= 0; q_c <= 0; end
        else begin
            if (tick_c && occ_c) q_c <= q_c + 1; // Add to queue if busy
            else if (pop_c && q_c > 0) q_c <= q_c - 1; // Remove from queue if popping
            
            if (start_c) t_c <= 4'd5; // Load Timer
            else if (clk_1hz && t_c > 0) t_c <= t_c - 1; // Decrement
        end
    end

    // --- ZONE 2: SUV (8s) ---
    ParkingZoneFSM FSM_SUV (
        .clk(clk), .reset(reset), .req_entry(tick_s), 
        .timer_done(t_s == 0), .queue_valid(q_s > 0), 
        .led_occupied(occ_s), .timer_start(start_s), .queue_pop(pop_s)
    );
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin t_s <= 0; q_s <= 0; end
        else begin
            if (tick_s && occ_s) q_s <= q_s + 1;
            else if (pop_s && q_s > 0) q_s <= q_s - 1;
            
            if (start_s) t_s <= 4'd8; 
            else if (clk_1hz && t_s > 0) t_s <= t_s - 1;
        end
    end

    // --- ZONE 3: ELECTRIC (10s) ---
    ParkingZoneFSM FSM_Elec (
        .clk(clk), .reset(reset), .req_entry(tick_e), 
        .timer_done(t_e == 0), .queue_valid(q_e > 0), 
        .led_occupied(occ_e), .timer_start(start_e), .queue_pop(pop_e)
    );
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin t_e <= 0; q_e <= 0; end
        else begin
            if (tick_e && occ_e) q_e <= q_e + 1;
            else if (pop_e && q_e > 0) q_e <= q_e - 1;
            
            if (start_e) t_e <= 4'd10; 
            else if (clk_1hz && t_e > 0) t_e <= t_e - 1;
        end
    end

    // --- ZONE 4: VIP (12s) ---
    ParkingZoneFSM FSM_VIP (
        .clk(clk), .reset(reset), .req_entry(tick_v), 
        .timer_done(t_v == 0), .queue_valid(q_v > 0), 
        .led_occupied(occ_v), .timer_start(start_v), .queue_pop(pop_v)
    );
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin t_v <= 0; q_v <= 0; end
        else begin
            if (tick_v && occ_v) q_v <= q_v + 1;
            else if (pop_v && q_v > 0) q_v <= q_v - 1;
            
            if (start_v) t_v <= 4'd12; 
            else if (clk_1hz && t_v > 0) t_v <= t_v - 1;
        end
    end

    
    // LED Helper: Solid ON (111) if Free, Blink if Occupied
    function logic [2:0] get_led(input logic occ, input logic blink);
        if (!occ) return 3'b111; 
        else return {3{blink}}; 
    endfunction

    assign led[2:0]  = get_led(occ_c, blink_state); // Compact
    assign led[6:4]  = get_led(occ_s, blink_state); // SUV
    assign led[10:8]  = get_led(occ_e, blink_state); // Electric
    assign led[14:12] = get_led(occ_v, blink_state); // VIP
    assign led[15] = 4'b0000;

    // 7-Segment Driver (Counts occupied spots)
    logic [2:0] total_parked;
    assign total_parked = occ_c + occ_s + occ_e + occ_v;

    assign an = 4'b1110; // Enable rightmost digit only
    
    always_comb begin
        case (total_parked)
            3'd0: seg = 7'b1000000; // 0
            3'd1: seg = 7'b1111001; // 1
            3'd2: seg = 7'b0100100; // 2
            3'd3: seg = 7'b0110000; // 3
            3'd4: seg = 7'b0011001; // 4
            default: seg = 7'b0111000; // F
        endcase
    end

endmodule