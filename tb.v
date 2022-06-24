module tb;

reg       clk;
reg       rstn;
reg [5:0] cnt;

always #5 clk = ~clk;

always @(posedge clk or negedge rstn)begin
    if(!rstn)
        cnt <= 6'h0;
    else
        cnt <= cnt + 6'h1;
end

initial begin
    clk  = 1'b0;
    rstn = 1'b1;
    #10;
    rstn = 1'b0;
    #10;
    rstn = 1'b1;
    $display("Hello ICARUS verilog!");
    #1000;
    $finish;
end

always @(cnt)begin
    $display("%0t, cnt=%d",$time,cnt);
end

initial

begin
   $dumpfile("tb.vcd");
   $dumpvars(0,tb);
end

endmodule
