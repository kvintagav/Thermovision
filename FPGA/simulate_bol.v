
`include "define.v"


module simulate_bol(
input wire CLK,
input wire  RESET,
input wire BOL_INT,
input wire SERDATA,

output  DATAVALID,
output LINE1,
output ERROR,

output [`ADC_WIDHT-1:0]ADC_OUT1,
output [`ADC_WIDHT-1:0]ADC_OUT2


);


parameter DELAY_DATAVALID=9;
reg [10:0]row=11'b0;

reg [10:0]shift=11'b0;
reg [10:0]shift_datavalid=11'b0;
reg [13:0] cnt_pix=14'b0;
reg error=0;

reg datavalid;
reg datavalid_start;
wire wire_data_start;
wire data_inv;
wire data_out_en;
reg [15:0]dalay_shift;

initial
begin
 datavalid=0;
 datavalid_start=0;
end 

always @(negedge datavalid or posedge RESET)
begin
    if (RESET) row<=11'b0;
	else 
	begin
		
		if (row<`ROW_IN_FRAME)	row<=row+1'b1;
		else row<=11'b0;
	end
end

always @(negedge CLK or posedge BOL_INT)
begin
	if (BOL_INT)
	begin
		shift<=11'b0;
		datavalid_start=0;
	end
	else
	begin
		if (shift==18) datavalid_start=1;
		else  datavalid_start=0;
		
		if (shift=='h6E1) shift<='h524;
		shift<=shift+1'b1;
	end 

end

assign wire_data_start= datavalid_start;


always @(negedge CLK or posedge wire_data_start or posedge RESET)
begin
	if (RESET) begin
		datavalid=0;
		shift_datavalid<='h524;
	end
	else if (wire_data_start)
	begin
		shift_datavalid<=11'b0;
		
	end
	else
	begin
		if (shift_datavalid==0) datavalid=1;
		else if (shift_datavalid==`PIX_IN_ROW/`NUMB_CHAN) datavalid=0;
		
		if (shift_datavalid=='h6E1) shift_datavalid<='h524;
		shift_datavalid<=shift_datavalid+1'b1;
	end 

end

assign data_inv=!data_out_en;

always @(posedge CLK or posedge data_inv )
begin
	if (data_inv) 
	begin
		cnt_pix<=14'b0;
		
	end
	else
	begin
		cnt_pix<=cnt_pix+6'b11_0000;
		if (cnt_pix==16382) cnt_pix<=14'b0;
	
	end

end

/*
always @(posedge CLK or posedge RESET )
begin
	if (RESET) 
	begin
		cnt_pix<=14'b0;
		
	end
	else
	begin
		if (data_out_en==1)
		begin
			cnt_pix<=cnt_pix+2'b10;
			if (cnt_pix==16384) cnt_pix<=14'b0;
		end
	
	end

end
*/
always @(posedge CLK)
begin
	dalay_shift <= {dalay_shift[14:0], datavalid};
end

assign data_out_en=dalay_shift[DELAY_DATAVALID];


assign ERROR=error;
assign DATAVALID=datavalid; 
assign LINE1=(row==0)? DATAVALID :1'b0;


assign ADC_OUT1=cnt_pix;
assign ADC_OUT2=cnt_pix+5'b1_0000;
endmodule


