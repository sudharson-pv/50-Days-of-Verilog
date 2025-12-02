module parity_generator(input a0,a1,a2,a3,output p);
assign p = a0 ^ a1 ^ a2 ^ a3;
endmodule


module parity_checker(input a0,a1,a2,a3,p,output e);
assign e = a0 ^ a1 ^ a2 ^ a3 ^ p;
endmodule

