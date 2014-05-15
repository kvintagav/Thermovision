`include "define.v"

module bufer_line(
input wire CLK1,
input wire CLK2,
input wire RESET,
input BUFER_CHANGE,
input wire BUFER_IN_EN,
input wire BUFER_OUT_EN,
input wire [`ADC_WIDHT-1:0] DATA_IN,
output [`ADC_WIDHT-1:0] DATA_OUT
);

reg [`ADC_WIDHT-1:0] bufer1[(`PIX_IN_ROW/`NUMB_CHAN)-1:0];
reg [`ADC_WIDHT-1:0] bufer2[(`PIX_IN_ROW/`NUMB_CHAN)-1:0];

reg [8:0] cnt1=9'b0;
reg [8:0] cnt2=9'b0;

reg [13:0] out=14'b0;
always @(negedge CLK1 or posedge RESET)
begin
    if (RESET)
    begin
        cnt1=9'b0;
    end
    else //if(BUFER_IN_EN==1)
    begin
        if (BUFER_CHANGE==1)
        begin
            bufer1[cnt1]<=DATA_IN;
        end
        else
        begin
            bufer2[cnt1]<=DATA_IN;
        end
        if (cnt1<=`PIX_IN_ROW) cnt1<=cnt1+1'b1;
		  
    end
end

always @(posedge CLK2  or posedge RESET)
begin
    if (RESET)
    begin
       
        cnt2=9'b0;
    end
   
    else if (BUFER_OUT_EN==1)
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
end

assign DATA_OUT=out;
endmodule 


