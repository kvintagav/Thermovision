module clk12_5(
input wire CLK_25,
output CLK_12_5
);

reg CLK=0;
assign CLK_12_5=CLK;

always @(posedge CLK_25)
begin
	CLK=!CLK;
end 
endmodule
