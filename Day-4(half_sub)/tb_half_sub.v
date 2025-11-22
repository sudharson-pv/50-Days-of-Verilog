module tb_half_sub;
    reg a;
    reg b;
    wire diff;
    wire borrow;

    half_sub U(
        .a(a), 
        .b(b), 
        .diff(diff), 
        .borrow(borrow)
    );

    initial begin
        
        $dumpfile("dump_tb_half_sub.vcd");
        $dumpvars(0, tb_half_sub);

        $monitor("Time=%0t | A=%b B=%b | Diff=%b Borrow=%b", $time, a, b, diff, borrow);
      
        a=0; b=0; #10;
        a=0; b=1; #10;
        a=1; b=0; #10;
        a=1; b=1; #10;
        
        $finish;
    end
endmodule
