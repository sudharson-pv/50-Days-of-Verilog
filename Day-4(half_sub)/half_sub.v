module half_sub(
    input wire a, 
    input wire b, 
    output wire diff, 
    output wire borrow
);

    wire na;
    xor xor1(diff, a, b);  
    not not1(na, a);       
    and and1(borrow, na, b); 
endmodule
