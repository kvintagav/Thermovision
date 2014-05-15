`include "define.v"
module const_diff_chan(

input CLK,
input [`SUMMER-1:0]SUM1,
input [`SUMMER-1:0]SUM2,

output reg [12:0] CONST_CHAN1,
output reg [12:0] CONST_CHAN2


);

always @(posedge CLK)
begin
	CONST_CHAN1=`CONST_DIFF_CHAN1;
	CONST_CHAN2=`CONST_DIFF_CHAN2;
end


endmodule
