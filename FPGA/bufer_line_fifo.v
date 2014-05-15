`include "define.v"

module bufer_line_fifo(
input wire CLK1,
input wire CLK2,
input wire RESET,
input wire BUFER_CHANGE,
input wire BUFER_IN_EN,
input wire BUFER_OUT_EN,
input wire [`ADC_WIDHT-1:0] DATA_IN1,
input wire [`ADC_WIDHT-1:0] DATA_IN2,
output [`ADC_WIDHT-1:0] DATA_OUT,
input wire start_write

);

reg [`ADC_WIDHT-1:0] bufer1[`PIX_IN_ROW-1:0];
reg [`ADC_WIDHT-1:0] bufer2[`PIX_IN_ROW-1:0];




reg [13:0] out=14'b0;

always @(negedge CLK1 )
begin
     if(BUFER_IN_EN==1)
		 begin
			  if (BUFER_CHANGE==1)
			  begin
					 bufer1<={bufer1[`PIX_IN_ROW-2],DATA_IN1};
					 
				//	data <= { data[`SPI_WIDHT-2:0], MOSIIN };
					
			  end
			  else
			  begin
					 bufer2<={bufer2[`PIX_IN_ROW-2],DATA_IN1};
				
					
			  end
			  
		end
	 	
end

reg change=0;
always @(negedge CLK2  )
begin
    
		if (BUFER_OUT_EN==1)
		begin
		  if (BUFER_CHANGE==0)
		  begin
		     
		 bufer1={bufer1[`PIX_IN_ROW-2],14'b0};
			 
		  end
		  else
		  begin
			  bufer2={bufer2[`PIX_IN_ROW-2],14'b0};
		  end
		  
		 end
 
end
assign DATA_OUT=(BUFER_CHANGE==1) ?  bufer1[`PIX_IN_ROW-1]  : bufer2[`PIX_IN_ROW-1]    ;
//assign DATA_OUT=out;
endmodule 


