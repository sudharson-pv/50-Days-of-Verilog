module demux1_2(input a,s, output y0,y1);
assign y0 = (!s) ? a : 0;
assign y1 = (s) ? a : 0;
endmodule

module demux1_4(input a, 
	input [1:0] s, 
	output y0,y1,y2,y3
);
assign y0 = (s==2'b00) ? a : 0;
assign y1 = (s==2'b01) ? a : 0;
assign y2 = (s==2'b10) ? a : 0;
assign y3 = (s==2'b11) ? a : 0;
endmodule

module demux1_8(input a,
       	input [2:0] s,
       	output [7:0] y);
assign y = 8'b00000001 << s & {8{a}};
endmodule

