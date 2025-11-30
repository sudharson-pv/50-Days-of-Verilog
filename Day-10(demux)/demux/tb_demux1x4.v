module tb_demux1_4;
  reg a;
  reg [1:0] s;
  wire y0, y1, y2, y3;


  demux1_4 UUT (
    .a (a),
    .s   (s),
    .y0  (y0),
    .y1  (y1),
    .y2  (y2),
    .y3  (y3)
  );


  initial begin
    $dumpfile("demux1_4.vcd");
    $dumpvars(0, tb_demux1_4);
    $monitor("Time=%0t | Input: a=%b, s=%b | Output: y0=%b, y1=%b, y2=%b, y3=%b", $time, a, s, y0, y1, y2, y3);

 
    a = 1; 
    s = 2'b00; #10; 
    s = 2'b01; #10; 
    s = 2'b10; #10; 
    s = 2'b11; #10; 

    a = 0;
    s = 2'b01; #10; 
    s = 2'b10; #10; 
    
    $finish;
  end

endmodule
