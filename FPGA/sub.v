`include "define.v"

module sub(

input wire    [`MODE_MAX:0] MODE_FPGA,

input wire [`ADC_WIDHT-1:0]DATA_IN,

output  [`ADC_WIDHT-1:0]DATA_OUT,
input wire [`ADC_WIDHT-1:0] PEDESTAL




);


wire [20:0] DATA_CHANGE;
assign DATA_CHANGE=(DATA_IN-PEDESTAL);
 
assign DATA_OUT=(MODE_FPGA[`MODE_CONTR]==1) ? DATA_CHANGE[13:0] : DATA_IN;

endmodule

