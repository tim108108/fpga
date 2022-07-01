module D_latch(en,D,Q);	//閂鎖器
input en,D;
output reg Q;
always@(D or en or Q)
begin
	if(en) Q=D;
	else Q = Q;
end
endmodule

module DFF_p(clk,D,Q);	//D型正反器_正緣
input clk,D;
output reg Q;
always@(posedge clk)
begin
	Q<=D;
end
endmodule

module DFF_n(clk,D,Q);	//D型正反器_負緣
input clk,D;
output reg Q;
always@(negedge clk)
begin
	Q<=D;
end
endmodule

module DFF_SR(clk,rst,in,Q);	//同步重置D型正反器
input clk,rst,in;
output reg Q;
always@(posedge clk)
begin
	if(rst) Q<=1'b0;
	else Q<=in;
end
endmodule

module DFF_AR(clk,rst,in,Q);	//非同步重置D型正反器
input clk,rst,in;
output reg Q;
always@(posedge clk or posedge rst)
begin
	if(rst) Q<=1'b0;
	else Q<=in;
end
endmodule

module DFF_en(clk,rst,en,in,Q);	//致能D型正反器
input clk,rst,en,in;
output reg Q;
always@(posedge clk)
begin
	if(rst) Q<=1'b0;
	else if(en) Q<=in;
end		 //else Q <=Q 可以不用寫
endmodule

module reg_4bits(clk,rst,en,in,out);	//4位元暫存器
input clk,rst,en;
input [3:0] in;
output reg [3:0] out;
always@(posedge clk or posedge rst)
begin
	if(rst) out<=4'b0000;
	else out<=in;
end
endmodule
