module comp_1bit (
    input a,
    input b,
    output g, 
    output e, 
    output l  
);
    assign g = a & (~b);
    assign e = a ~^ b; 
    assign l = (~a) & b;
endmodule
