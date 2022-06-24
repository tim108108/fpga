
module blockingVSnonblocking(
  clkSys,
  rst_n
);
input clkSys;
input rst_n;
reg [1:0]a;
reg [1:0]b;
reg [1:0]c;
always@(posedge clkSys or negedge rst_n)begin
  if(!rst_n)begin
    a <= 2'd1;
    b <= 2'd2;
    c <= 2'd3;
  end
  else begin
    a <= c;
    b <= a;
    c <= b;
  end
end
endmodule
