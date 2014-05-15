`include "define.v"
module RGB(



input wire [`ADC_WIDHT-1:0] DATA_IN,

output  [`VGA_WIDHT-1:0] RED,
output  [`VGA_WIDHT-1:0] GREEN,
output  [`VGA_WIDHT-1:0] BLUE,

input wire [`MODE_MAX:0] MODE

);
/*
reg [19:0] R=20'b0;
reg [19:0] G=20'b0;
reg [19:0] B=20'b0;

always 
begin
	if(MODE[`MODE_RGB]==1)
	begin
		
	end
	else
	begin
	  R [`VGA_WIDHT-1:0]<=DATA_IN[`ADC_WIDHT-1:0];
	  G [`VGA_WIDHT-1:0] <=DATA_IN[`ADC_WIDHT-1:0];
	  B [`VGA_WIDHT-1:0] <=DATA_IN[`ADC_WIDHT-1:0];

	end
end 


assign RED[`VGA_WIDHT-1:0]=R[
assign BLUE[`VGA_WIDHT-1:0]=B[
assign GREEN[`VGA_WIDHT-1:0]=G[
*/

assign RED[`VGA_WIDHT-1:0]=  6'b111111;
assign BLUE[`VGA_WIDHT-1:0]= 6'b000000;
assign GREEN[`VGA_WIDHT-1:0]=6'b000000;
/*
assign RED[`VGA_WIDHT-1:0]=DATA_IN[`ADC_WIDHT-1:`ADC_WIDHT-`VGA_WIDHT];
assign BLUE[`VGA_WIDHT-1:0]=DATA_IN[`ADC_WIDHT-1:`ADC_WIDHT-`VGA_WIDHT];
assign GREEN[`VGA_WIDHT-1:0]=DATA_IN[`ADC_WIDHT-1:`ADC_WIDHT-`VGA_WIDHT];
*/
endmodule
