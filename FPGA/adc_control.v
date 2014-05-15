/*
	Module ADC input 
	ADC - 9252
*/
`include "define.v"


module adc_control(

input wire CLK,
input wire ADC_ENABLE,
input wire DCO,
input wire FCO,



input wire ADC_IN1,
input wire ADC_IN2,
output  reg[`ADC_WIDHT-1:0]ADC_OUT1,
output  reg[`ADC_WIDHT-1:0]ADC_OUT2,

output ADC_CLK
);

reg [6:0] adc_reg1;
reg [6:0] adc_reg2;

reg [6:0] adc_reg3;
reg [6:0] adc_reg4;

wire [6:0]adc_wire1;
wire [6:0]adc_wire2;
wire [6:0]adc_wire3;
wire [6:0]adc_wire4;

//MSB first 

always @ (posedge FCO)
begin
   ADC_OUT1[13:0]<={adc_wire3[6],adc_wire1[6],adc_wire3[5],adc_wire1[5],adc_wire3[4],adc_wire1[4],adc_wire3[3],adc_wire1[3],adc_wire3[2],adc_wire1[2],adc_wire3[1],adc_wire1[1],adc_wire3[0],adc_wire1[0]};
	ADC_OUT2[13:0]<={adc_wire4[6],adc_wire2[6],adc_wire4[5],adc_wire2[5],adc_wire4[4],adc_wire2[4],adc_wire4[3],adc_wire2[3],adc_wire4[2],adc_wire2[2],adc_wire4[1],adc_wire2[1],adc_wire4[0],adc_wire2[0]};

end

always @ (negedge DCO)
begin
	adc_reg1[6:0]<={adc_reg1[5:0],ADC_IN1};
	adc_reg2[6:0]<={adc_reg2[5:0],ADC_IN2};

end 

always @ (posedge DCO)
begin
	adc_reg3[6:0]<={adc_reg3[5:0],ADC_IN1};
	adc_reg4[6:0]<={adc_reg4[5:0],ADC_IN2};


end 

assign adc_wire1=adc_reg1;
assign adc_wire2=adc_reg2;
assign adc_wire3=adc_reg3;
assign adc_wire4=adc_reg4;



assign ADC_CLK=CLK & ADC_ENABLE;

endmodule
