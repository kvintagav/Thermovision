
`include "define.v"

module reset_all(
input CLK_IN,
output reg RESET,
output reg RESET_MEM
);
reg [19:0] cnt=20'b0;



always @(posedge CLK_IN )
begin
	if (cnt==0) RESET_MEM<=1'b1;
	else if (cnt==1) RESET_MEM<=1'b0;
	
	else if (cnt==3500) RESET<=1'b1;
	else if (cnt==3505) RESET<=1'b0;
	if (cnt<3510)cnt<=cnt+1'b1;
end




endmodule
