`include "define.v"

module ped_control(

input wire CLK100,

input wire RESET,
input wire RESET_FRAME,

input wire [31:0] MODE,

output wire [1:0] BANK_MEM,
output[2:0]SHIFT_ADDR,
output wire [12:0] ADDR_MEM,
input wire [`ADC_WIDHT-1:0] DATA_IN,
output[`ADC_WIDHT-1:0] DATA_OUT,

input wire BUFER_EN,

input wire END_OPERATION,
input wire start_write,

input wire NUMBER_CHAN,
output WRITE_ROW,
output READ_ROW,

output reg END_MATH_PED

);

reg [19:0] cnt=20'b0;

//reg frame_cnt_en=1'b0;     //запрос на инкрементирование фрейма от счетчита ресета  болометра
//wire wire_frame_cnt_en;     //запрос на инкрементирование фрейма от счетчита ресета  болометра
//assign wire_frame_cnt_en=frame_cnt_en;
reg [12:0]shift_sddr;
reg [9:0]row_addr;
//куп [1:0]bank;

reg [9:0]state=10'b0;
reg [7:0]cnt_frame=8'b0;

parameter idle_s=0;
parameter start_s=1;
parameter request_read_s=2; 
parameter read_s=3;
parameter request_write_s=4;
parameter write_s=5;
parameter stop_s=6;
parameter stop_stop_s=7;

 
assign READ_ROW=(state==request_read_s) ? 1'b1 : 1'b0;
assign WRITE_ROW=(state==request_write_s) ? 1'b1 : 1'b0;


assign BANK_MEM[1:0]=cnt_frame[1:0];
assign SHIFT_ADDR[2:0]=cnt_frame[4:2];

assign ADDR_MEM[12:0]={cnt_frame[4:2],row_addr[9:0]};

reg [19:0] bufer[`PIX_IN_ROW-1:0]; //bufer for pixel

reg [9:0] cnt2;
reg [19:0] out;
assign DATA_OUT=out[19:6];
reg [5:0]cnt_ped_frame;

/*write and read data from and to memory*/
always @(negedge CLK100 or posedge RESET or posedge start_write)
begin
    if (RESET)
    begin
        cnt2=10'b0;
    end
	 else if (start_write)
    begin
        cnt2=10'b0;
    end
    else
	 begin
		if (state==read_s) /*write data */
		begin
		
			if(BUFER_EN==1)
			begin
			  bufer[cnt+NUMBER_CHAN]<=DATA_IN+bufer[cnt+NUMBER_CHAN];
			  if (cnt2<=`PIX_IN_ROW) cnt2<=cnt2+2'b10; //uncrement row *2 becous 1 row bolometer in 2 rom memory
			
			end
			else cnt2=10'b0;
		end
		else if (state==write_s)/*read data*/
		begin
			out<=bufer[cnt2+NUMBER_CHAN];
			if (cnt2<=`PIX_IN_ROW) cnt2<=cnt2+2'b10;
			
		end
    end
end



/*автомат управления модулем и генерации адресов*/
always @(posedge CLK100 or posedge RESET or posedge RESET_FRAME)
begin
	if (RESET)
	begin
	/*нулевое состояние*/
		state<=idle_s;
		cnt_frame<=8'b0;
		row_addr<=10'b0;
	
	end
	else if (RESET_FRAME)         //SIGNAL NEXT FRAME
	begin
		state<=idle_s;
		if (MODE[15:8]==`MODE_SAVE_PED)
		begin
			cnt_frame<=cnt_frame+1'b1;
			
		end
		
	end
	else
	begin
		if (MODE[15:8]==`MODE_MATH_PED) //if mode mathematic pedestal
		begin
			case(state)
			idle_s:begin
				cnt_frame<=8'b0;
				state<=start_s;
				row_addr<=10'b0;
				cnt_frame<=8'b0;
			end
			start_s:begin
				
				state<=request_read_s;   // request read row
			end
			request_read_s:begin
				state<=read_s;
			end
			read_s:begin
				if(END_OPERATION==1)
				begin
					if (cnt_frame< `PED_MAX_FRAME-1) //if frame with ped finsh 
					begin
						state<=request_read_s;        // request next row
						cnt_frame<=cnt_frame+1'b1;    // increment number frame
						
					end 
					else  //start write ready row
					begin 
						cnt_frame<=8'b0;
						state<=request_write_s;
					end
				end
				
			end
			request_write_s:begin
				state<=write_s;
				cnt_frame<=8'b0;
			end
			write_s:begin
				if(END_OPERATION==1)
				begin
					if (row_addr< `ROW_IN_FRAME-2) //if frame with ped finsh 
					begin
						state<=request_read_s;
						row_addr<=row_addr+2'b10;
						
					end 
					else  
					begin 
						cnt_frame<=8'b0;
						row_addr<=10'b0;
						state<=stop_s;
					end
				end
			
			end
			stop_s:begin
				END_MATH_PED<=1'b1;
				state<=stop_stop_s;
			end
			stop_stop_s:begin
				END_MATH_PED<=1'b0;
			end
			
			default:begin
				state<=idle_s;
			end
			endcase
		end	
		else 
		begin
			state<=idle_s;
		end
	end
end


endmodule


