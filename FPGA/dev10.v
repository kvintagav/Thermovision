module dev10(
input CLK_IN,
output CLK_OUT


);

reg [0:5] cnt =6'b0; 
reg mean=1'b0;

parameter CLK_5=4;

always @(posedge CLK_IN)
begin
	cnt<=cnt+1'b1;
	if (cnt==CLK_5)
	begin
		mean<=!mean;
		cnt<=6'b0;
	end	
end	

assign CLK_OUT=mean;


endmodule
