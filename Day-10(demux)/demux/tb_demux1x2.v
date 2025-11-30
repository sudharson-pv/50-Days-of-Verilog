module tb_demux1_2;

    reg a;
    reg s;
    wire y0;
    wire y1;

    demux1_2 uut (
        .a(a),
        .s(s),
        .y0(y0),
        .y1(y1)
    );

    initial begin
 
        a = 1'b0;
        s = 1'b0;


        $display("Time | a | s | y0 | y1 | (Expected) ");
    
	 #10 a = 1'b1; s = 1'b0; 
        $display("%4d | %b | %b | %b | %b | y0 should be a", $time, a, s, y0, y1);

        #10 a = 1'b1; s = 1'b1; 
        $display("%4d | %b | %b | %b | %b | y1 should be a", $time, a, s, y0, y1);

        #10 a = 1'b0; s = 1'b0; 
        $display("%4d | %b | %b | %b | %b | y0,y1 should be 0", $time, a, s, y0, y1);

        #10 a = 1'b0; s = 1'b1; 
        $display("%4d | %b | %b | %b | %b | y0,y1 should be 0", $time, a, s, y0, y1);

        #10 $finish;
    end


endmodule
