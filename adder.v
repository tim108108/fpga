
module Full_Adder(a,b,c_in,sum,c_out);

input a,b,c_in;
output sum,c_out;

wire w1,w2,w3;
xor x1(w1,a,b),x2(sum,w1,c_in);
and a1(w2,a,b),a2(w3,w1,c_in);
or o1(c_out,w2,w3);

endmodule

module Ripple_Carry_Adder(a,b,c_in,sum,c_out);

input [3:0] a,b;
input c_in;
output [3:0] sum;
output c_out;

Full_Adder FA0(a[0],b[0],c_in,sum[0],w0);
Full_Adder FA1(a[1],b[1],w0,sum[1],w1);
Full_Adder FA2(a[2],b[2],w1,sum[2],w2);
Full_Adder FA3(	.a(a[3]),
		.b(b[3]),
		.c_in(w2),
		.sum(sum[3]),
		.c_out(c_out));

endmodule

module CSA_3var_4b(a,b,c,sum);
input [3:0] a,b,c;
output [5:0] sum;
reg [3:0] s,cs;
wire [2:0] co;
wire [5:0] sum;
always@(a or b or c)
/*
begin
{cs[0],s[0]} = a[0]+b[0]+c[0];
{cs[1],s[1]} = a[1]+b[1]+c[1];
{cs[2],s[2]} = a[2]+b[2]+c[2];
{cs[3],s[3]} = a[3]+b[3]+c[3];
*/
begin:csa_blk	//區塊標籤
integer i;	//區域變數
for(i=0;i<4;i=i+1)
{cs[i],s[i]}=a[i]+b[i]+c[i];

end
assign sum[0] = s[0];
assign {co[0],sum[1]} = cs[0]+s[1];
assign {co[1],sum[2]} = cs[1]+s[2]+co[0];
assign {co[2],sum[3]} = cs[2]+s[3]+co[1];
assign {sum[5],sum[4]} = cs[4]+co[2];
endmodule

module mux_2to1(a,b,sel,out);
input a,b,sel;
output out;

reg out;

always@(a or b or sel)
begin 
  if(sel)
    out = a;
  else 
    out = b;
end
/*
always@(a or b or sel)
begin
  out = b;
  if(sel)
    out = a;
end
*/
/*
wire out;
assign out = sel ? a : b;
*/
endmodule

module mux_4to1(a,b,c,d,s0,s1,out);
input a,b,c,d;
input s0,s1;
output out;

reg out;

always@(a or b or c or d or s0 or s1)
begin
  case({s0,s1})
    2'b00:out = a;
    2'b01:out = b;
    2'b10:out = c;
    2'b11:out = d;
  endcase
end
endmodule

module mux_2to1_multi_bits(a,b,sel,out);
parameter width = 4;
input [width-1:0] a,b;
input sel;
output [width-1:0] out;

assign out = sel?a:b;

endmodule


module comparator(a, b, gt, it, eq);
input [3:0] a, b;
output gt, it, eq;
reg gt, it, eq;

always@(a or b)
begin 
	gt = (a>b);
	it = (a<b);
	eq = (a == b);
end

/*
assign gt = (a>b);
assign it = (a<b);
assign eq = (a == b);
*/
endmodule

module max_3var(a, b, c, out);
parameter width = 3;
input [width-1:0] a,b,c;
output [width-1:0] out;
reg [width-1:0] out;
reg [width-1:0] temp;

always@(a or b or c)
begin
if (a>b)    temp = a;
else        temp = b;

if (temp>c) out = temp;
else				out = c;
end 
endmodule
