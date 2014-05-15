`include "define.v"

module rgb_enable(

input wire enable,
input wire   [`MODE_MAX:0] MODE,

input wire [`ADC_WIDHT-1:0] DATA_IN,


output  [`VGA_WIDHT-1:0] RED,
output  [`VGA_WIDHT-1:0] GREEN,
output  [`VGA_WIDHT-1:0] BLUE,

input wire  [`VGA_WIDHT-1:0] RED_IN,
input wire  [`VGA_WIDHT-1:0] GREEN_IN,
input wire  [`VGA_WIDHT-1:0] BLUE_IN

);

wire [`VGA_WIDHT-1:0] red;
wire [`VGA_WIDHT-1:0] green;
wire [`VGA_WIDHT-1:0] blue;

assign red=(MODE[`MODE_RGB]==1) ? RED_IN : DATA_IN[`ADC_WIDHT-1:`ADC_WIDHT-`VGA_WIDHT+1] ;
assign green=(MODE[`MODE_RGB]==1) ? GREEN_IN : DATA_IN[`ADC_WIDHT-1:`ADC_WIDHT-`VGA_WIDHT+1] ;
assign blue=(MODE[`MODE_RGB]==1) ? BLUE_IN : DATA_IN[`ADC_WIDHT-1:`ADC_WIDHT-`VGA_WIDHT+1] ;

assign RED=(enable==1) ? red : 6'b000000;
assign GREEN=(enable==1) ? green : 6'b000000;
assign BLUE=(enable==1) ? blue : 6'b000000;


endmodule

