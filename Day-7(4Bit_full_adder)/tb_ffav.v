module tb_adder;
    reg [3:0] A;
    reg [3:0] B;
    reg cin;
    wire [3:0] S;
    wire cout;

 
    ffav uut (.A(A), .B(B), .cin(cin), .S(S), .cout(cout));

    initial begin
       $dumpfile("tb_4bit_full_adder.vcd");
        $dumpvars(0,tb_adder);
       
        A = 4'b0011;  B = 4'b0101;  cin = 1'b0; #10;
        A = 4'b1111;  B = 4'b0001;  cin = 1'b0; #10;
        A = 4'b0111;  B = 4'b1000;  cin = 1'b1; #10;
        
        $display("Test finished.");
        $finish;
    end
endmodule
