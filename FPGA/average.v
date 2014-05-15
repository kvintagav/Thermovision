`include "define.v"
//блок вычисления среднего значения всего кадра в педестале
module average(
input wire CLK,
input wire RESET,
input wire TWO_RESET,

input wire [31:0]MODE,
input wire CNT_ENABLE,
input wire RESULT_OUT,
input wire [`ADC_WIDHT-1:0]ADC_IN1,
input wire [`ADC_WIDHT-1:0]ADC_IN2, 


output  [`ADC_WIDHT-1:0]COUNT_OUT,
output  [`ADC_WIDHT-1:0]CONTR_SUM,


output  [`SUMMER-1:0]SUM1,
output  [`SUMMER-1:0]SUM2





);

assign COUNT_OUT=count_out;
assign CONTR_SUM=contr_sum;
reg [31:0]counter;
reg [31:0]bufer;
reg [13:0]count_out;
reg [13:0]contr_sum;
reg [13:0]adc_in1;
reg [13:0]adc_in2;

//summ from 1 and 2 channels
reg [`SUMMER-1:0]sum1;
reg [`SUMMER-1:0]sum2;

assign SUM1=sum1;
assign SUM2=sum2;

//блок суммирование всего кадра 
always @(negedge CLK)
begin
	adc_in1<=ADC_IN1;
	adc_in2<=ADC_IN2;

end
always @(posedge RESET or posedge TWO_RESET or posedge CLK)
begin
	if (RESET)
	begin
	
		
		//if (MODE[`MODE_PED]==1)counter<=32'b0;
		//bufer<=counter;
		
		sum1<=32'b0;
		sum2<=32'b0;
		
		contr_sum<=counter[13:0];
		if (MODE[`MODE_PED]==1)count_out<=counter>>18;
		else count_out<=14'b0;
		
	end
	else if(TWO_RESET)
	begin
		counter<=32'b0;
	end
	else
	begin
	if (CNT_ENABLE==1 )
		begin
			sum1<=sum1+adc_in1;
			sum2<=sum2+adc_in2;
			
		end
	
	

	
	if ((CNT_ENABLE==1 )&& (MODE[15:8]==`MODE_SAVE_PED))
		begin
			counter<=counter+adc_in1+adc_in2;
		end
	
	end


end

//блок определения среднего по всему кадру
/*
parameter [9:0]state;
parameter conv1=0;
always (posedge RESET or posedge CLK)
begin
	if (RESET)
	begin
	end
		cont_out<=bufer;
	else 


end
*/

endmodule

