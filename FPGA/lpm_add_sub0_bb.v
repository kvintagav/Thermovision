// megafunction wizard: %LPM_ADD_SUB%VBB%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: LPM_ADD_SUB 

// ============================================================
// File Name: lpm_add_sub0.v
// Megafunction Name(s):
// 			LPM_ADD_SUB
//
// Simulation Library Files(s):
// 			lpm
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 11.0 Build 157 04/27/2011 SJ Full Version
// ************************************************************

//Copyright (C) 1991-2011 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.

module lpm_add_sub0 (
	add_sub,
	dataa,
	datab,
	result);

	input	  add_sub;
	input	[13:0]  dataa;
	input	[13:0]  datab;
	output	[13:0]  result;

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: CarryIn NUMERIC "0"
// Retrieval info: PRIVATE: CarryOut NUMERIC "0"
// Retrieval info: PRIVATE: ConstantA NUMERIC "0"
// Retrieval info: PRIVATE: ConstantB NUMERIC "0"
// Retrieval info: PRIVATE: Function NUMERIC "2"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
// Retrieval info: PRIVATE: LPM_PIPELINE NUMERIC "0"
// Retrieval info: PRIVATE: Latency NUMERIC "0"
// Retrieval info: PRIVATE: Overflow NUMERIC "0"
// Retrieval info: PRIVATE: RadixA NUMERIC "10"
// Retrieval info: PRIVATE: RadixB NUMERIC "10"
// Retrieval info: PRIVATE: Representation NUMERIC "1"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: ValidCtA NUMERIC "0"
// Retrieval info: PRIVATE: ValidCtB NUMERIC "0"
// Retrieval info: PRIVATE: WhichConstant NUMERIC "0"
// Retrieval info: PRIVATE: aclr NUMERIC "0"
// Retrieval info: PRIVATE: clken NUMERIC "0"
// Retrieval info: PRIVATE: nBit NUMERIC "14"
// Retrieval info: PRIVATE: new_diagram STRING "1"
// Retrieval info: LIBRARY: lpm lpm.lpm_components.all
// Retrieval info: CONSTANT: LPM_DIRECTION STRING "UNUSED"
// Retrieval info: CONSTANT: LPM_HINT STRING "ONE_INPUT_IS_CONSTANT=NO,CIN_USED=NO"
// Retrieval info: CONSTANT: LPM_REPRESENTATION STRING "UNSIGNED"
// Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_ADD_SUB"
// Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "14"
// Retrieval info: USED_PORT: add_sub 0 0 0 0 INPUT NODEFVAL "add_sub"
// Retrieval info: USED_PORT: dataa 0 0 14 0 INPUT NODEFVAL "dataa[13..0]"
// Retrieval info: USED_PORT: datab 0 0 14 0 INPUT NODEFVAL "datab[13..0]"
// Retrieval info: USED_PORT: result 0 0 14 0 OUTPUT NODEFVAL "result[13..0]"
// Retrieval info: CONNECT: @add_sub 0 0 0 0 add_sub 0 0 0 0
// Retrieval info: CONNECT: @dataa 0 0 14 0 dataa 0 0 14 0
// Retrieval info: CONNECT: @datab 0 0 14 0 datab 0 0 14 0
// Retrieval info: CONNECT: result 0 0 14 0 @result 0 0 14 0
// Retrieval info: GEN_FILE: TYPE_NORMAL lpm_add_sub0.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL lpm_add_sub0.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL lpm_add_sub0.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL lpm_add_sub0.bsf TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL lpm_add_sub0_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL lpm_add_sub0_bb.v TRUE
// Retrieval info: LIB_FILE: lpm
