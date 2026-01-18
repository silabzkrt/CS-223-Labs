`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2025 11:58:01
// Design Name: 
// Module Name: tb_logicfunc
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

module logicfunc_tb;

    logic [4:0] sw;
    logic [0:0] led;
    logic       expected_led;
    integer     errors = 0;
    integer     i;
    
    // logicfunc modülünü test et
    logicfunc dut (
        .sw(sw),
        .led(led)
    );

    function automatic logic calculate_expected(logic [4:0] s);
        logic [3:0] decoder_out;
        logic [7:0] mux_in;
        logic [2:0] mux_select;
        logic       dec_out0, dec_out1;

        // Decoder mantığı
        dec_out0 = (s[1:0] == 2'b00); // decoder_out[0]
        dec_out1 = (s[1:0] == 2'b01); // decoder_out[1]

        // Mux giriş mantığı
        mux_in[0] = 1'b1;
        mux_in[1] = dec_out0;
        mux_in[2] = s[1];
        mux_in[3] = 1'b0;
        mux_in[4] = 1'b1;
        mux_in[5] = 1'b0;
        mux_in[6] = dec_out1;
        mux_in[7] = ~s[1];
        
        // Mux seçme mantığı
        mux_select = {s[4], s[3], s[2]};
        
        // Mux çıkış mantığı
        return mux_in[mux_select];
    endfunction

    initial begin
        $display("Starting logicfunc testbench...");
        
        // 5 giriş biti (2^5 = 32) için tüm kombinasyonları test et
        for (i = 0; i < 32; i = i + 1) begin
            sw = i;
            
            // Beklenen değeri hesapla
            expected_led = calculate_expected(sw);
            
            #10; // Sinyallerin yerleşmesi için bekle
            
            // Gerçek çıkış ile beklenen çıkışı karşılaştır
            if (led[0] !== expected_led) begin
                $display("Error! sw=%b (%2d), led=%b, expected=%b",
                         sw, i, led[0], expected_led);
                errors = errors + 1;
            end
        end
        
        if (errors == 0) begin
            $display("Test complete! All 32 combinations passed.");
        end else begin
            $display("Test complete. Found %0d errors.", errors);
        end
        
        $stop;
    end

endmodule
