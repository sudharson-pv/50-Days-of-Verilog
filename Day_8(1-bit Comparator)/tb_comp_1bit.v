module comp_1bit_tb;
    reg A_tb;
    reg B_tb;
    wire G_tb; 
    wire E_tb; 
    wire L_tb; 
    
      comp_1bit DUT (
        .a(A_tb),
        .b(B_tb),
        .g(G_tb),
        .e(E_tb),
        .l(L_tb)
    );

   
    initial begin
     
        A_tb = 1'b0;
        B_tb = 1'b0;
        
     
        $display("Time | A | B | A>B (G) | A=B (E) | A<B (L) ");
        
        
        #10 A_tb = 1'b0; B_tb = 1'b0;
        #5 $display("%4d | %b | %b | %7b | %7b | %7b", $time, A_tb, B_tb, G_tb, E_tb, L_tb);

       
        #10 A_tb = 1'b0; B_tb = 1'b1;
        #5 $display("%4d | %b | %b | %7b | %7b | %7b", $time, A_tb, B_tb, G_tb, E_tb, L_tb);

    
        #10 A_tb = 1'b1; B_tb = 1'b0;
        #5 $display("%4d | %b | %b | %7b | %7b | %7b", $time, A_tb, B_tb, G_tb, E_tb, L_tb);

        
        #10 A_tb = 1'b1; B_tb = 1'b1;
        #5 $display("%4d | %b | %b | %7b | %7b | %7b", $time, A_tb, B_tb, G_tb, E_tb, L_tb);

        #20 $finish;
    end

endmodule
