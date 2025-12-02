module tb_parity;
reg a0,a1,a2,a3;
wire p;
wire e;

parity_generator G(a0,a1,a2,a3,p);
parity_checker   C(a0,a1,a2,a3,p,e);

initial begin
$dumpfile("parity.vcd");
$dumpvars(0,tb_parity);

a0=0; a1=0; a2=0; a3=0; #10
a0=1; a1=0; a2=1; a3=1; #10
a0=0; a1=1; a2=0; a3=1; #10
a0=1; a1=1; a2=1; a3=0; #10

$finish;
end
endmodule

