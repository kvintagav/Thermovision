module sitch_addr(

input wire [9:0] INPUT_ADDR,
input wire [9:0] INPUT_ADDR_PED,
input wire [8:0] SHIFT,
input wire [31:0] MODE_FPGA,
input wire ENABLE_WRITE_PED,
output [12:0] OUTPUT_ADDR

);

wire [9:0]input_addr; 

wire [12:0]full_input_addr; 

assign input_addr[9:1]=(ENABLE_WRITE_PED==1) ? INPUT_ADDR[8:0] : INPUT_ADDR_PED;






endmodule


