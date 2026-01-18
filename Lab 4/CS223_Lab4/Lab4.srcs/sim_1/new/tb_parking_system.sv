`timescale 1ns / 1ps

module tb_ParkingSystem_Fixed;

    // --- Inputs ---
    logic clk;
    logic btnC; // Reset
    logic btnU; // Compact
    logic btnL; // SUV
    logic btnR; // Electric
    logic btnD; // VIP

    // --- Outputs ---
    wire [15:0] led;
    wire [6:0] seg;
    wire [3:0] an;

    // --- UUT Instantiation ---
    ParkingSystem_Top uut (
        .clk(clk),
        .btnC(btnC),
        .btnU(btnU),
        .btnL(btnL),
        .btnR(btnR),
        .btnD(btnD),
        .led(led),
        .seg(seg),
        .an(an)
    );

    // --- Clock Generation (100MHz) ---
    always #5 clk = ~clk;

    // --- Button Press Helper Task ---
    task press_btn(ref logic btn, input string name);
        begin
            $display("[%0t ns] Action: Pressing %s", $time, name);
            btn = 1;
            #200; // Hold long enough for fast debouncer
            btn = 0;
            #200; // Release
        end
    endtask

    // --- Main Test Sequence ---
    initial begin
        // 1. Initialize
        clk = 0;
        btnC = 0; btnU = 0; btnL = 0; btnR = 0; btnD = 0;
        
        $display("-----------------------------------------------------");
        $display("STARTING SIMULATION");
        $display("NOTE: If LEDs do not blink, you forgot to lower the counter values in source code!");
        $display("-----------------------------------------------------");

        // 2. Reset System
        $display("[%0t ns] Resetting...", $time);
        btnC = 1; #200; btnC = 0; #200;

        // Check Initial State: All Spots Free = LEDs Solid ON (111)
        // LED mapping: 0000(unused) VVV(11:9) EEE(8:6) SSS(5:3) CCC(2:0)
        if (led[11:0] === 12'b111111111111) 
            $display("PASS: Initial State -> All LEDs Solid ON (Empty)");
        else 
            $display("FAIL: Initial State -> LEDs are %b (Expected all 1s)", led[11:0]);

        // ============================================================
        // TEST 1: COMPACT ZONE (CCC - led[2:0])
        // ============================================================
        press_btn(btnU, "Compact Button (btnU)");
        
        #50; // Wait for logic to update
        
        // Compact LEDs should NOT be 111 anymore (should be blinking/0)
        if (led[2:0] !== 3'b111) 
            $display("PASS: Compact Zone (CCC) Active -> LEDs Changed state");
        else 
            $display("FAIL: Compact Zone (CCC) did not react!");

        // Wait for timer (Compact Timer = 5 ticks)
        #6000; 

        // After timer, it should go back to Solid ON (111)
        if (led[2:0] === 3'b111) 
            $display("PASS: Compact Car Left -> LEDs Solid ON");
        else 
            $display("FAIL: Compact LEDs still blinking!");


        // ============================================================
        // TEST 2: SUV ZONE (SSS - led[5:3])
        // ============================================================
        press_btn(btnL, "SUV Button (btnL)");
        #50;

        if (led[5:3] !== 3'b111) 
            $display("PASS: SUV Zone (SSS) Active -> LEDs Changed state");
        else 
            $display("FAIL: SUV Zone (SSS) did not react!");

        // Wait for SUV timer (8 ticks)
        #9000;


        // ============================================================
        // TEST 3: ELECTRIC ZONE (EEE - led[8:6])
        // ============================================================
        press_btn(btnR, "Electric Button (btnR)");
        #50;

        if (led[8:6] !== 3'b111) 
            $display("PASS: Electric Zone (EEE) Active -> LEDs Changed state");
        else 
            $display("FAIL: Electric Zone (EEE) did not react!");

        // Wait for Electric timer (10 ticks)
        #11000;


        // ============================================================
        // TEST 4: VIP ZONE (VVV - led[11:9])
        // ============================================================
        press_btn(btnD, "VIP Button (btnD)");
        #50;

        if (led[11:9] !== 3'b111) 
            $display("PASS: VIP Zone (VVV) Active -> LEDs Changed state");
        else 
            $display("FAIL: VIP Zone (VVV) did not react!");

        // Wait for VIP timer (12 ticks)
        #13000;

        // ============================================================
        // TEST 5: SIMULTANEOUS FILL (Verify Segments)
        // ============================================================
        $display("-----------------------------------------------------");
        $display("FILLING ALL SPOTS...");
        press_btn(btnU, "Compact");
        press_btn(btnL, "SUV");
        press_btn(btnR, "Electric");
        press_btn(btnD, "VIP");
        
        #500;
        
        // Count should be 4
        // Seg pattern for '4' is 7'b0011001
        if (seg === 7'b0011001) 
            $display("PASS: Segment Display shows '4'");
        else 
            $display("FAIL: Segment Display shows %b", seg);

        $display("-----------------------------------------------------");
        $display("SIMULATION COMPLETE");
        $finish;
    end

endmodule