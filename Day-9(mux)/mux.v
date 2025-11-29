module mux2_1(input a, input b, input s, output y);
assign y = (~s & a) | (s & b); 
endmodule

module mux4_1(input [3:0] d, input [1:0] s, output y);
assign y = d[s];
endmodule

module mux8_1(input [7:0] d, input [2:0] s, output y);
assign y = d[s];
endmodule
