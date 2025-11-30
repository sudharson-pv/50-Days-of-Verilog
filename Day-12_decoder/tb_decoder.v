module tb_decoder3_8;
    reg [2:0] a;
    wire [7:0] y;

    decoder3_8 D(a,y);

    initial begin
        $dumpfile("dump_day11.vcd");
        $dumpvars(0,tb_decoder3_8);

        a=3'b000; #10
        a=3'b011; #10
        a=3'b101; #10
        a=3'b111; #10
        $finish;
    end
endmodule
