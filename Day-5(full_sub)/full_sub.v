module full_subtractor_sop(
    input  a, b,bin, 
    output diff, bout
);


    xor u_diff(diff, a, b, bin);
    wire not_a;
    wire term1,term2,term3;

    not u_inv(not_a, a);
    and u_term1(term1, not_a, b);    
    and u_term2(term2, not_a, bin); 
    and u_term3(term3, b, bin);      

    or u_bout(bout, term1, term2, term3);

endmodule
