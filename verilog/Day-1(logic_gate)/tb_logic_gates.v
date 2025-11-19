module tb_logic_gates;
    reg a, b;
    wire not_a, and_o, or_o, nand_o, nor_o, xor_o, xnor_o;

    
    logic_gates uut (
        .a(a), .b(b),
        .not_a(not_a), .and_o(and_o), .or_o(or_o),
        .nand_o(nand_o), .nor_o(nor_o), .xor_o(xor_o), .xnor_o(xnor_o)
    );

    initial begin
 
    $dumpfile("logiv_gates_wave.vcd"); 
    $dumpvars(0, tb_logic_gates); 
end

    initial begin
        $monitor("A=%b B=%b | NOT=%b AND=%b OR=%b XOR=%b", a, b, not_a, and_o, or_o, xor_o);
        
        
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        $finish;
    end
endmodule
