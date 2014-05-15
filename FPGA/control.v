/*

Модуль управеления тепловизором
Является промежуточным звеном между микроконтроллером и всей остальной ПЛИС
Задает режим работы, уставки и настройки
Содержит телеметрическую информацию

написал Казаков Андрей.

*/
`include "define.v"

module control(
input wire CLK,
output  reg TYPE_BAL,
output reg [9:0]INT_TIME,
input wire RESET,

output   CNT_ENABLE,
output   OUT_ENABLE,
output   RESET_MEM,
output   RESET_SPI,

output  BL_ENABLE,
output  ADC_ENABLE,

input wire [`SPI_WIDHT-1:0] SPI_DATA,
input wire BYTE_SPI_READY,

output reg NUMB_CHAN,

output  [`MODE_MAX:0] MODE_FPGA,

output [19:0]ALL_CNT,

output  [`ADC_WIDHT-1:0]SUB_CONTRAST,
output  [`MULT_WIDHT-1:0]MULT_CONTRAST,

output  TEST,
output  MEM_ENABLE,

output [`SPI_WIDHT-1:0] SPI_DATA_OUT,

output [`ADC_WIDHT-1:0] BEATEN_PIX_LEVEL,

input wire RESET_FROM_OUT
);


//reg [`SPI_WIDHT-1:0]spi_data_out;
reg [19:0] cnt=20'b0;

reg [`SPI_WIDHT-1:0] INPUT_REG [`SPI_COUNT:0];
reg [`SPI_WIDHT-1:0] OUTPUT_REG [`SPI_COUNT:0];
reg [`MODE_MAX:0] mode=32'b0000_0000_0000_0000_0000_0000_0000_0000; //регистр режима для промежуточной записи
reg [`MODE_MAX:0] mode_work=32'b0000_0000_0000_0000_0000_0000_0000_0000; //регист режима для рабочего режима
reg [`SPI_MAX_BYTE:0]cnt_spi;



reg [`ADC_WIDHT-1:0] beaten_pix_level;

assign BEATEN_PIX_LEVEL=beaten_pix_level;

wire CLK_CNT;

assign MODE_FPGA=mode_work; 
assign SPI_DATA_OUT=8'b0;
assign ALL_CNT=cnt;
assign CLK_CNT=CLK&CNT_ENABLE;

parameter TIME_SAVE_FRAME=670; 
parameter TIME_START_VGA=300;

parameter RECEIVE_CMD=0;
parameter RECEIVE_MODE=1;

parameter CMD_START= 'h10;
parameter CMD_STOP=  'h20;
parameter CMD_TEST=  'h30;
parameter CMD_SUB1 =  'h40;
parameter CMD_SUB2 =  'h41;
parameter CMD_MULT=  'h50;
parameter CMD_PED =  'h60;
parameter CMD_PED_SAVE =  'h61;
parameter CMD_RGB =  'h70;
parameter CMD_CONTR = 'h80;
parameter CMD_MODE1=  'h90;
parameter CMD_MODE2=  'h91;
parameter CMD_SAVE_PED=  'hA0;
parameter CMD_BEAT_PIX1=  'hB0;
parameter CMD_BEAT_PIX2=  'hB1;
parameter CMD_BEATEN=  'hB2;


reg [7:0]spi_cmd;


reg reset_mem=0;
assign RESET_MEM=reset_mem;
reg reset_spi=0;
assign RESET_SPI=reset_spi;
reg mem_enable=0;
assign MEM_ENABLE=mem_enable;

reg test=0;

assign TEST=test;

reg bl_enable=0;
reg adc_enable=0;
reg cnt_enable=0;
reg out_enable=0;	

reg [`ADC_WIDHT-1:0]sub_contrast;
reg [`MULT_WIDHT-1:0]mult_contrast;

assign SUB_CONTRAST=sub_contrast;
assign MULT_CONTRAST=mult_contrast;

assign BL_ENABLE=bl_enable;
assign ADC_ENABLE=adc_enable&(!TEST);
assign CNT_ENABLE=cnt_enable;
assign OUT_ENABLE=out_enable;

reg command_save_ped;

//операции для записи после считывания каждого кадра
always @(posedge RESET or posedge RESET_FROM_OUT)
begin
	if (RESET)
	begin
		mode_work<={16'b00000000000_0_1_1_1_0,8'b00001101,8'b00000001};
	end
	else
	begin
		mode_work<=mode;
	end
	
end
//считать первую команду из SPI и запустить процесс дальнейшей обработки принимаемых команд
always @(  posedge BYTE_SPI_READY or posedge RESET)
begin
	if (RESET)
	begin
		mode<={16'b00000000000_0_1_1_1_0,8'b00001101,8'b00000001};	
		mult_contrast<=5'b0001;
		sub_contrast<=14'b00000000000000;
		beaten_pix_level<=14'b00_0001_1001_0000;

		test<=0;
		bl_enable=0;
		adc_enable=0;
		cnt_enable=0;
		out_enable=0;
	end

	else
	begin
		
		case(SPI_DATA[15:8])
			(CMD_START):begin
				bl_enable=1;
				adc_enable=1;
				cnt_enable=1;
				out_enable=1;
			end
			(CMD_STOP):begin
				bl_enable=0;
				adc_enable=0;
				cnt_enable=0;
				out_enable=0;
			end
			(CMD_RGB):begin
				mode[`MODE_RGB]<=SPI_DATA[0];
			end
			(CMD_PED):begin
				mode[`MODE_PED]<=SPI_DATA[0];
			end	
			(CMD_MODE1):begin
				mode[7:0]<=SPI_DATA[7:0];
			end
			(CMD_MODE2):begin
				mode[15:8]<=SPI_DATA[7:0];
			end
			(CMD_SUB1):begin
				sub_contrast[7:0]<=SPI_DATA[7:0];
			end
			(CMD_SUB2):begin
				sub_contrast[13:8]<=SPI_DATA[5:0];
			end
			(CMD_BEAT_PIX1):begin
				beaten_pix_level[7:0]<=SPI_DATA[7:0];
			end
			(CMD_BEAT_PIX2):begin
				beaten_pix_level[13:8]<=SPI_DATA[5:0];
			end
			(CMD_BEATEN):begin
				mode[`MODE_BEAT]<=SPI_DATA[0];
			end
			(CMD_MULT):begin
				mult_contrast[`MULT_WIDHT-1:0]<=SPI_DATA[`MULT_WIDHT-1:0];
			end
		  (CMD_TEST):begin
				if (SPI_DATA[0]==1) test<=1;
				else test<=0;
			end
			default:begin
			end
		endcase
	
	end		
		
end

always @(posedge CLK_CNT or posedge RESET)
begin
	
	TYPE_BAL=`TYPE;
	INT_TIME= `TIME_INTEGRATION;  //time integretion
	NUMB_CHAN=1'b1;


end


endmodule
