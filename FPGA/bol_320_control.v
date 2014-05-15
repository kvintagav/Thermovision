`include "define.v"



module bol_320_control(

input wire CLK_10,
input wire CLK_6_6,

input wire RESET,
input wire GLOBAL_RESET,
input wire BL_ENABLE,
output  BL_SYT,
output  BL_SYP,
output  BL_SYL,
output BL_SIZE,

output  BUF_IN_EN,
output  WRITE_EN,
output reg BUFER_CHANGE,
output [9:0] CNT_ROW
);




reg [3:0]state=4'b0000;
reg [15:0]cnt=16'b0;
reg [9:0]cnt_row=10'b0;
reg [15:0] dalay_shift=15'b0;


wire datavalid;
wire clk_bol;
parameter S_IDLE=0;
parameter S_RESET_UP=1;
parameter S_PAUSE=2;
parameter S_ROW_UP=3;
parameter S_ROW_DOWN1=4;
parameter S_PIX_OUT=5;
parameter S_ROW_DOWN2=6;
parameter S_CHANGE_BUF=7;
parameter S_MEM_UP=8;


parameter RESET_BOL=320;
parameter RESET_LINE=47;
parameter PAUSE_PIX=20;
parameter PAUSE=15; 

assign BL_SYT=(state==S_RESET_UP)? 1'b1 : 1'b0; //в состоянии reset_up поднять пин SYT он же ресет болометра
assign BL_SYL=(state==S_ROW_UP)? 1'b1 : 1'b0; //в состоянии row_up поднять пин SYL он же ресет строки

assign datavalid=(state==S_PIX_OUT)? 1'b1 : 1'b0; //в состоянии pix_out поднять начать получать данные с болометра

assign datavalid_mem=((state==S_PIX_OUT)&&(cnt_row>0))? 1'b1 : 1'b0; //в состоянии pix_out поднять начать получать данные с болометра

assign clk_bol=datavalid & BL_ENABLE;
assign BL_SYP=CLK_6_6 & clk_bol;
assign WRITE_EN=((state==S_MEM_UP)&&(cnt_row>1)) ? 1'b1:1'b0;
assign CNT_ROW=(cnt_row>1) ? (cnt_row-2) :10'b0;  
assign BL_SIZE=1'b0;
always @(posedge CLK_10 or posedge RESET or posedge GLOBAL_RESET)
begin
	if (GLOBAL_RESET)
	begin
		state<=S_IDLE;
		cnt<=16'b0;
		cnt_row<=10'b0;
		BUFER_CHANGE<=1'b0;
	end

	else if (RESET)
	begin
		state<=S_RESET_UP;
		cnt<=16'b0;
		cnt_row<=10'b0;
		BUFER_CHANGE<=1'b0;
	end
	else
	begin
		case(state)
			
			S_RESET_UP:begin
				cnt<=cnt+1'b1;
				if (cnt==RESET_BOL)
				begin
					cnt<=16'b0;
					state<=S_PAUSE;
				end
			end
			S_PAUSE:begin
				cnt<=cnt+1'b1;
				if (cnt==PAUSE)
				begin
					cnt<=16'b0;
					state<=S_ROW_UP;
				end
			end
			S_ROW_UP:begin  //выдать высокий уровень на тактирование ряда
				cnt<=cnt+1'b1;
				if (cnt==RESET_LINE)
				begin
					cnt<=16'b0;
					state<=S_ROW_DOWN1;
				end
			end
			S_ROW_DOWN1:begin  //выдать низкий уровень на тактирование ряда
				cnt<=cnt+1'b1;
				if (cnt==PAUSE)
				begin
					cnt<=16'b0;
					state<=S_PIX_OUT;
				end
			end
			S_PIX_OUT:begin  //выдать высокий уровень на тактирование пикселей
				cnt<=cnt+1'b1;
				if (cnt==`PIX_IN_ROW_CLK)
				begin
					cnt<=16'b0;
					state<=S_ROW_DOWN2;
				end
			end
			S_ROW_DOWN2:begin  //выдать низкий уровень на тактирование ряда
				cnt<=cnt+1'b1;
				if (cnt==PAUSE-2)
				begin
					cnt<=16'b0;
					state<=S_CHANGE_BUF;
				end
			end
			S_CHANGE_BUF:begin  //поменять буфер
				BUFER_CHANGE<=!BUFER_CHANGE;
				state<=S_MEM_UP;
				cnt_row<=cnt_row+1'b1;
			end
			S_MEM_UP:begin  //записать буфер в память 
				if(cnt_row<=`ROW_IN_FRAME) state<=S_ROW_UP;
				else state<=S_IDLE;
				
			end
			default:state<=S_IDLE;
			
		endcase	
	end
end

always @(posedge CLK_6_6)
begin
	dalay_shift <= {dalay_shift[14:0], datavalid_mem};
end

assign BUF_IN_EN=dalay_shift[`DELAY_DATAVALID];


endmodule


