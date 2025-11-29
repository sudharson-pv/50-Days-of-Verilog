module tb_mux;
reg a,b,s;
wire y2;

reg [3:0] d4;
reg [1:0] s4;
wire y4;

reg [7:0] d8;
reg [2:0] s8;
wire y8;

mux2_1 M1(a,b,s,y2);
mux4_1 M2(d4,s4,y4);
mux8_1 M3(d8,s8,y8);

initial begin
$dumpfile("dump_day8.vcd");
$dumpvars(0,tb_mux);

a=0; b=1; s=0; #10
a=0; b=1; s=1; #10

d4=4'b1101; s4=2'b00; #10
s4=2'b01; #10
s4=2'b10; #10
s4=2'b11; #10

d8=8'b10110011; s8=3'b000; #10
s8=3'b011; #10
s8=3'b101; #10
$finish;
end
endmodule

