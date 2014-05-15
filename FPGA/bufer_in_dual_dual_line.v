`include "define.v"

module bufer_in_dual_dual_line(
input wire CLK1,
input wire CLK2,
input wire RESET,
input wire BUFER_CHANGE,
input wire BUFER_IN_EN,
input wire BUFER_OUT_EN,
input wire [`ADC_WIDHT-1:0] DATA_IN2,
input wire [`ADC_WIDHT-1:0] DATA_IN1,

output [`ADC_WIDHT-1:0] DATA_OUT,
input wire start_write

);

(* ramstyle = "M9K" *) reg [`ADC_WIDHT-1:0] bufer1[`PIX_IN_ROW-1:0];
(* ramstyle = "M9K" *) reg [`ADC_WIDHT-1:0] bufer2[`PIX_IN_ROW-1:0];


reg [9:0] cnt1=10'b0;
reg [9:0] cnt2=10'b0;



reg [13:0] out=14'b0;

always @(negedge CLK1 or posedge RESET )
begin
    if (RESET)
    begin
        cnt1=10'b0;
   
	 end
	
    else 
	 begin
		 if(BUFER_IN_EN==1)
		 begin
			  if (BUFER_CHANGE==1)
			  begin
					bufer1[cnt1]<=DATA_IN1;
					bufer1[cnt1+1]<=DATA_IN2;
					
			  end
			  else
			  begin
					bufer2[cnt1]<=DATA_IN1;
					bufer2[cnt1+1]<=DATA_IN2;
			  end
			  
			  if (cnt1<=`PIX_IN_ROW)begin
					cnt1<=cnt1+2'b1;
			
			  end
		end
	 	
		else if(BUFER_IN_EN==0)begin
			cnt1=10'b0;
	
			
		end  
    end
end

//reg change=0;
always @(negedge CLK2  or posedge RESET or posedge start_write)
begin
    if (RESET)
    begin
       
        cnt2<=10'b0;
	
    end
    else if (start_write)
    begin
       
        cnt2<=10'b0;
	
    end
    else 
	 begin
		if (BUFER_OUT_EN==1)
		begin
		  if (BUFER_CHANGE==0)
		  begin
		     
			 out<=bufer1[cnt2];
			 
		  end
		  else
		  begin
			 out<=bufer2[cnt2];
		  end
		  if (cnt2<=`PIX_IN_ROW) begin
				
				cnt2<=cnt2+1'b1;
				
				
			end		
		 end
	end	 
end

assign DATA_OUT=out;
endmodule 


