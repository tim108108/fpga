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
begin
{cs[0],s[0]} = a[0]+b[0]+c[0];
{cs[1],s[1]} = a[1]+b[1]+c[1];
{cs[2],s[2]} = a[2]+b[2]+c[2];
{cs[3],s[3]} = a[3]+b[3]+c[3];
/*
begin:csa_blk	//區塊標籤
integer i;	//區域變數
for(i=0;i<4;i=i+1)
{cs[i],s[i]}=a[i]+b[i]+c[i];
*/
end
assign sum[0] = s[0];
assign {co[0],sum[1]} = cs[0]+s[1];
assign {co[1],sum[2]} = cs[1]+s[2]+co[0];
assign {co[2],sum[3]} = cs[2]+s[3]+co[1];
assign {sum[5],sum[4]} = cs[3]+co[2];
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
if (a>b) temp = a;
else     temp = b;

if (temp>c) out = temp;
else        out = c;
end 
endmodule

module decoder_2to4(in0,in1,w,x,y,z);
input in0,in1;
output w,x,y,z;
reg w,x,y,z;
always@(in0 or in1)
begin
	case({in1,in0})
		2'b00:{w,x,y,z}=4'b0001;
		2'b01:{w,x,y,z}=4'b0010;
		2'b10:{w,x,y,z}=4'b0100;
		2'b11:{w,x,y,z}=4'b1000;
	endcase
end

/*
always@(in0 or in1)
begin
	{w,x,y,z}=4'b0000;
	case({in1,in0})
		2'b00:z=1'b1;
		2'b01:y=1'b1;
		2'b10:x=1'b1;
		2'b11:w=1'b1;
	endcase
end
*/
endmodule

module en_encoder_3to6(en,in,out);
input en;
input [2:0] in;
output [5:0] out;
reg [5:0] out;
always@(en or in)
begin
	if(!en) out=6'b0;
	else case(in)
			3'd0:out=6'b000001;
			3'd1:out=6'b000010;
			3'd2:out=6'b000100;
			3'd3:out=6'b001000;
			3'd4:out=6'b010000;
			3'd5:out=6'b100000;
			default:out=6'b0;
	endcase
end
endmodule

module encoder_4to2(in0,in1,in2,in3,v,o1,o2);
input in0,in1,in2,in3;
output v;
output o1,o2;
reg v;
reg o1,o2;

always@(in0 or in1 or in2 or in3)
begin
	case({in3,in2,in1,in0})
		4'b0001:{v,o1,o2} = 3'b100;
		/*
		4'b0001:
			begin
				v = 1'b1;
				o1 = 1'b0;
				o2 = 1'b0;
			end
		*/
		4'b0010:{v,o1,o2} = 3'b101;
		4'b0100:{v,o1,o2} = 3'b110;
		4'b1000:{v,o1,o2} = 3'b111;
		default:{v,o1,o2} = 3'b000;
	endcase
end
/*
begin
	v = 1'b1;//內定值(初始值)
	case({in3,in2,in1,in0})
		4'b0001:{o1,o2} = 2'b00;
		4'b0010:{o1,o2} = 2'b01;
		4'b0100:{o1,o2} = 2'b10;
		4'b1000:{o1,o2} = 2'b11;
		default:{v,o1,o2} = 3'b000;
	endcase
end
*/
endmodule

module pri_encode_8ro3(in,v,out);
input [7:0] in;
output v;
output [2:0] out;
reg v;
reg [2:0] out;

always@(in)
begin
	case(in)
		8'b1xxxxxxx:{out,v} = 4'b0001;		
		8'b01xxxxxx:{out,v} = 4'b0011;
		8'b001xxxxx:{out,v} = 4'b0101;
		8'b0001xxxx:{out,v} = 4'b0111;
		8'b00001xxx:{out,v} = 4'b1001;
		8'b000001xx:{out,v} = 4'b1011;
		8'b0000001x:{out,v} = 4'b1101;
		8'b00000001:{out,v} = 4'b1111;
		default:{out,v} = 4'b0000;
	endcase
end
endmodule
