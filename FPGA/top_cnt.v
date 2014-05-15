`include "define.v"

module top_cnt(
input wire CLK,
input wire RESET,
input wire ENABLE,
output [9:0]HORIZONTAL,
output [9:0]VERTICAL,
output RESET_BOLOMETER,
output  CHANGE,
output INT_MK,
input wire [31:0]MODE
);

reg [9:0] horizontal=10'b0;
reg [9:0] vertical=10'b0;
reg reset_bol=1'b0;
reg change=1'b0;
reg int_mk;

assign RESET_BOLOMETER=reset_bol;
assign HORIZONTAL=horizontal;
assign VERTICAL=vertical;
assign CHANGE=change;
assign INT_MK= (MODE[15:8]==`MODE_MATH_PED) ? 1'b0 : int_mk;

always @(posedge CLK or posedge RESET)
begin
	if (RESET)
	begin
		horizontal<=10'b0;
		vertical<=10'b0;
		change<=1'b0;
		int_mk<=1'b0;
	end
	else 
	begin
		if  (horizontal < ( `HOR_MAX- 1))
		begin
			
			horizontal <= horizontal + 1'b1;
			reset_bol<=1'b0;
			int_mk<=1'b0;
		end
		else
		begin
			horizontal<=10'b0;
			change<=~change;
			if (vertical< ( `VERT_MAX- 1))
			begin
				vertical <= vertical + 1'b1;
			end
			else 
			begin
				vertical<=10'b0;
				reset_bol<=1'b1;
				int_mk<=1'b1;
				
			end
		end
	end
	
end
endmodule
