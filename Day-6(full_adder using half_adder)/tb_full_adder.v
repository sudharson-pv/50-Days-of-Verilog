module tb_full_adder;
    reg a,b,cin;

    wire sum,cout;
    full_adder DUT (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    
    initial begin
        $monitor("Time: %0t | A=%b, B=%b, Cin=%b | Sum=%b, Cout=%b", $time, a, b, cin, sum, cout);
    end

    initial begin
       
        $dumpfile("dump_full_adder.vcd");
        $dumpvars(0,tb_full_adder);

        a = 0; b = 0; cin = 0; #10
        a = 0; b = 0; cin = 0; #10;
        a = 0; b = 0; cin = 1; #10;
        a = 0; b = 1; cin = 0; #10;
        a = 0; b = 1; cin = 1; #10;
        a = 1; b = 0; cin = 0; #10;
        a = 1; b = 0; cin = 1; #10;
        a = 1; b = 1; cin = 0; #10;
        a = 1; b = 1; cin = 1; #10;
        $finish;
    end
endmodule
