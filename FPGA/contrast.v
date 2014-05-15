`include "define.v"

module contrast(

input wire CLK10,
input wire CLK100,

input wire RESET,
input wire RESET_FRAME,
input wire ENABLE,


input wire    [`MODE_MAX:0] MODE_FPGA,
input wire [`ADC_WIDHT-1:0]DATA_IN,
output [`ADC_WIDHT-1:0] MIN,
output [`ADC_WIDHT-1:0] MAX,


output [7:0] MULT_CONTRAST

);

reg [`ADC_WIDHT-1:0] min_out;
reg [`ADC_WIDHT-1:0] max_out;

reg [`ADC_WIDHT-1:0] min=14'b1111_1111_1111_11;
reg [`ADC_WIDHT-1:0] max=14'b0000_0000_0000_00;

assign MIN=min_out;
assign MAX=max_out;

reg [`MULT_WIDHT-1:0] mult;
reg [`MULT_WIDHT-1:0] shift;

reg  [`ADC_WIDHT-1:0] razn;

reg [19:0] average; //summ of teh difference

reg [3:0]state;

parameter idle_s =0;
parameter count_s =1;

reg [7:0]mult_contrast;//multiplication for clntrast
reg [7:0]mult_rezult_contrast;//rezult multiplication for clntrast

assign MULT_CONTRAST=mult_rezult_contrast;

wire enable;
reg [19:0]enable_shift;
/*Shift value*/
always @(posedge CLK100)
begin
	enable_shift={enable_shift[19:0],ENABLE};
end
assign enable=enable_shift[5];

/*Calculation minimalan and maximal value*/
always @ (posedge CLK100 or posedge RESET or posedge RESET_FRAME)
begin
	if (RESET)
	begin
		 min=14'b1111_1111_1111_11;
		 max=14'b0000_0000_0000_00;
	end
	else if (RESET_FRAME)
	begin
		min_out<=min;
		max_out<=max;
		razn<=max-min;
		min<=14'b1111_1111_1111_11;
		max<=14'b0000_0000_0000_00;
		
	end
	else
	begin
		if (enable==1)
		begin
			if (DATA_IN>max) 
			begin
				max<=DATA_IN;
			end
			if (DATA_IN<min) 
			begin
				min<=DATA_IN;
			end
		end
		
	end
end
/*multiplication factor for the calculation of*/
always @ (posedge CLK100 or posedge RESET or posedge RESET_FRAME)
begin
	if (RESET)
	begin
		state<=idle_s;
		mult_rezult_contrast<=8'b0;
		mult_contrast<=8'b0;
	end
	else if (RESET_FRAME)
	begin
		state<=count_s;
		average<=20'b0;
	end
	else
	begin
		case(state)
			idle_s:begin
			
			end
			count_s:begin
				
				if(average<`MAX_AVERAGE)
				begin
					mult_contrast<=mult_contrast+1'b1;
					average<=average+razn;
				end
				else
				begin
					mult_rezult_contrast<=mult_contrast;
					state<=idle_s;
				end
			end
			default:begin
				state<=idle_s;
			end
		endcase	
		
	end
end



endmodule

