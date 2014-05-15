
`include "define.v"

module switch_can(
input wire CLK,
input wire [`ADC_WIDHT-1:0]CAN_IN1,
input wire [`ADC_WIDHT-1:0]CAN_IN2,
output [`ADC_WIDHT-1:0]CAN_OUT

);

assign CAN_OUT= CLK ? CAN_IN1 :CAN_IN2;

endmodule
