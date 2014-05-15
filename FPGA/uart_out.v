`include "define.v"
//Module outout frame-cadr to UART

module uart_out(
input wire CLK_10,
input wire CLK_UART,
input wire RESET,

input wire [15:0] VALUE,
input wire ENABLE,

output TX_UART,

output reg RESET_BL,
output reg READ_IN_EN,
output reg BUF_CHANGE,
output reg BUFER_EN,

output  [9:0]CNT_ROW_OUT,
output  [9:0]CNT_PIX_OUT

);


reg [5:0]state=6'b0 ;
reg [1:0]state_tx=2'b0;

parameter TRANS=1;
parameter STOP=0;



parameter wait_first_delay=16800; //first delay until bolometet start
parameter wait_two_delay=200;    //wait until first row read from memory
parameter wait_ftdi =1000;    //wait until first row read from memory



reg [19:0]OUT_UART=20'b0;

parameter PERIOD = 20;


reg [15:0]cnt_wait=16'b0;
reg [7:0]cnt=8'b0;
reg [9:0]cnt_pix=10'b0;
reg [9:0]cnt_row=10'b0;
reg [9:0]cnt_row_set=10'b0;

//reg [2:0]cnt_wait_buf=3'b0;

reg [15:0]ID_BYTE=16'b0;

parameter IDLE=0;
parameter S_RESET_UP=1;
parameter S_RESET_DOWN=2;
parameter S_WAIT_FERST=3;
parameter S_READ_FIRST_ROW_UP=4;
parameter S_READ_FIRST_ROW_DOWN=5;
parameter S_WAIT_TWO=6;
parameter S_READ_UP=7;
parameter S_READ_DOWN=8;
parameter S_WAIT_READ=9;
parameter S_BYTE_READ=10;
parameter S_OUT_BYTE=11;
parameter S_TX_ID_FRAME=12;
parameter S_TX_ID_ROW=13;
parameter S_TX_NUMB_ROW=14;
parameter S_TX_BYTE=15;
parameter S_WAIT_FTDI=16;



always @(posedge CLK_UART or posedge RESET)
begin
	if (RESET)
	begin
		state<=IDLE;
		state_tx<=STOP;
		cnt_wait<=16'b0;
		BUF_CHANGE<=0;
		cnt_pix=10'b0;
		cnt_row=10'b0;
		cnt_row_set=10'b0;
	
		cnt=8'b0;
		//cnt_wait_buf=3'b0;
		ID_BYTE<=`ID_FRAME;
		BUFER_EN=0;
		READ_IN_EN=0;
	end 
	else
	begin
		if (ENABLE==1)
		begin
			case(state)
			
			 IDLE:begin //state waiting 
				state<=S_RESET_UP;
				cnt_pix=10'b0;
				cnt_row=10'b0;
		//		cnt_wait_buf=3'b0;
				cnt=8'b0;
				ID_BYTE<=`ID_FRAME;
				state_tx<=STOP;
			 end
			 S_RESET_UP:begin //reset bolometer up
				state<=S_RESET_DOWN;
				RESET_BL<=1;
				
			 end	
			 S_RESET_DOWN:begin //reset bolometer down
				RESET_BL<=0;
				state<=S_WAIT_FERST;
			 end
			 
			 S_WAIT_FERST:begin // wait until the bolometer begin read row 
				cnt_wait<=cnt_wait+1'b1;
				if (cnt_wait>=wait_first_delay) begin
					state<=S_READ_FIRST_ROW_UP;
					cnt_wait<=16'b0;
				end
			 
			 end
			 S_READ_FIRST_ROW_UP:begin  //first row up
				state<=S_READ_FIRST_ROW_DOWN;
				READ_IN_EN<=1;
			 
			 end 
			 S_READ_FIRST_ROW_DOWN:begin //first row down
				state<=S_WAIT_TWO;
				READ_IN_EN<=0;
			 
			 end
			 S_WAIT_TWO:begin //wait until first row read from memory
				cnt_wait<=cnt_wait+1'b1;
				if (cnt_wait>=wait_two_delay) begin
					state<=S_TX_ID_FRAME;
					OUT_UART<={1'b1,ID_BYTE[15:8],2'b01,ID_BYTE[7:0],1'b0};
					state_tx<=TRANS ;				//enable tx
					cnt_wait<=16'b0;
				end
				
			
			 end
			 S_TX_ID_FRAME:begin
				OUT_UART<={1'b0,OUT_UART[19:1]};
				if (cnt<19) cnt<=cnt+1'b1;
				else begin 
					cnt<=8'b0;
					state<=S_READ_UP;  //read_next_row from memory
					cnt_row<=cnt_row+1'b1;
					state_tx<=STOP;		//desable TX
				end	
			 end
			 
			 
			 S_READ_UP:begin //read second and itc row from memory
				BUF_CHANGE<=!BUF_CHANGE;
				READ_IN_EN<=1;
				BUFER_EN<=0;
				state<=S_READ_DOWN;
				ID_BYTE<=`ID_ROW;    //write id_row to the ID_BYTE
			 end
			 S_READ_DOWN:begin 
				BUFER_EN<=1;	
				READ_IN_EN<=0;
				state<=S_TX_ID_ROW;  
				state_tx<=TRANS;  //enable TX
				OUT_UART<={1'b1,ID_BYTE[15:8],2'b01,ID_BYTE[7:0],1'b0};
			 end
		 	 S_TX_ID_ROW:begin    //translate ID_ROW
				OUT_UART<={1'b0,OUT_UART[19:1]};
				if (cnt<19) cnt<=cnt+1'b1;
				else 
				begin 
					cnt<=8'b0;
					state<=S_TX_NUMB_ROW;
					OUT_UART<={7'b1000000,cnt_row[9:8],2'b01,cnt_row[7:0],1'b0};	
				end	
			 end
			 S_TX_NUMB_ROW:begin  //translate number row
				OUT_UART<={1'b0,OUT_UART[19:1]};
				if (cnt<19) cnt<=cnt+1'b1;
				else begin 
					cnt<=8'b0;
					state<=S_TX_BYTE;
					cnt_pix<=10'b0;
					OUT_UART<={1'b1,VALUE[15:8],2'b01,VALUE[7:0],1'b0};
				end	
			 end	
			 S_WAIT_FTDI:begin
				cnt_wait<=cnt_wait+1'b1;
				if (cnt_wait>=wait_ftdi) begin
					if (cnt_row<`ROW_IN_FRAME-1)state<=S_READ_UP;
					else begin
						state<=S_TX_ID_ROW;
						OUT_UART<={1'b1,ID_BYTE[15:8],2'b01,ID_BYTE[7:0],1'b0};
						state_tx<=TRANS;
					end
				
					cnt_wait<=16'b0;
				end
			 
			 end
			 S_TX_BYTE:begin   //translate byte 
				
				if (cnt<19) begin
					cnt<=cnt+1'b1;
					OUT_UART<={1'b0,OUT_UART[19:1]};
				end
				else 
				begin 
					OUT_UART<={1'b1,VALUE[15:8],2'b01,VALUE[7:0],1'b0};
					cnt<=8'b0;
					if (cnt_pix==`PIX_IN_ROW)
					begin
						state_tx<=STOP;
						cnt_pix<=10'b0;
						BUFER_EN=0;
						
						if (cnt_row<`ROW_IN_FRAME)
						begin
							cnt_row<=cnt_row+1'b1;
							cnt_row_set<=cnt_row_set+1'b1;
							
							state<=S_WAIT_FTDI;
						end
						else	
						begin
							cnt_row<=10'b0;
							state<=IDLE;
						end
					end
				end
				
				if (cnt==16) begin
					if (cnt_pix<`PIX_IN_ROW)	cnt_pix<=cnt_pix+1'b1;
				end
				
			end
	
			default: state<=IDLE;
			endcase

		end
		else 
		begin
			state<=IDLE;
			state_tx<=STOP;
		
			
		end

	
	end
end 

assign  CNT_ROW_OUT=cnt_row;
assign  CNT_PIX_OUT=cnt_pix;
assign TX_UART=(state_tx==TRANS)? OUT_UART[0] : 1'b1;

endmodule

