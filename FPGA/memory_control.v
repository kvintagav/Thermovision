
`include "define.v"
/*Модуль распределения времени работы с памятью

*/

module memory_control(

input wire CLK100,
input wire CLK25,
input wire GLOBAL_RESET,
input wire RESET,
input wire [`MODE_MAX:0] MODE,

input wire  LINE1,
input wire MEM_ENABLE,
input wire TYPE,
input wire NUM_CHAN, 


output reg RESET_CLK_IN,
output  BUF_IN_EN,
input wire [`ADC_WIDHT-1:0] CAN_IN,

output reg RESET_CLK_OUT,
output  BUF_OUT_EN,
output  [`ADC_WIDHT-1:0] CAN_OUT,


output reg RESET_CLK_PED,
output  BUF_PED_EN,
output  [`ADC_WIDHT-1:0] CAN_PED,


output [15:0] DATA_MEM_OUT,
input wire [15:0] DATA_MEM_IN,
input wire BUF_EN,
input wire END_OPERATION,
output [1:0]  C_BANK, 
output [12:0] C_ROW_ADDRESS, 
output    C_READ, 
output    C_WRITE,

input wire [9:0]CTR_ROW_IN,
input wire WRITE_IN_EN,

input wire [9:0]CTR_ROW_OUT,
input wire READ_OUT_EN,


input wire END_READ,  //конец выдачи изображения по uart 

input wire [1:0]BANK_PED,

input wire [12:0]ADDR_READ_PED,
input wire [2:0]SHIFT_ADDR_PED,

output reg RESET_CLK_MATH_PED,
input wire WRITE_ROW_PED_MATH,
input wire READ_ROW_PED_MATH,
output BUFER_EN_PED_MATH,
output [`ADC_WIDHT-1:0] DATA_TO_PED_MATH,
input wire [`ADC_WIDHT-1:0] DATA_FROM_PED_MATH

);


reg reset_state;

wire [1:0]bank_read; 
wire[1:0]bank_write;
wire [1:0]bank_ped; 
wire [1:0]bank_one;
wire [1:0]bank_read_addr;
wire[1:0]bank_write_addr;

reg [1:0]cnt_frame=2'b00; 


reg [5:0]state=6'b000000; 
reg [9:0]cnt_row;
reg [19:0]cnt;
reg work_mode;

parameter PERIOD=(`PIX_IN_ROW/`NUMB_CHAN+`DELAY_ROW)*10;




parameter S_IDLE=0;
parameter S_READ=1;
parameter S_WRITE=2;
parameter S_WRITE_REQ=3;
parameter S_READ_REQ=4;

parameter S_WRITE_PED=5;
parameter S_READ_PED=6;
parameter S_READ_PED_REQ=7;

parameter S_WRITE_PED_MATH=8;
parameter S_READ_PED_MATH=9;



wire [12:0]ADDR_WRITE_PED;
assign ADDR_WRITE_PED={SHIFT_ADDR_PED[2:0],CTR_ROW_IN[9:1],1'b0};


assign C_READ=(state==S_READ) ? 1'b1  :
(state==S_READ_PED) ? 1'b1  : 
(state==S_READ_PED_REQ) ? 1'b1  : 
(state==S_READ_REQ) ? 1'b1 : 
(state==S_READ_PED_MATH) ? 1'b1 : 1'b0 ;

assign C_WRITE=(state==S_WRITE) ? 1'b1 :
(state==S_WRITE_PED) ? 1'b1 :
(state==S_WRITE_REQ) ? 1'b1 : 
(state==S_WRITE_PED_MATH) ? 1'b1 : 1'b0 ;

/*write pedestatl to memomry*/
assign  BUF_IN_EN=(state==S_WRITE) ? BUF_EN:
(state==S_WRITE_REQ) ? BUF_EN:
(state==S_WRITE_PED) ? BUF_EN: 1'b0;


/*BUF_OUT_EN - bufer for write row in out bufer(vga or uart)*/ 
assign  BUF_OUT_EN=(state==S_READ) ? BUF_EN:
(state==S_READ_REQ) ? BUF_EN: 1'b0;

/*BUF_PED_EN - bufer for write pedestal level for subtraction */
assign  BUF_PED_EN=(state==S_READ_PED) ? BUF_EN:
(state==S_READ_PED_REQ) ? BUF_EN: 1'b0;

/*BUFER_EN_PED_MATH - bufer for module mcalculate pedestatl (ped_control)*/
assign  BUFER_EN_PED_MATH=(state==S_READ_PED_MATH) ? BUF_EN: 
(state==S_WRITE_PED_MATH) ? BUF_EN: 1'b0;


assign DATA_MEM_OUT[15:14]=2'b00;


assign DATA_MEM_OUT[`ADC_WIDHT-1:0]=(state==S_WRITE) ? CAN_IN:  
(state==S_WRITE_PED) ? CAN_IN:
(state==S_WRITE_REQ) ? CAN_IN:
(state==S_WRITE_PED_MATH) ? DATA_FROM_PED_MATH: 14'b0;

/*CAN_OUT - write data to out bufer*/
assign CAN_OUT=(state==S_READ) ? DATA_MEM_IN[`ADC_WIDHT-1:0] : 
(state==S_READ_REQ) ? DATA_MEM_IN[`ADC_WIDHT-1:0] : 14'b0;

/*CAN_PED - write data to out pedestal bufer*/
assign CAN_PED=(state==S_READ_PED) ? DATA_MEM_IN[`ADC_WIDHT-1:0] : 
(state==S_READ_PED_REQ) ? DATA_MEM_IN[`ADC_WIDHT-1:0] : 14'b0;

/*DATA_TO_PED_MATH - write data to ped_control for calculation*/
assign DATA_TO_PED_MATH=(state==S_READ_PED_MATH) ? DATA_MEM_IN[`ADC_WIDHT-1:0] : 14'b0;


assign C_ROW_ADDRESS=(state==S_WRITE) ? CTR_ROW_IN*2 :
(state==S_WRITE_REQ) ? CTR_ROW_IN*2 :
(state==S_READ_PED) ?  CTR_ROW_OUT*2 :
(state==S_READ_PED_REQ) ?  CTR_ROW_OUT*2 :
(state==S_WRITE_PED) ?  ADDR_WRITE_PED :
(state==S_READ) ? CTR_ROW_OUT*2 :
(state==S_READ_REQ) ? CTR_ROW_OUT*2 :
(state==S_WRITE_PED_MATH) ? ADDR_READ_PED :
(state==S_READ_PED_MATH)  ? ADDR_READ_PED : 13'b0 ;



assign C_BANK=(state==S_WRITE) ? bank_write :
(state==S_WRITE_REQ) ? bank_write :
(state==S_READ_PED) ?  bank_ped :
(state==S_READ_PED_REQ) ?  bank_ped :
(state==S_WRITE_PED) ?  BANK_PED :
(state==S_READ) ? bank_read :
(state==S_READ_REQ) ? bank_read : 
(state==S_WRITE_PED_MATH ) ? BANK_PED : 
(state==S_READ_PED_MATH) ? BANK_PED : 2'b00 ;

assign bank_read_addr=(cnt_frame==2'b10)? 2'b01: 2'b10; //буфер для чтения если синхронный вывод

assign bank_read=(MODE[15:8]==`MODE_OUT_UART) ? bank_one :bank_read_addr; //выбор буфера для записи

assign bank_write=(MODE[15:8]==`MODE_OUT_UART) ? bank_one :bank_write_addr; //выбор буфера для записи

assign bank_write_addr=(cnt_frame==2'b01)? 2'b10: 2'b01; //буфер для записи если синхронный вывод

assign bank_one=2'b11; 

assign bank_ped=2'b00;

reg [9:0]cnt_cadr;

always @(posedge GLOBAL_RESET or posedge RESET)
begin
	if (GLOBAL_RESET)
	begin
		cnt_frame<=2'b10;		
	end
	else 
	begin
		cnt_frame[0]<=!cnt_frame[0];
		cnt_frame[1]<=!cnt_frame[1];
		

   end
	
end



always @(negedge CLK100 or posedge RESET)
begin
	if (RESET)
	begin
	state<=S_IDLE;
	RESET_CLK_OUT<=0;
	RESET_CLK_IN<=0;
	RESET_CLK_PED<=0;
	
	end
	else 
	begin
	
		if (MODE[15:8]==`MODE_OUT_SAVE)  //сохранить и выдать кадр
		begin	
			case(state)
				S_IDLE:begin
					if(READ_OUT_EN==1) begin
						state<=S_READ;
						end
					else if (WRITE_IN_EN==1)begin
						state<=S_WRITE;
					end
					
					RESET_CLK_OUT<=0;
					RESET_CLK_IN<=0;
					RESET_CLK_PED<=0;
				end
				S_READ:begin
					RESET_CLK_IN<=0;
					if (WRITE_IN_EN==1)begin
						state<=S_READ_REQ;
					end
					else if(END_OPERATION==1) begin
						state<=S_IDLE;
						RESET_CLK_OUT<=1;
					end
				end
				
				S_WRITE:begin
					RESET_CLK_OUT<=0;
					if (READ_OUT_EN==1)begin
						state<=S_WRITE_REQ;
					end
					else if(END_OPERATION==1) begin
						state<=S_IDLE;
						RESET_CLK_IN<=1;
					end
				end
				S_READ_REQ:begin
					 if(END_OPERATION==1) begin
						state<=S_WRITE;
						RESET_CLK_OUT<=1;
					end
				end
				S_WRITE_REQ:begin
					 if(END_OPERATION==1) begin
						state<=S_READ;
						RESET_CLK_IN<=1;
					end
				end
			default: begin
					state<=S_IDLE;
				end
			endcase
		end
		else if (MODE[15:8]==`MODE_MATH_PED)  // вычислить педестал
		begin
			case(state)
				S_IDLE:begin
					RESET_CLK_MATH_PED<=1'b0;
					if (WRITE_ROW_PED_MATH==1)begin
						state<=S_WRITE_PED_MATH;
					end
					else if(READ_ROW_PED_MATH==1) begin
						state<=S_READ_PED_MATH;
					end
							
				end
				S_WRITE_PED_MATH:begin
					if(END_OPERATION==1) begin
						state<=S_IDLE;
						RESET_CLK_MATH_PED<=1'b1;
		
						end
					end
				S_READ_PED_MATH:begin
					if(END_OPERATION==1) begin
						state<=S_IDLE;
						RESET_CLK_MATH_PED<=1'b1;
				end
				
				end
			endcase
		end
		else if ((MODE[15:8]==`MODE_SAVE_PED)) //сохранить педестал  
		begin	
			case(state)
				S_IDLE:begin
					if (WRITE_IN_EN==1)begin
						state<=S_WRITE_PED;
					end
					
					
					RESET_CLK_OUT<=0;
					RESET_CLK_IN<=0;
					RESET_CLK_PED<=0;
				end
				S_WRITE_PED:begin
					if(END_OPERATION==1) begin
						state<=S_IDLE;
						RESET_CLK_IN<=1;
						end
					end
				default: begin
					state<=S_IDLE;
				end
				endcase
				
				
		
			
		end
		
		else if (MODE[15:8]==`MODE_OUT_PED_SAVE) //выдыать кадр с учетом педестала
		begin	
			case(state)
				S_IDLE:begin
					if(READ_OUT_EN==1) begin
						state<=S_READ_PED;
						end
					else if (WRITE_IN_EN==1)begin
						state<=S_WRITE;
					end
					
					RESET_CLK_OUT<=0;
					RESET_CLK_IN<=0;
					RESET_CLK_PED<=0;
				end
				
				
				S_WRITE:begin
					RESET_CLK_OUT<=0;
					if (READ_OUT_EN==1)begin
						state<=S_WRITE_REQ;
					end
					else if(END_OPERATION==1) begin
						state<=S_IDLE;
						RESET_CLK_IN<=1;
					end
				end
				
				S_WRITE_REQ:begin
					 if(END_OPERATION==1) begin
						state<=S_READ_PED;
						RESET_CLK_IN<=1;
					end
				end
				
				S_READ_PED:begin
					if(END_OPERATION==1) begin
						state<=S_READ;
						RESET_CLK_PED<=1;
					end
					if(WRITE_IN_EN==1) begin
						state<=S_READ_PED_REQ;
						RESET_CLK_PED<=1;
					end
				end
				
				S_READ_PED_REQ:begin
					if(END_OPERATION==1) begin
						state<=S_READ_REQ;
						RESET_CLK_PED<=1;
					end
				end
				
				S_READ_REQ:begin
					 if(END_OPERATION==1) begin
						state<=S_WRITE;
						RESET_CLK_OUT<=1;
					end
				end
				
				S_READ:begin
					RESET_CLK_IN<=0;
					if (WRITE_IN_EN==1)begin
						state<=S_READ_REQ;
					end
					else if(END_OPERATION==1) begin
						state<=S_IDLE;
						RESET_CLK_OUT<=1;
					end
				end
				
			default: begin
					state<=S_IDLE;
				end
			endcase
		end
		
	end
	
end

endmodule

