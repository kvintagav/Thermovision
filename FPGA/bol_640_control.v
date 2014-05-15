
`include "define.v"

module bol_640_control(

input wire CLK,
input wire RESET,
input wire [9:0]INT_TIME,

input wire BL_ENABLE,
output  BL_MC,
output reg BL_RESET,
output reg BL_INT,
output  BL_SERDATA, 
input wire BL_DATAVALID,
input wire BL_LINE1,
input wire BL_ERROR,

output  BUF_IN_EN,
output reg BUFER_IN_VALID,
output  COUNTER_ENABLE, 
output reg BUFER_CHANGE,
output [9:0] CNT_ROW
);

reg [11:0] cnt=12'b0;
reg [9:0] cnt_row=10'b0;
reg [9:0] row_write=10'b0;
reg [19:0] dalay_shift=20'b0;


wire bufer_in_en;
wire CLK_BOL;

parameter PIX_ROW=`PIX_IN_ROW/`NUMB_CHAN;

parameter DELAY_DATAVALID = 9; 

parameter PERIOD=`PIX_IN_ROW/`NUMB_CHAN+20;

/* Автомат управления сигналами болометра*/
always @(posedge CLK_BOL or posedge RESET )
begin
	if (RESET)
	begin
		cnt<=12'b0;
		cnt_row<=10'b0;
		row_write<=10'b0;
		BL_INT=0;
		BL_RESET=0;
	end 
	else
	begin
		if (cnt_row==0)
		begin
			if (cnt==0)	BL_RESET<=1;
			else if (cnt==1) BL_RESET<=0;
			else if (cnt==(3+PIX_ROW-INT_TIME)) BL_INT=1;
			else if (cnt==(3+PIX_ROW))
			begin 
				BL_INT=0;
				cnt_row<=cnt_row+1'b1;
				cnt=12'b0;
			end			
			cnt<=cnt+1'b1;
		
		end
		else
		begin
			
			if ((cnt==(1+PERIOD-INT_TIME))&&(cnt_row<(`ROW_IN_FRAME))) BL_INT=1;	
			else if (cnt==(PERIOD)) 
			begin 
				BL_INT=0;	
				cnt_row<=cnt_row+1'b1;
				
				cnt=12'b0;
				
			end
				if (cnt_row<(`ROW_IN_FRAME+1)) cnt<=cnt+1'b1;
			
			
		end
		
		if (cnt_row>=2) row_write<=cnt_row-2'b10;
	end
end

always @(negedge bufer_in_en or posedge RESET)
begin
	if (RESET) BUFER_CHANGE<=1'b0;
	else	BUFER_CHANGE<=!BUFER_CHANGE;
end 

always @(posedge CLK)
begin
	dalay_shift <= {dalay_shift[18:0], BL_DATAVALID};
end

reg [5:0] cnt_write ;//счетчик для записи данных в память
always @(negedge CLK)
begin
	if (BUF_IN_EN==0)
	begin
		if ((cnt_write==0)&&(cnt_row>=2)) BUFER_IN_VALID=1;
		else BUFER_IN_VALID=0;
			cnt_write<=cnt_write+1'b1;
		if (cnt_write=='h3A) cnt_write<='h2A;
	end
	else 
	begin
		cnt_write<=6'b0;
	end
end

assign bufer_in_en=BUF_IN_EN;

assign BUF_IN_EN=dalay_shift[`DELAY_DATAVALID+`DELAY_MULT+2];
/*
assign BUF_IN_EN=dalay_shift[`DELAY_DATAVALID];
*/
assign BL_SERDATA=RESET;
assign BL_MC=CLK_BOL;
assign CLK_BOL=CLK & BL_ENABLE;

assign CNT_ROW=row_write;


assign COUNTER_ENABLE=dalay_shift[`DELAY_DATAVALID+4];






endmodule
