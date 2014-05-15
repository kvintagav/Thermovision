`include "define.v"

module switch_test_work(
input wire TEST,

input wire CLK,
input wire RESET,
input wire INT,
input wire SERDATA,

output CLK_BOL,
output RESET_BOL,
output INT_BOL,
output SERDATA_BOL,
input wire DATAVALID_BOL,
input wire LINE1_BOL,
input wire ERROR_BOL,

output DATAVALID,
output LINE1,
output ERROR,

output CLK_TEST,
output RESET_TEST,
output INT_TEST,
output SERDATA_TEST,
input wire DATAVALID_TEST,
input wire LINE1_TEST,
input wire ERROR_TEST




);

assign CLK_TEST=(TEST==1) ? CLK :1'b0; 
assign RESET_TEST=(TEST==1) ? RESET :1'b0;
assign INT_TEST=(TEST==1) ? INT :1'b0;
assign SERDATA_TEST=(TEST==1) ? SERDATA :1'b0;

assign CLK_BOL=(TEST==0) ? CLK :1'b0; 
assign RESET_BOL=(TEST==0) ? RESET :1'b0;
assign INT_BOL=(TEST==0) ? INT :1'b0;
assign SERDATA_BOL=(TEST==0) ? SERDATA :1'b0;

assign ERROR=(TEST==1)? ERROR_TEST:ERROR_BOL ;
assign DATAVALID=(TEST==1)?DATAVALID_TEST: DATAVALID_BOL ;
assign LINE1=(TEST==1) ? LINE1_TEST:LINE1_BOL;



endmodule

