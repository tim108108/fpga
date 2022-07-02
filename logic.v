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

module SISO_4b(
input clk, rst,
input SI,
output SO);

reg [3:0] dff4b;
assign SO = dff4b[3];

always@(posedge clk or negedge rst)
begin 
	if (!rst) dff4b <=4'b0;
	else begin
		dff4b[3] <= dff4b[2];
		dff4b[2] <= dff4b[1];
		dff4b[1] <= dff4b[0];
		dff4b[0] <= SI;
		end
end
endmodule

module PISO_4b(
input clk,rst,
input load,
input [3:0] PI,
output SO);

reg [3:0] dff4b;
assign SO = dff4b[3];

always@(posedge clk or negedge rst)
begin:PISO_blk	//PISO_blk區塊為命名
	integer i;
	if (!rst)
		dff4b<=4'b0;
	else if (load)
			dff4b<=PI;
		else begin
			for (i=3;i>0;i=i-1)
				dff4b[i]<=dff4b[i-1];
			dff4b[0]<=1'b0;
			end
end
endmodule

module debounce (clk,bin,bout);
parameter CNT_W = 20;
input clk;
input bin;
output bout;
reg [CNT_W-1:0] cnt;
reg bin_syn0,bin_syn1,bin_int;

assign bout = ~cnt[CNT_W-1];	//MSB為1時達到上限
always@(posedge clk)	//synchron
begin
	bin_syn0 <= bin;
	bin_syn1 <= bin_syn0;
	bin_int <= bin_syn1;
end

always@(posedge clk)
begin
	if (bin_int) cnt <= {CNT_W{1'b0}};
	else if (!cnt[CNT_W-1])	//MSB未達上限
		cnt <= cnt + 1'b1;
end
endmodule

module up_cnt_pmtr
#(parameter WIDTH = 32)(
input clk,
input rst,
input en,
input clr,
output reg[WIDTH-1:0] cnt);

wire [WIDTH-1:0] zero = {(WIDTH){1'b0}};
always@(posedge clk or posedge rst)
begin
	if (rst) cnt <= zero;
	else if (en)
		begin 
			if (clr) cnt <= zero;
			else cnt <= cnt + 1'b1;
		end
end
endmodule

module PWM(
input clk,rst,
input [3:0] duty,
output reg pwm);

reg [2:0] cnt;
wire it;
assign it = ({1'b0,cnt}<duty);

always@(posedge clk or posedge rst)
begin
	if (rst) cnt = 3'd0;
//	else if (cnt == 3'd7)
//			cnt = 3'd0;
		else cnt = cnt + 1'd1;
end

always@(posedge clk or posedge rst)
begin
	if (rst) pwm = 1'b0;
	else pwm = it;
end

endmodule

`define WIDTH 32
`define OUT_REG

module mux_def(
`ifdef OUT_REG
input rst,
input clk,
`endif
input sel,
input [`WIDTH-1:0] a,b,
output reg [`WIDTH-1:0] out);

wire [`WIDTH-1:0] temp;
assign temp = sel?a:b;

`ifdef OUT_REG
always@(posedge clk or posedge rst)
begin
	if (rst) 
		out <= `WIDTH'd0;
	else
		out <= temp;
end
`else 
always@(temp)
begin
	out <= temp;
end
`endif

endmodule

