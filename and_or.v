module and_or_gate(in1,in2,in3,in4,out);
input in1,in2,in3,in4;
output out;
wire w1,w2;
and a1(w1,in1,in2);
and a2(w2,in3,in4);
or o1(out,w1,w2);
endmodule

module and_or_dataflow(in1,in2,in3,in4,out);
input in1,in2,in3,in4;
output out;
assign out = (in1&in2)|(in3&in4);
endmodule

module and_or_behavior(in1,in2,in3,in4,out);
input in1,in2,in3,in4;
output out;
reg out;
always@(in1 or in2 or in3 or in4)
begin
out = (in1&in2)|(in3&in4);
end
endmodule

module mix_ex(a,b,c,F);
input a,b,c;
output F;
wire w0;
reg w1;
assign w0  = a&b;
or or3(F,w0,w1);
always@(a or c)
begin
w1 = a&c;
end
endmodule
