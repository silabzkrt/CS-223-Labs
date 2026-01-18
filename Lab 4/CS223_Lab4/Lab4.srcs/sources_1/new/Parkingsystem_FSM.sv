`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.12.2025 09:07:46
// Design Name: 
// Module Name: Parkingsystem_FSM
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
module ParkingZoneFSM (
    input logic clk,
    input logic reset,
    input logic req_entry,     // Button press (arrival)
    input logic timer_done,    // Signal from datapath: Timer reached 0
    input logic queue_valid,   // Signal from datapath: Queue > 0
    output logic led_occupied, // Controls blinking LED
    output logic timer_start,  // Triggers timer load
    output logic queue_pop     // Triggers queue decrement
    );

    typedef enum logic [2:0] {
        IDLE        = 3'b000,
        START_TIMER = 3'b001,
        BUSY        = 3'b010,
        DONE        = 3'b011,
        CHECK_Q     = 3'b100
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) current_state <= IDLE;
        else       current_state <= next_state;
    end

    always_comb begin
        next_state = current_state; // Default
        case (current_state)
            IDLE: begin
                if (req_entry || queue_valid) next_state = START_TIMER;
                else                          next_state = IDLE;
            end
            START_TIMER: begin
                next_state = BUSY; // Unconditional transition
            end
            BUSY: begin
                if (timer_done) next_state = DONE;
                else            next_state = BUSY;
            end
            DONE: begin
                next_state = CHECK_Q; // Unconditional transition
            end
            CHECK_Q: begin
                if (queue_valid) next_state = START_TIMER; // Loop back for queued car
                else             next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    always_comb begin
        led_occupied = (current_state == START_TIMER) || 
                       (current_state == BUSY) || 
                       (current_state == DONE) || 
                       (current_state == CHECK_Q);

        // Timer Mantığı: Hem START_TIMER hem de BUSY durumunda aktif
        // 
        timer_start  = (current_state == START_TIMER) || (current_state == BUSY);

        // Queue Pop Mantığı: Sadece CHECK_Q durumunda VE kuyruk geçerliyse
        //  -> Bu satır PDF'teki Mealy mantığını korur.
        queue_pop    = (current_state == CHECK_Q) && queue_valid; 
    end
endmodule