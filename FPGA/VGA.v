`include "define.v"
/*модуль VGA вывода

*/

module VGA(
input CLK,
input RESET,
input wire ENABLE,
input wire [`MODE_MAX:0] MODE,
input wire [9:0] horizontal,
input wire [9:0] vertical,

output [9:0] COUNTER_ROW,
output reg H_SYNC_CLK,
output reg V_SYNC_CLK,
output reg BUFER,
output reg READ_OUT_EN



);
/*параметры фронтов и спадов VGA-сигналов */
parameter E = 16;
parameter B = 96;
parameter C = 48;
parameter D = 640;
parameter A = E+ B + C + D;

parameter S = 10;
parameter P = 2;
parameter Q = 33;
parameter R = 480;
parameter O = S + P + Q + R;
/*регистр номера ряда для чтения*/
reg [9:0] counter_row=10'b0;

assign COUNTER_ROW=counter_row;

always@(posedge CLK or posedge RESET)
begin
    if(RESET==1)
    begin
		H_SYNC_CLK <= 1'b0;
		V_SYNC_CLK <= 1'b0;
		READ_OUT_EN <= 1'b0;
		counter_row<=10'b0;
    end
    else
    begin
			
		if (ENABLE==1)
		begin
			 
			if  ((horizontal >= 0) && (  horizontal <  B)) 
				H_SYNC_CLK <= 1'b0;
			else
				H_SYNC_CLK <= 1'b1;
		 
			if (( vertical >= 0 ) &&(  vertical <  P))
			  V_SYNC_CLK <= 1'b0;
			else
			  V_SYNC_CLK <= 1'b1;
		
			if ((vertical>=(P+Q)) && (vertical<(P+Q+R-1)) && (horizontal==0))
			begin
				counter_row <=counter_row+1'b1 ;
			end
		
			if ((vertical>=(P+Q-1)) && (vertical<(P+Q+R-1)) && (horizontal==0))
				READ_OUT_EN<=1'b1;
			else 
				READ_OUT_EN<=1'b0;
			
			if ((vertical>=(P+Q)) && (vertical<(P+Q+R)) && (horizontal>=(B+C)) && (horizontal<(B+C+D)))
				BUFER<=1'b1;
			else 
				BUFER<=1'b0;
			
			if ((vertical==0) && horizontal==(B+C))
			begin
				counter_row <=10'b0;
			end	
	
			
		end
		else
		begin
		
		end
  
	  
    end
   
end
endmodule
