module full_subtractor_tb;

    reg a, b, bin;
   
    wire diff, bout;

    full_subtractor_sop uut (
        .a(a), 
        .b(b), 
        .bin(bin), 
        .diff(diff), 
        .bout(bout)
    );

   
    initial begin
    
        $dumpfile("dump_full_sub.vcd");
        $dumpvars(0, full_subtractor_tb);

        $monitor("Time=%0t | A=%b B=%b Bin=%b | Diff=%b Bout=%b", 
                 $time, a, b, bin, diff, bout);

    
        a = 0; b = 0; bin = 0; #10;
        a = 0; b = 0; bin = 1; #10;
        a = 0; b = 1; bin = 0; #10;
        a = 0; b = 1; bin = 1; #10;
        a = 1; b = 0; bin = 0; #10;
        a = 1; b = 0; bin = 1; #10;
        a = 1; b = 1; bin = 0; #10;
        a = 1; b = 1; bin = 1; #10;

        $finish;
    end

endmodule
