`include "define.v"

module switch_mem_vga(

input wire  [`MODE_MAX:0] MODE,
input wire CLK25,
input wire CLK100,

output CLK_BUF,

input wire [`ADC_WIDHT-1:0]ADC_INPUT,



output [`ADC_WIDHT-1:0]ADC_VGA,

output [`ADC_WIDHT-1:0]ADC_MEM,

input wire BUFER_EN_VGA,
input wire BUFER_EN_MEM,

output BUFER_IN_EN,

input wire [`ADC_WIDHT-1:0] ADC_BUFER_OUT

);


assign CLK_BUF=(MODE[`MODE_MEMORY_EN]==1) ? CLK100 : CLK25;

assign BUFER_IN_EN=(MODE[`MODE_MEMORY_EN]==1) ? BUFER_EN_MEM : BUFER_EN_VGA;

assign ADC_MEM=(MODE[`MODE_MEMORY_EN]==1) ? ADC_INPUT : 14'b0;
assign ADC_VGA=(MODE[`MODE_MEMORY_EN]==1) ? ADC_BUFER_OUT : ADC_INPUT ;



endmodule

