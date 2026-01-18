`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2025 09:47:19
// Design Name: 
// Module Name: tb_fourtoonemux
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


module tb_fourtoonemux;

  logic s0, s1;
  logic i0, i1, i2, i3;
  
  wire y;

  fourtoonemux dut (
    .s0(s0),
    .s1(s1),
    .i0(i0),
    .i1(i1),
    .i2(i2),
    .i3(i3),
    .y(y)
  );

  initial begin
    $monitor("Time=%0t | Select(s1,s0)=%b%b | Inputs(i3,i2,i1,i0)=%b%b%b%b | Output(y)=%b",
             $time, s1, s0, i3, i2, i1, i0, y);

    i0 = 0; i1 = 0; i2 = 0; i3 = 0;
    s0 = 0; s1 = 0;
    #10; 

    $display("\n--- Testing Select i0 (s1=0, s0=0) ---");
    s1 = 0; s0 = 0;
    i0 = 1; i1 = 0; i2 = 0; i3 = 0; 
    #10; 
    i0 = 0; 
    #10; 

    $display("\n--- Testing Select i1 (s1=0, s0=1) ---");
    s1 = 0; s0 = 1;
    i0 = 0; i1 = 1; i2 = 0; i3 = 0;
    #10; 
    i1 = 0;
    #10; 

    $display("\n--- Testing Select i2 (s1=1, s0=0) ---");
    s1 = 1; s0 = 0;
    i0 = 0; i1 = 0; i2 = 1; i3 = 0;
    #10; 
    i2 = 0;
    #10; 

    $display("\n--- Testing Select i3 (s1=1, s0=1) ---");
    s1 = 1; s0 = 1;
    i0 = 0; i1 = 0; i2 = 0; i3 = 1;
    #10; 
    i3 = 0;
    #10;
    
    $display("\n--- Testbench Finished ---");
    $finish;
  end

endmodule

