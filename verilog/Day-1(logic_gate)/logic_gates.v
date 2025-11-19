module logic_gates(
	input wire a,b,
	output wire not_a,and_o,or_o,nand_o,nor_o, xor_o,xnor_o
);
not not1(not_a, a);
and and1(and_o, a, b);
or or1(or_o, a, b);
nand nand1(nand_o, a, b);
nor nor1(nor_o, a, b);
xor xor1(xor_o, a, b);
xnor xnor1(xnor_o, a, b);
endmodule
