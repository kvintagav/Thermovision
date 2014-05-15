`include "define.v"

module bufer_in_dual_line(
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

reg [`ADC_WIDHT-1:0] bufer1[`PIX_IN_ROW/2-1:0];
reg [`ADC_WIDHT-1:0] bufer2[`PIX_IN_ROW/2-1:0];

reg [`ADC_WIDHT-1:0] bufer3[`PIX_IN_ROW/2-1:0];
reg [`ADC_WIDHT-1:0] bufer4[`PIX_IN_ROW/2-1:0];

reg [9:0] cnt1=10'b0;

reg [9:0] cnt2=10'b0;

wire [8:0]cnt3;

wire [8:0]cnt4;


assign cnt3=cnt1[9:1];

assign cnt4=cnt2[9:1];

wire [`ADC_WIDHT-1:0] DATA_IN;

reg [`ADC_WIDHT-1:0] out=14'b0;

assign DATA_IN=(cnt1[0]) ? DATA_IN1 : DATA_IN2;

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
					if (cnt1[0]==0)bufer1[cnt3]<=DATA_IN;
					else bufer3[cnt3]<=DATA_IN;	
			  end
			  else
			  begin
					if (cnt1[0]==0)bufer2[cnt3]<=DATA_IN;
					else bufer4[cnt3]<=DATA_IN;
			
			  end
			  
			  if (cnt1<=`PIX_IN_ROW)begin
					cnt1<=cnt1+1'b1;
			
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
		     
				if (cnt2[0]==0)out<=bufer1[cnt4];
				else out<=bufer3[cnt4];	
			 
		  end
		  else
		  begin
				if (cnt2[0]==0)out<=bufer2[cnt4];
				else out<=bufer4[cnt4];
		  end
		  if (cnt2<=`PIX_IN_ROW) begin
				
				cnt2<=cnt2+1'b1;
				
				
			end		
		 end
	end	 
end

assign DATA_OUT=out;
endmodule 

