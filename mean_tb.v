`timescale 1ns/100ps

module mean_tb;

//input
reg rst, clk;
reg [3:0] in;

//output
wire [3:0] mean;

mean m1(.rst(rst),
				.clk(clk),
				.in(in),
				.mean(mean));

//input signal clk
initial #0 clk = 1'b0;
always #5 clk = ~clk;

//input signal rst,in

initial
begin
$dumpfile("mean_tb.vcd");
$dumpvars(0,mean_tb);
end

initial
begin:in_set_blk
	integer i;
	integer seed1;
	#0 rst = 1'b0;
		 in = 4'b0;
	#10 rst = 1'b1;
	#10 rst = 1'b0;
	seed1 = 1;
	for (i=0;i<100;i=i+1)
		begin 
		in = $random(seed1);
		#10 $display($time,"in=%d,mean=%d\n",in,mean);
				$display($time,"x0=%d,x1=%d,x2=%d,x3=%d\n",
											m1.x0,m1.x1,m1.x2,m1.x3);
				$display($time,"m_tmp=%d\n",m1.m_tmp);
		end
		#10 $finish; 
end
endmodule	
