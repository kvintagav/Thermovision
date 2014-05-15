`include "define.v"

module delay_sync(

input wire CLK,
input wire H_SYNC,
input wire V_SYNC,
input wire [31:0]MODE_FPGA,

output H_SYNC_OUT,
output V_SYNC_OUT

);

reg [20:0]shift_h_sync;
reg [20:0]shift_v_sync;


assign H_SYNC_OUT=(MODE_FPGA[`MODE_PED]==1)? shift_h_sync[5] : shift_h_sync[5] ;
assign V_SYNC_OUT=(MODE_FPGA[`MODE_PED]==1)? shift_v_sync[5] : shift_v_sync[5] ;
 

always @(posedge CLK)
begin
	shift_h_sync<= {shift_h_sync[19:0], H_SYNC};
	shift_v_sync<= {shift_v_sync[19:0], V_SYNC};
	


end



endmodule