module brightening(
input wire  [18:0] INPUT,
input wire CLK,
output [13:0] OUTPUT

);

reg [13:0] output_value;

assign OUTPUT=output_value;

always @(posedge CLK)
begin
	if ((INPUT[18]==1) || (INPUT[17]==1)||(INPUT[16]==1)||(INPUT[15]==1)||(INPUT[14]==1))
	output_value=INPUT[13:0];
	else
	output_value=INPUT[13:0];
end

endmodule

