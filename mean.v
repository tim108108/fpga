module mean(rst, clk, in, mean);
input rst, clk;
input [3:0] in;
output reg [3:0] mean;

reg [3:0] x0, x1, x2, x3;
wire [5:0] sum;
wire [3:0] m_tmp;

always@(posedge clk or posedge rst)
begin 
	if (rst) {x3,x2,x1,x0}<=16'd0;
	else
	begin
		x3<=x2;
		x2<=x1;
		x1<=x0;
		x0<=in;
	end
end
assign sum = (x0+x1)+(x2+x3);
assign m_tmp = sum >> 2;
//assign m_tmp = sum[5:2];

always@(posedge clk or posedge rst)
begin	
	if (rst) mean <= 4'd0;
	else mean <=m_tmp;
end
endmodule
