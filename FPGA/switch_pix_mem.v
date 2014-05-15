
`include "define.v"

module switch_pix_mem(
input wire CLK,
input wire [`ADC_WIDHT-1:0]CAN_IN1,
input wire [`ADC_WIDHT-1:0]CAN_IN2,
output [31:0]DATA_OUT,

input wire TYPE_BAL

);

assign DATA_OUT[`ADC_WIDHT-1:0]=CAN_IN1;
assign DATA_OUT[`ADC_WIDHT+15:16]=TYPE_BAL ? CAN_IN2 : 14'b00000000000000 ;
assign DATA_OUT[14]=0;
assign DATA_OUT[15]=0;
assign DATA_OUT[30]=0;
assign DATA_OUT[31]=0;

endmodule
