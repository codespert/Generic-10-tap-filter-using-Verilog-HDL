

module TB_Generic  ();

	wire [17:0]out;
    reg [3:0]in;
    reg clk,reset;
		// Instantiate the Unit Under Test (UUT)
	Generic_TDS_Main  uut (
		.out(out), 
		.in(in), 
		.clk(clk), 
		.reset(reset)
	);

	initial
	begin
	clk=1'b0;
	reset=1'b1;
	end
	always
	#5 clk=~clk;
	
	initial 
	begin
	#5 reset=1'b0;in=4'd10; $display($time," output=%d ",out);

		
	end
endmodule

