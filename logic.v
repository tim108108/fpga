module D_latch(en,D,Q);	//閂鎖器
input en,D;
output reg Q;
always@(D or en or Q)
begin
	if (en) Q=D;
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
	if (rst) Q<=1'b0;
	else Q<=in;
end
endmodule

module DFF_AR(clk,rst,in,Q);	//非同步重置D型正反器
input clk,rst,in;
output reg Q;
always@(posedge clk or posedge rst)
begin
	if (rst) Q<=1'b0;
	else Q<=in;
end
endmodule

module DFF_en(clk,rst,en,in,Q);	//致能D型正反器
input clk,rst,en,in;
output reg Q;
always@(posedge clk)
begin
	if (rst) Q<=1'b0;
	else if(en) Q<=in;
end		 //else Q <=Q 可以不用寫
endmodule

module reg_4bits(clk,rst,en,in,out);	//4位元暫存器
input clk,rst,en;
input [3:0] in;
output reg [3:0] out;
always@(posedge clk or posedge rst)
begin
	if (rst) out<=4'b0000;
	else out<=in;
end
endmodule

module upCnt_1(rst,clk,out);
input rst,clk;
output reg [2:0] out;
reg [2:0] din;
always@(posedge clk)
begin 
	if (rst) out <= 3'd0;
	else out <= din;
end
always@(out)
begin
	if (out == 3'd5)
		din = 3'd0;
	else 
		din = out;
end
endmodule

module upCnt_2(rst,clk,out);
input rst,clk;
output reg [2:0] out;
always@(posedge clk)
begin 
	if (rst) out <= 3'd0;
	else 
		if (out == 3'd5)
			out <= 3'd0;
		else 
			out <= out + 3'd1;
end
endmodule

module downCnt_1(rst,clk,out);
input rst,clk;
output reg [2:0] out;
always@(negedge clk)
begin 
	if (!rst) out <= 3'd5;
	else 
		if (out == 3'd0)
			out <= 3'd5;
		else 
			out <= out - 3'd1;
end
endmodule

module fqDiv2(rst,clk,clk_div2);
input rst,clk;
output reg clk_div2;
wire not_clk_div2;
assign not_clk_div2 = ~clk_div2;
always@(posedge clk or posedge rst)
begin 
	if (rst) clk_div2 <= 1'b0;
	else clk_div2 <= not_clk_div2;
end
endmodule

module fqDiv6(rst,clk,clk_div6);
input rst,clk;
output reg clk_div6;
reg [2:0] out;
wire en;

assign en = (out == 3'd2);
always@(posedge clk)
begin
	if (rst) out <= 3'd0;
	else 
		if (en) out <=3'd0;
		else out <= out + 3'd1;
end

always@(posedge clk)
begin
	if (rst) out <= 1'b0;
	else 
		if (en) clk_div6 <= ~clk_div6;
end
endmodule 



