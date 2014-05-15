`include "define.v"
module switch(

input wire [`ADC_WIDHT-1:0]CAN_IN1,
input wire [`ADC_WIDHT-1:0]CAN_IN2,

output  [`ADC_WIDHT-1:0] DATA_OUT,


input wire IN_BUF_EN,

input wire NUMBER_CHAN, //number read channel in this time

input wire NUMB_CHAN, //count channel all from bolometer
output IN_BUF_EN_CAN1,
output IN_BUF_EN_CAN2

);

wire [`ADC_WIDHT-1:0] DATA;

assign  IN_BUF_EN_CAN1=(NUMBER_CHAN==0) ? IN_BUF_EN: 1'b0;

assign  IN_BUF_EN_CAN2=(NUMBER_CHAN==1) ? IN_BUF_EN: 1'b0;

assign  DATA=(NUMBER_CHAN==0) ? CAN_IN1: CAN_IN2;

assign  DATA_OUT=(NUMB_CHAN==0) ? CAN_IN1: DATA;


endmodule

