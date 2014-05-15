`include "define.v"

module mix_uart(

input wire [`ADC_WIDHT-1:0]DATA_BUF,

output [15:0]VALUE

);

assign VALUE[15:0]={2'b00,DATA_BUF[`ADC_WIDHT-1:0]};
//assign VALUE[15:0]={16'b0011_0010_0011_0000};


endmodule
