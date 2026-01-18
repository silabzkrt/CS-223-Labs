


module two_bit_fulladder(
    input logic sw[3:0], 
    output logic led[2:0]
    );
    logic cout = 1'b0;
    
    full_adder fa1 (
        .a(sw[0]), .b(sw[2]), .cin(1'b0),
        .sum(led[0]), .cout(cout1)
    );


    full_adder fa2 (
        .a(sw[1]), .b(sw[3]), .cin(cout1),
        .sum(led[1]), .cout(led[2])
    );
    
    
endmodule
