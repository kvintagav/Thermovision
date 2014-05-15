module dev2_delay(
input wire CLK_IN,
output CLK_OUT
);

reg CLK=0;
assign CLK_OUT=CLK;

always @(negedge CLK_IN)
begin
	CLK=!CLK;
end 
endmodule
