module full_adder(
    input wire a, b, cin,
    output wire sum, cout
);
    wire s1, c1, c2;

   
    xor g1(s1, a, b);       
    xor g2(sum, s1, cin);   

   
    and g3(c1, a, b);       
    and g4(c2, s1, cin);    
    or  g5(cout, c1, c2);   

endmodule
