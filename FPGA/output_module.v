/*module contro; - модуль выбора выводящего устройства.
*/
`include "define.v"

module output_module(
input wire CLK_10,
input wire CLK_50,
input wire CLK_25,
input wire CLK_100,
input wire CLK_UART,

input wire [`MODE_MAX:0] MODE,


input wire  OUT_ENABLE,
input wire BUF_EN_UART,
input wire BUF_CHANGE_UART,
input wire READ_EN_UART,
input wire [9:0]CNT_ROW_UART,
input wire RESET_FROM_UART,


output BUFER_EN,
output CLK_BUF,
output BUF_CHANGE,
output READ_EN,
output  [9:0]CNT_ROW,
output  RESET,
output  ENABLE_UART,

input wire BUF_CHANGE_VGA,
input wire READ_EN_VGA,
input wire [9:0]CNT_ROW_VGA,
input wire RESET_FROM_VGA,
input wire BUF_EN_VGA,
output ENABLE_VGA,
output LOW_SPEED_OUT
);
/*

assign BUF_CHANGE=(MODE[7:0]==`MODE_OUT_VGA)? BUF_CHANGE_VGA :
(MODE[7:0]==`MODE_OUT_UART)? BUF_CHANGE_UART : 1'b0;

assign LOW_SPEED_OUT=(MODE[7:0]==`MODE_OUT_UART)? 1'b1 :1'b0;

assign ENABLE_VGA=(MODE[7:0]==`MODE_OUT_VGA)? OUT_ENABLE :1'b0;

assign ENABLE_UART=(MODE[7:0]==`MODE_OUT_UART)? ENABLE_UART :1'b0;

assign RESET=(MODE[7:0]==`MODE_OUT_VGA)? RESET_FROM_VGA :
(MODE[7:0]==`MODE_OUT_UART)? RESET_FROM_UART : 1'b0;

assign CNT_ROW=(MODE[7:0]==`MODE_OUT_VGA)? CNT_ROW_VGA :
(MODE[7:0]==`MODE_OUT_UART)? CNT_ROW_UART : 1'b0;


assign READ_EN=(MODE[7:0]==`MODE_OUT_VGA)? READ_EN_VGA :
(MODE[7:0]==`MODE_OUT_UART)? READ_EN_UART : 1'b0;



assign BUFER_EN=(MODE[7:0]==`MODE_OUT_VGA)? BUF_EN_VGA :
(MODE[7:0]==`MODE_OUT_UART)? BUF_EN_UART : 1'b0;
 

assign CLK_BUF=(MODE[7:0]==`MODE_OUT_VGA)? CLK_25 :
(MODE[7:0]==`MODE_OUT_UART)? CLK_UART : 1'b0;

*/

assign BUF_CHANGE=(MODE[0]==1)? BUF_CHANGE_VGA :BUF_CHANGE_UART;

assign LOW_SPEED_OUT=(MODE[0]==1)? 1'b0 :1'b1;

assign ENABLE_VGA=(MODE[0]==1)? OUT_ENABLE :1'b0;

assign ENABLE_UART=(MODE[0]==0)? OUT_ENABLE :1'b0;

assign RESET=(MODE[0]==1)? RESET_FROM_VGA :RESET_FROM_UART ;

assign CNT_ROW=(MODE[0]==1)? CNT_ROW_VGA : CNT_ROW_UART ;

assign READ_EN=(MODE[0]==1)? READ_EN_VGA : READ_EN_UART ;

assign BUFER_EN=(MODE[0]==1)? BUF_EN_VGA : BUF_EN_UART ;
 
assign CLK_BUF=(MODE[0]==1)? CLK_25 :CLK_UART ;


endmodule
