module hello;

initial

begin
$display("hello word");
#10000;
$display("Hi!");
#10000;
$finish;

end 

endmodule
