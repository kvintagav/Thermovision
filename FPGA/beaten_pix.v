// algoritm beaten pix
`include "define.v"

module beaten_pix(

input CLK,
input CLK_ADC,
input wire    [`MODE_MAX:0] MODE_FPGA,
input wire ENABLE,

input wire [`ADC_WIDHT-1:0] IN_ADC1,
input wire [`ADC_WIDHT-1:0] IN_ADC2,

output [`ADC_WIDHT-1:0] OUT_ADC1,
output [`ADC_WIDHT-1:0] OUT_ADC2,

input wire[`ADC_WIDHT-1:0] BEATEN_PIX_LEVEL


);

reg [3:0] state;

parameter idle = 0;
parameter first = 1;
parameter second = 2;
parameter third = 3;
parameter fourth =4;

wire sign1;
wire sign2;

reg beat1;
reg beat2;

//assign input_wire1=input1;
//assign input_wire2=input2;

reg [13:0]out_adc1;
reg [13:0]out_adc2;

reg [13:0] input1;
reg [13:0] input2;

reg [13:0] input_with1;
reg [13:0] input_with2;

//wire [13:0] input_wire1;
//wire [13:0] input_wire2;

reg [13:0] res_sub1;
reg [13:0] res_sub2;

reg [13:0] prev_value;

assign OUT_ADC1=(MODE_FPGA[`MODE_BEAT]==1) ? out_adc1 : input_with1 ;
assign OUT_ADC2=(MODE_FPGA[`MODE_BEAT]==1) ? out_adc2 : input_with2 ;

assign sign1=(IN_ADC1>prev_value) ? 1'b1 : 1'b0 ;
assign sign2=(IN_ADC2>prev_value) ? 1'b1 : 1'b0 ;


//value adc for mode without beaten_pix
always @ (posedge CLK_ADC)
begin
	input_with1<=IN_ADC1;
	input_with2<=IN_ADC2;
end


always @(posedge CLK)
begin
	if (ENABLE==0)		
	begin
		prev_value<=IN_ADC2;
		out_adc1<=IN_ADC1;
		out_adc2<=IN_ADC2;
		state<=idle;
	end
	else
	begin
		case(state)
			 idle:begin
					if (CLK_ADC==0)
					begin
						
						input1<=IN_ADC1;
						input2<=IN_ADC2;
						state<=first;
					end
					else state<=idle;
					
			 end
			 first:begin
				if (sign1==1) res_sub1= IN_ADC1-prev_value;
				else res_sub1= prev_value-IN_ADC1;
				if (sign2==1) res_sub2= IN_ADC2-prev_value;
				else res_sub2= prev_value-IN_ADC2;
				state<=second;
			 end
			 second:begin
				if (res_sub1<BEATEN_PIX_LEVEL) 
				begin
					out_adc1<=input1;
					prev_value<=input1;
				end
				else 
				begin
					out_adc1<=prev_value;
				
				end
				state<=third;
			 end
			 third:begin
				if (res_sub2<BEATEN_PIX_LEVEL) 
				begin
					out_adc2<=input2;
					prev_value<=input2;
				end
				else 
				begin
					out_adc2<=prev_value;
				
				end
				state<=idle;
			 end
			 
			 default:begin
				state<=idle;
			 end
		endcase
	end
end
endmodule
