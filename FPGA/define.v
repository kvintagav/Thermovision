
//`timescale 1ns / 1ps

`define ADC_WIDHT 			14
`define VGA_WIDHT 			6
`define NUMB_CHAN 			2
`define FREQ 					60
`define FREQ_RST 				168000//166666
`define FREQ_SET				0 //1 if FREQ=60, 0 if FREQ=50 or 25
`define TYPE 					1 //1 - 640x480 ; 0 - 320x240 
`define PIX_IN_ROW 			640
`define ROW_IN_FRAME 		480

`define PIX_IN_ROW_CLK 		320

`define DELAY_ROW 			20
`define SPI_WIDHT 			16
`define SPI_COUNT  			19
`define SPI_MAX_BYTE 		19
`define TIME_SAVE_FRAME 	670 
`define TIME_START_VGA 		300
`define COUNT_FRAME 			3

`define DELAY_DATAVALID 	9
`define DELAY_MULT      	2

`define MULT_WIDHT 			5

`define MODE_ZERO 			0
`define MODE_MAX 				31 //the maximum numbers of modes 

`define MODE_OUT_VGA       1
`define MODE_OUT_UART		2
`define MODE_OUT_UART_VGA	3


`define VERT_MAX				525
`define HOR_MAX			800


`define MODE_WITHOUT_MEM	0
`define MODE_SAVE_ONE		3
`define MODE_SAVE_PED		5
`define MODE_OUT_ONE_STR   7   //output frame by one line
`define MODE_MINUS_SAVE    9  //subtract the pedestal
`define MODE_OUT_PED_SAVE  11 
`define MODE_OUT_SAVE  		13 
`define MODE_MATH_PED 		15 


`define MODE_RGB 				17
`define MODE_BEAT 			18
`define MODE_CONTR 			19
`define MODE_PED 			   20
`define MODE_MEMORY_EN 		8

`define ID_FRAME          	63594
`define ID_ROW            	63582

`define SUMMER            	32
//different two analog channel must div 2^12

`define CONST_DIFF_CHAN1   4114
`define CONST_DIFF_CHAN2   4078

`define TIME_INTEGRATION 	320

`define BEAT_PIX_POROG     1000


`define BEAT_DEFAULT       400

`define PED_MAX_FRAME 32 //mount frame from fpga count ped

`define MAX_AVERAGE     131072
`define RAZR_AVERAGE     3

