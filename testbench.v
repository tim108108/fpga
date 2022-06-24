`timescale 10ns/1ns
module test();
reg clkSys;
reg rst_n;

blockingVSnonblocking UUT(
  .clkSys(clkSys), 
  .rst_n(rst_n)
);

initial begin
  clkSys = 0;
  rst_n = 0;
  repeat(3)@(posedge clkSys)rst_n = 0;
  rst_n = 1;
  #100 $stop;
end

always #5 clkSys = ~clkSys;

endmodule
