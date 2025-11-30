module tb_demux1_8;

 
  reg a;
  reg [2:0] s;
  wire [7:0] y;


  demux1_8 UUT (
    .a (a),
    .s   (s),
    .y   (y)
  );


  initial begin
    $dumpfile("demux1_8.vcd");
    $dumpvars(0, tb_demux1_8);
    $monitor("Time=%0t | Input: a=%b, s=%b | Output: y[7:0]=%b", $time, a, s, y);

   
    a = 1; 
    
    s = 3'b000; #10; 
    s = 3'b001; #10; 
    s = 3'b010; #10; 
    s = 3'b111; #10; 
    s = 3'b101; #10; 
    
        a = 0;
    s = 3'b011; #10; 
    s = 3'b110; #10; 
    
    $finish;
  end

endmodule
