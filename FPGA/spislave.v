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
	output   byteReceivedOUT

);

reg [`SPI_WIDHT-1:0] data;

assign MISOOUT = data[`SPI_WIDHT-1];

always @ (negedge SCKIN)
	if (nSSIN==0)
		data <= { data[`SPI_WIDHT-2:0], MOSIIN };
		
reg [4:0] count;

always @ (posedge SCKIN or posedge nSSIN)
	if (nSSIN==1)
		count <= 5'h0;
	else
		count <= count + 1'b1;

always @ (negedge count[4])
	dataOUT <= data;

reg [2:0]state=2'b000;

reg  byte_read;
always @ (posedge  clkIN)
begin
	state<= { state[1:0], byte_read };
end

assign byteReceivedOUT=state[2];
//wire byte_ready;

always @(posedge count[4] or posedge clkIN)
begin
	if(count[4]==1)
	byte_read=1;
	else byte_read=0;
end

endmodule