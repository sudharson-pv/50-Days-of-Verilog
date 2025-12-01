module priority_encoder (
    input  wire [7:0] I,    
    output wire [2:0] O     
);
    assign O = I[7] ? 3'b111 :     
               I[6] ? 3'b110 :    
               I[5] ? 3'b101 :      
               I[4] ? 3'b100 :    
               I[3] ? 3'b011 :    
               I[2] ? 3'b010 :      
               I[1] ? 3'b001 :      
               I[0] ? 3'b000 : 
                      3'b000;        

endmodule


module tb_priority_encoder;
     reg  [7:0] I;
     wire [2:0] O;

      priority_encoder P_DUT (
        .I (I),
        .O (O)
    );

 initial begin    
 	$dumpfile("dump_simple.vcd");
        $dumpvars(0, tb_priority_encoder);

repeat (10) begin
        I = $random;#10;
end

        $finish;
end
endmodule
