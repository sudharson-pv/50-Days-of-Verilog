module half_adder(input wire a,b,
       	output wire sum,carry);
xor xor1(sum, a, b);
and and1(carry, a, b);
endmodule
