module encoder8_3(input [7:0] x, output [2:0] y);

assign y = x[7] ? 3'b111 :
           x[6] ? 3'b110 :
           x[5] ? 3'b101 :
           x[4] ? 3'b100 :
           x[3] ? 3'b011 :
           x[2] ? 3'b010 :
           x[1] ? 3'b001 :
           3'b000; 
endmodule


module tb_encoder;
reg [7:0] a;
wire [2:0] b;

encoder8_3 E1(a,b);

initial begin
    $dumpfile("dump_day10.vcd");
    $dumpvars(0,tb_encoder);


    a = 8'h00;
    #10;

    $display("Time | Input a | Output b");

    repeat(6)
    begin
        a = $random;
        #10;
        $display("%0t | %8b | %3b", $time, a, b); 
    end

    $finish;
end
endmodule
