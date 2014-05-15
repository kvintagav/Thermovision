// SPI Slave module
// CPOL=0, CPHA=0, MSB first
`include "define.v"


module SPIslave(
	input wire reset_spi,
	input wire clkIN,
	input wire nSSIN,
	input wire SCKIN,
	input wire MOSIIN,
	output wire MISOOUT,
	output reg [`SPI_WIDHT-1:0] dataOUT,
	input wire [`SPI_WIDHT-1:0] dataIN,
	output reg byteReceivedOUT
);

reg [`SPI_WIDHT-1:0] data;

assign MISOOUT = data[`SPI_WIDHT-1];

always @ (negedge SCKIN)
	if (nSSIN==0)
		data <= { data[`SPI_WIDHT-2:0], MOSIIN };
		
reg [4:0] count;

always @ (posedge SCKIN)
	if (nSSIN==1)
		count <= 5'h0;
	else
		count <= count + 1'b1;

always @ (count[4])
	dataOUT <= data;


always @ (posedge clkIN)
begin	
	if (nSSIN==0) 
	begin
		
		byteReceivedOUT <= 1'b0;
	end
	else 
	begin	
		byteReceivedOUT <= 1'b1;
	end
end	
endmodule
