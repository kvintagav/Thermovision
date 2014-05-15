
module sdram(
input wire   clock_100,
input wire   clock_100_delayed_3ns,


output  [13:0]  DRAM_ADDR,
output  [1:0]   DRAM_BA,
output    DRAM_CAS_N,
output   DRAM_CKE,
output   DRAM_CLK,
output   DRAM_CS_N,
output [1:0]   DRAM_DQM,
output    DRAM_RAS_N,
output   DRAM_WE_N,
input [15:0]   DRAM_INPUT ,
output  [15:0]   DRAM_OUTPUT ,

output DRAM_INOUT, 

input wire [1:0]bank,
input wire  [13:0] row_address,
input wire   req_read,
inout wire   req_write,

output reg   data_out_valid,
output reg   end_operation,

output reg [15:0]   data_out,
input wire [15:0]   data_in
   );
	
endmodule
	
