/*
`timescale 1ns/100ps

module CSA_3var_4b_test1;
//input
reg [3:0] a,b,c;
//output
wire [5:0] sum;

CSA_3var_4b csa1(.a(a),
								.b(b),
								.c(c),
								.sum(sum));
//輸入信號設定
initial
begin
#0 a=4'd7;  b=4'd2;  c=4'd9;
#10 a=4'd11; b=4'd3;  c=4'd15;
#10 a=4'd6;  b=4'd10; c=4'd13;
#10 a=4'd11; b=4'd5;  c=4'd8;
//#10 $stop;
#10 $finish;
end
//輸出結果顯示
initial
$monitor("a=%d, b=%d, c=%d, sum=%d",a,b,c,sum);
//監控訊號並顯示在螢幕上
//被監控的訊號有變化
initial
begin
   $dumpfile("adder_tb.vcd");
   $dumpvars(0,CSA_3var_4b_test1);
end
endmodule
*/

`include "define.v"
`timescale 1ns/100ps

module max_3var_test1;
//input
reg [`WIDTH-1:0] a,b,c;
//output
wire [`WIDTH-1:0] out;
max_3var max1(.a(a), 
							.b(b), 
							.c(c), 
							.out(out));
initial
begin: input_set_blk
integer i;	//迴圈次數
integer seed1;	//隨機種子1
integer seed2;	//隨機種子2
integer seed3;	//隨機種子3
seed1 = 1;	seed2 = 2;	seed3 = 3;	
for (i = 0; i<100; i = i+1)
begin
a = $random(seed1);
b = $random(seed2);
c = $random(seed3);
#10 $display($time,"a =%d, b=%d, c=%d, out=%d\n",
							a,b,c,out);
end	
#10 $finish;
end

endmodule
