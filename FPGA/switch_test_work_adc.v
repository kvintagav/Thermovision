`include "define.v"

module switch_test_work_adc(

input wire [`ADC_WIDHT-1:0] ADC_OUT1_BOL,
input wire [`ADC_WIDHT-1:0] ADC_OUT2_BOL,

output [`ADC_WIDHT-1:0] ADC_OUT1,
output [`ADC_WIDHT-1:0] ADC_OUT2,


input wire TEST,

input wire [`ADC_WIDHT-1:0] ADC_OUT1_TEST,
input wire [`ADC_WIDHT-1:0] ADC_OUT2_TEST



);

assign ADC_OUT1=(TEST==1) ? ADC_OUT1_TEST:ADC_OUT1_BOL ;
assign ADC_OUT2=(TEST==1) ? ADC_OUT2_TEST:ADC_OUT2_BOL ;

endmodule

