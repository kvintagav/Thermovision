`include "define.v"

module bufer_ped(
input wire CLK1,
input wire CLK2,
input wire RESET,
input wire BUFER_CHANGE,
input wire BUFER_IN_EN,
input wire BUFER_OUT_EN,
input wire [`ADC_WIDHT-1:0] DATA_IN,
output [`ADC_WIDHT-1:0] DATA_OUT,
input wire start_write,
input wire NUMB_CHAN

);

reg [`ADC_WIDHT-1:0] bufer1[`PIX_IN_ROW-1:0];
reg [`ADC_WIDHT-1:0] bufer2[`PIX_IN_ROW-1:0];

reg [9:0] cnt1=10'b0;
reg [9:0] cnt2=10'b0;

reg [13:0] out=14'b0;





always @(negedge CLK1 or posedge RESET or posedge start_write)
begin
    if (RESET)
    begin
        cnt1=10'b0;
    end
	 else if (start_write)
    begin
        cnt1=10'b0;
    end
    else 
	 begin
		if (BUFER_IN_EN==1)
		 begin
			  if (BUFER_CHANGE==1)
			  begin
					bufer1[cnt1+NUMB_CHAN]<=DATA_IN;
					
			  end
			  else
			  begin
					bufer2[cnt1+NUMB_CHAN]<=DATA_IN;
					
			  end
			  
			  if (cnt1<=`PIX_IN_ROW) cnt1<=cnt1+2'b10;
					
		 end
		 else cnt1<=10'b0;
	end		
end

//сдвига входного буфер енайбла из-за сложения константы

reg [5:0]dalay_shift;
wire bufer_out_ped;
always @(negedge CLK2)
begin
	dalay_shift <= {dalay_shift[4:0],BUFER_OUT_EN };
	
end

assign bufer_out_ped=dalay_shift[2];

always @(negedge CLK2  or posedge RESET )
begin
    if (RESET)
    begin
       
        cnt2=10'b0;
    end
    else 
	 begin
		if (bufer_out_ped==1)
		//if (BUFER_OUT_EN==1)
		begin
		  if (BUFER_CHANGE==0)
		  begin
				out<=bufer1[cnt2];
		  end
		  else
		  begin
				out<=bufer2[cnt2];
		  end
		  if (cnt2<=`PIX_IN_ROW) cnt2<=cnt2+1'b1;
		end
		else 
		begin
			cnt2=9'b0;
			out<=14'b0;
		end
	 end
end

assign DATA_OUT=out;
endmodule 


