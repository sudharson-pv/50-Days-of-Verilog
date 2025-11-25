module ffav(
    input wire [3:0] A,   
    input wire [3:0] B,   
    input wire cin,       
    output wire [3:0] S,  
    output wire cout    
);

    wire c[2:0]; 
    

    full_adder FA0 (.a(A[0]), .b(B[0]), .cin(cin), .sum(S[0]), .cout(c[0]));
    full_adder FA1 (.a(A[1]), .b(B[1]), .cin(c[0]), .sum(S[1]), .cout(c[1]));
    full_adder FA2 (.a(A[2]), .b(B[2]), .cin(c[1]), .sum(S[2]), .cout(c[2]));
    full_adder FA3 (.a(A[3]), .b(B[3]), .cin(c[2]), .sum(S[3]), .cout(cout));

endmodule
