module mult #(parameter n=4'd4) (out,a,b);
output [(2*n):0]out;
input [n-1:0]a,b;
assign out = a*b;
endmodule

module RA #(parameter n=4'd4,t=4'd1) (sum,a,b,cin);
output [(n+t+4)-1:0]sum;
input [(n+t+4)-2:0]b;
input [(2*n)-1:0]a;
input cin;
wire c;
assign {c,sum}=a+b+cin;
endmodule


module DFF #(parameter n=4'd4,t=4'd1) (q,d,clk,reset);
output reg[(n+t+4)-1:0]q; 
input [(n+t+4)-1:0]d;
input clk,reset;
always @ (posedge clk)
begin
if(reset==1)
begin
q <= 0;
end
else
begin
q<=d;
end
end
endmodule

module Tap_2 #(parameter n=4'd4,t=4'd2,h0=4'd10) (out,in1,in2,clk,reset);
output [(n+t+4)-1:0]out;
input [(n+t+4)-2:0]in2;
input [(2*n)-1:0]in1;
input clk,reset;
wire [(n+t+4)-1:0]w2;
RA #(.n(n),.t(t)) F1(w2,in1,in2,1'b0);
DFF #(.n(n),.t(t)) d1(out,w2,clk,reset);

endmodule

module Tap_1 #(parameter n=4'd4,t=4'd1,h0=4'd10) (out,in,clk,reset);
//parameter n=4'd4,h0=4'd10,h1=4'd11,t=1;
output [(n+t+4)-1:0]out;
input [n-1:0]in;
input clk,reset;
wire [(n+t+4)-1:0]w1;
mult #(.n(n)) m1(w1,in,h0);
DFF #(.n(n),.t(t)) d1(out,w1,clk,reset);
endmodule


module Generic_TDS_Main(out,in,clk,reset);

output [17:0]out;
input [3:0]in;
input clk,reset;
wire [17:0]w[17:0];
wire[7:0]c1;
mult #(.n(4)) m1(c1,in,4'd10);
Tap_1 #(.n(4'd4),.t(4'd1),.h0(4'd10)) t1(w[1],in,clk,reset);
assign out=w[10];
genvar i;
generate
for(i=2;i<=10;i=i+1) 
begin
Tap_2 #(.n(4'd4),.t(i),.h0(4'd10)) t2(w[i],c1,w[i-1],clk,reset);
end
endgenerate
endmodule
 
