`include "define.v"

module beaten(
input CLK,
input ENABLE,
input wire [`ADC_WIDHT-1:0] IN_ADC,
output [`ADC_WIDHT-1:0] OUT_ADC,
input wire[`ADC_WIDHT-1:0] BEATEN_PIX_LEVEL

);

reg [`ADC_WIDHT-1:0]temp;
reg [`ADC_WIDHT-1:0]out; 

assign OUT_ADC=(ENABLE==1) ? temp : 14'b0;

always @(posedge CLK)
begin
	if (ENABLE==1)
	begin
		if (IN_ADC>BEATEN_PIX_LEVEL)
		begin
			temp<=IN_ADC;
		end
	end
	else 
	begin
		temp<=14'b0;
	end
		

end


endmodule
