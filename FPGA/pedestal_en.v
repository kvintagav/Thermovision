`include "define.v"


module pedestal_en(

input wire    [`MODE_MAX:0] MODE_FPGA,

input wire [`ADC_WIDHT-1:0] vga_in,

input wire [`ADC_WIDHT-1:0] ped_in,
output [`ADC_WIDHT-1:0] ped_out


);


assign ped_out=(MODE_FPGA[`MODE_PED]==1) ? ped_in : vga_in;

endmodule
