module full_adder(
    input wire a,
    input wire b,
    input wire cin,
    output wire sum,
    output wire cout
);
   
    xor x1(sum, a, b, cin);


    wire s1, s2, s3;
    and a1(s1, a, b);
    and a2(s2, b, cin);
    and a3(s3, a, cin);
    or o1(cout, s1, s2, s3);
endmodule
