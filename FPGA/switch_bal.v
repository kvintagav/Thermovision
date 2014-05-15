module switch_bal(
input wire TYPE,

output BL_OUT1,
output BL_OUT2,
output BL_OUT3,
output BL_OUT4,

input BL_IN1,
input BL_IN2,
input BL_IN3,

input wire BL_MC,
input wire BL_RESET,
input wire BL_INT,
input wire BL_SERDATA,

output BL_DATAVALID,
output BL_LINE1,
output BL_ERROR,

input wire BL_SYT,
input wire BL_SYP,
input wire BL_SYL,
input wire BL_SIZE

);

assign BL_DATAVALID=BL_IN1;
assign BL_LINE1=BL_IN2;
assign BL_ERROR=BL_IN3;
assign BL_OUT1=(TYPE==1) ? BL_MC      : BL_SYT;
assign BL_OUT2=(TYPE==1) ? BL_RESET   : BL_SYP;
assign BL_OUT3=(TYPE==1) ? BL_INT     : BL_SYL;
assign BL_OUT4=(TYPE==1) ? BL_SERDATA : BL_SIZE;





endmodule
