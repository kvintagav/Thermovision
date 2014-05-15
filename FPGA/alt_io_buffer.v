// megafunction wizard: %ALTIOBUF%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altiobuf_bidir 

// ============================================================
// File Name: alt_io_buffer.v
// Megafunction Name(s):
// 			altiobuf_bidir
//
// Simulation Library Files(s):
// 			cycloneive
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


//altiobuf_bidir CBX_AUTO_BLACKBOX="ALL" DEVICE_FAMILY="Cyclone IV E" ENABLE_BUS_HOLD="TRUE" NUMBER_OF_CHANNELS=16 OPEN_DRAIN_OUTPUT="TRUE" USE_DIFFERENTIAL_MODE="FALSE" USE_DYNAMIC_TERMINATION_CONTROL="FALSE" USE_TERMINATION_CONTROL="FALSE" datain dataio dataout oe
//VERSION_BEGIN 11.0 cbx_altiobuf_bidir 2011:04:27:21:07:19:SJ cbx_mgl 2011:04:27:21:11:03:SJ cbx_stratixiii 2011:04:27:21:07:19:SJ cbx_stratixv 2011:04:27:21:07:19:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463


//synthesis_resources = cycloneive_io_ibuf 16 cycloneive_io_obuf 16 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  alt_io_buffer_iobuf_bidir_3to
	( 
	datain,
	dataio,
	dataout,
	oe) ;
	input   [15:0]  datain;
	inout   [15:0]  dataio;
	output   [15:0]  dataout;
	input   [15:0]  oe;

	wire  [15:0]   wire_ibufa_i;
	wire  [15:0]   wire_ibufa_o;
	wire  [15:0]   wire_obufa_i;
	wire  [15:0]   wire_obufa_o;
	wire  [15:0]   wire_obufa_oe;

	cycloneive_io_ibuf   ibufa_0
	( 
	.i(wire_ibufa_i[0:0]),
	.o(wire_ibufa_o[0:0])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.ibar(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		ibufa_0.bus_hold = "true",
		ibufa_0.differential_mode = "false",
		ibufa_0.lpm_type = "cycloneive_io_ibuf";
	cycloneive_io_ibuf   ibufa_1
	( 
	.i(wire_ibufa_i[1:1]),
	.o(wire_ibufa_o[1:1])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.ibar(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		ibufa_1.bus_hold = "true",
		ibufa_1.differential_mode = "false",
		ibufa_1.lpm_type = "cycloneive_io_ibuf";
	cycloneive_io_ibuf   ibufa_2
	( 
	.i(wire_ibufa_i[2:2]),
	.o(wire_ibufa_o[2:2])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.ibar(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		ibufa_2.bus_hold = "true",
		ibufa_2.differential_mode = "false",
		ibufa_2.lpm_type = "cycloneive_io_ibuf";
	cycloneive_io_ibuf   ibufa_3
	( 
	.i(wire_ibufa_i[3:3]),
	.o(wire_ibufa_o[3:3])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.ibar(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		ibufa_3.bus_hold = "true",
		ibufa_3.differential_mode = "false",
		ibufa_3.lpm_type = "cycloneive_io_ibuf";
	cycloneive_io_ibuf   ibufa_4
	( 
	.i(wire_ibufa_i[4:4]),
	.o(wire_ibufa_o[4:4])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.ibar(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		ibufa_4.bus_hold = "true",
		ibufa_4.differential_mode = "false",
		ibufa_4.lpm_type = "cycloneive_io_ibuf";
	cycloneive_io_ibuf   ibufa_5
	( 
	.i(wire_ibufa_i[5:5]),
	.o(wire_ibufa_o[5:5])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.ibar(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		ibufa_5.bus_hold = "true",
		ibufa_5.differential_mode = "false",
		ibufa_5.lpm_type = "cycloneive_io_ibuf";
	cycloneive_io_ibuf   ibufa_6
	( 
	.i(wire_ibufa_i[6:6]),
	.o(wire_ibufa_o[6:6])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.ibar(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		ibufa_6.bus_hold = "true",
		ibufa_6.differential_mode = "false",
		ibufa_6.lpm_type = "cycloneive_io_ibuf";
	cycloneive_io_ibuf   ibufa_7
	( 
	.i(wire_ibufa_i[7:7]),
	.o(wire_ibufa_o[7:7])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.ibar(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		ibufa_7.bus_hold = "true",
		ibufa_7.differential_mode = "false",
		ibufa_7.lpm_type = "cycloneive_io_ibuf";
	cycloneive_io_ibuf   ibufa_8
	( 
	.i(wire_ibufa_i[8:8]),
	.o(wire_ibufa_o[8:8])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.ibar(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		ibufa_8.bus_hold = "true",
		ibufa_8.differential_mode = "false",
		ibufa_8.lpm_type = "cycloneive_io_ibuf";
	cycloneive_io_ibuf   ibufa_9
	( 
	.i(wire_ibufa_i[9:9]),
	.o(wire_ibufa_o[9:9])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.ibar(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		ibufa_9.bus_hold = "true",
		ibufa_9.differential_mode = "false",
		ibufa_9.lpm_type = "cycloneive_io_ibuf";
	cycloneive_io_ibuf   ibufa_10
	( 
	.i(wire_ibufa_i[10:10]),
	.o(wire_ibufa_o[10:10])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.ibar(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		ibufa_10.bus_hold = "true",
		ibufa_10.differential_mode = "false",
		ibufa_10.lpm_type = "cycloneive_io_ibuf";
	cycloneive_io_ibuf   ibufa_11
	( 
	.i(wire_ibufa_i[11:11]),
	.o(wire_ibufa_o[11:11])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.ibar(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		ibufa_11.bus_hold = "true",
		ibufa_11.differential_mode = "false",
		ibufa_11.lpm_type = "cycloneive_io_ibuf";
	cycloneive_io_ibuf   ibufa_12
	( 
	.i(wire_ibufa_i[12:12]),
	.o(wire_ibufa_o[12:12])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.ibar(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		ibufa_12.bus_hold = "true",
		ibufa_12.differential_mode = "false",
		ibufa_12.lpm_type = "cycloneive_io_ibuf";
	cycloneive_io_ibuf   ibufa_13
	( 
	.i(wire_ibufa_i[13:13]),
	.o(wire_ibufa_o[13:13])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.ibar(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		ibufa_13.bus_hold = "true",
		ibufa_13.differential_mode = "false",
		ibufa_13.lpm_type = "cycloneive_io_ibuf";
	cycloneive_io_ibuf   ibufa_14
	( 
	.i(wire_ibufa_i[14:14]),
	.o(wire_ibufa_o[14:14])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.ibar(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		ibufa_14.bus_hold = "true",
		ibufa_14.differential_mode = "false",
		ibufa_14.lpm_type = "cycloneive_io_ibuf";
	cycloneive_io_ibuf   ibufa_15
	( 
	.i(wire_ibufa_i[15:15]),
	.o(wire_ibufa_o[15:15])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.ibar(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		ibufa_15.bus_hold = "true",
		ibufa_15.differential_mode = "false",
		ibufa_15.lpm_type = "cycloneive_io_ibuf";
	assign
		wire_ibufa_i = dataio;
	cycloneive_io_obuf   obufa_0
	( 
	.i(wire_obufa_i[0:0]),
	.o(wire_obufa_o[0:0]),
	.obar(),
	.oe(wire_obufa_oe[0:0])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.seriesterminationcontrol({16{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devoe(1'b1)
	// synopsys translate_on
	);
	defparam
		obufa_0.bus_hold = "true",
		obufa_0.open_drain_output = "true",
		obufa_0.lpm_type = "cycloneive_io_obuf";
	cycloneive_io_obuf   obufa_1
	( 
	.i(wire_obufa_i[1:1]),
	.o(wire_obufa_o[1:1]),
	.obar(),
	.oe(wire_obufa_oe[1:1])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.seriesterminationcontrol({16{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devoe(1'b1)
	// synopsys translate_on
	);
	defparam
		obufa_1.bus_hold = "true",
		obufa_1.open_drain_output = "true",
		obufa_1.lpm_type = "cycloneive_io_obuf";
	cycloneive_io_obuf   obufa_2
	( 
	.i(wire_obufa_i[2:2]),
	.o(wire_obufa_o[2:2]),
	.obar(),
	.oe(wire_obufa_oe[2:2])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.seriesterminationcontrol({16{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devoe(1'b1)
	// synopsys translate_on
	);
	defparam
		obufa_2.bus_hold = "true",
		obufa_2.open_drain_output = "true",
		obufa_2.lpm_type = "cycloneive_io_obuf";
	cycloneive_io_obuf   obufa_3
	( 
	.i(wire_obufa_i[3:3]),
	.o(wire_obufa_o[3:3]),
	.obar(),
	.oe(wire_obufa_oe[3:3])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.seriesterminationcontrol({16{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devoe(1'b1)
	// synopsys translate_on
	);
	defparam
		obufa_3.bus_hold = "true",
		obufa_3.open_drain_output = "true",
		obufa_3.lpm_type = "cycloneive_io_obuf";
	cycloneive_io_obuf   obufa_4
	( 
	.i(wire_obufa_i[4:4]),
	.o(wire_obufa_o[4:4]),
	.obar(),
	.oe(wire_obufa_oe[4:4])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.seriesterminationcontrol({16{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devoe(1'b1)
	// synopsys translate_on
	);
	defparam
		obufa_4.bus_hold = "true",
		obufa_4.open_drain_output = "true",
		obufa_4.lpm_type = "cycloneive_io_obuf";
	cycloneive_io_obuf   obufa_5
	( 
	.i(wire_obufa_i[5:5]),
	.o(wire_obufa_o[5:5]),
	.obar(),
	.oe(wire_obufa_oe[5:5])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.seriesterminationcontrol({16{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devoe(1'b1)
	// synopsys translate_on
	);
	defparam
		obufa_5.bus_hold = "true",
		obufa_5.open_drain_output = "true",
		obufa_5.lpm_type = "cycloneive_io_obuf";
	cycloneive_io_obuf   obufa_6
	( 
	.i(wire_obufa_i[6:6]),
	.o(wire_obufa_o[6:6]),
	.obar(),
	.oe(wire_obufa_oe[6:6])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.seriesterminationcontrol({16{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devoe(1'b1)
	// synopsys translate_on
	);
	defparam
		obufa_6.bus_hold = "true",
		obufa_6.open_drain_output = "true",
		obufa_6.lpm_type = "cycloneive_io_obuf";
	cycloneive_io_obuf   obufa_7
	( 
	.i(wire_obufa_i[7:7]),
	.o(wire_obufa_o[7:7]),
	.obar(),
	.oe(wire_obufa_oe[7:7])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.seriesterminationcontrol({16{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devoe(1'b1)
	// synopsys translate_on
	);
	defparam
		obufa_7.bus_hold = "true",
		obufa_7.open_drain_output = "true",
		obufa_7.lpm_type = "cycloneive_io_obuf";
	cycloneive_io_obuf   obufa_8
	( 
	.i(wire_obufa_i[8:8]),
	.o(wire_obufa_o[8:8]),
	.obar(),
	.oe(wire_obufa_oe[8:8])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.seriesterminationcontrol({16{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devoe(1'b1)
	// synopsys translate_on
	);
	defparam
		obufa_8.bus_hold = "true",
		obufa_8.open_drain_output = "true",
		obufa_8.lpm_type = "cycloneive_io_obuf";
	cycloneive_io_obuf   obufa_9
	( 
	.i(wire_obufa_i[9:9]),
	.o(wire_obufa_o[9:9]),
	.obar(),
	.oe(wire_obufa_oe[9:9])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.seriesterminationcontrol({16{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devoe(1'b1)
	// synopsys translate_on
	);
	defparam
		obufa_9.bus_hold = "true",
		obufa_9.open_drain_output = "true",
		obufa_9.lpm_type = "cycloneive_io_obuf";
	cycloneive_io_obuf   obufa_10
	( 
	.i(wire_obufa_i[10:10]),
	.o(wire_obufa_o[10:10]),
	.obar(),
	.oe(wire_obufa_oe[10:10])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.seriesterminationcontrol({16{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devoe(1'b1)
	// synopsys translate_on
	);
	defparam
		obufa_10.bus_hold = "true",
		obufa_10.open_drain_output = "true",
		obufa_10.lpm_type = "cycloneive_io_obuf";
	cycloneive_io_obuf   obufa_11
	( 
	.i(wire_obufa_i[11:11]),
	.o(wire_obufa_o[11:11]),
	.obar(),
	.oe(wire_obufa_oe[11:11])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.seriesterminationcontrol({16{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devoe(1'b1)
	// synopsys translate_on
	);
	defparam
		obufa_11.bus_hold = "true",
		obufa_11.open_drain_output = "true",
		obufa_11.lpm_type = "cycloneive_io_obuf";
	cycloneive_io_obuf   obufa_12
	( 
	.i(wire_obufa_i[12:12]),
	.o(wire_obufa_o[12:12]),
	.obar(),
	.oe(wire_obufa_oe[12:12])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.seriesterminationcontrol({16{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devoe(1'b1)
	// synopsys translate_on
	);
	defparam
		obufa_12.bus_hold = "true",
		obufa_12.open_drain_output = "true",
		obufa_12.lpm_type = "cycloneive_io_obuf";
	cycloneive_io_obuf   obufa_13
	( 
	.i(wire_obufa_i[13:13]),
	.o(wire_obufa_o[13:13]),
	.obar(),
	.oe(wire_obufa_oe[13:13])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.seriesterminationcontrol({16{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devoe(1'b1)
	// synopsys translate_on
	);
	defparam
		obufa_13.bus_hold = "true",
		obufa_13.open_drain_output = "true",
		obufa_13.lpm_type = "cycloneive_io_obuf";
	cycloneive_io_obuf   obufa_14
	( 
	.i(wire_obufa_i[14:14]),
	.o(wire_obufa_o[14:14]),
	.obar(),
	.oe(wire_obufa_oe[14:14])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.seriesterminationcontrol({16{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devoe(1'b1)
	// synopsys translate_on
	);
	defparam
		obufa_14.bus_hold = "true",
		obufa_14.open_drain_output = "true",
		obufa_14.lpm_type = "cycloneive_io_obuf";
	cycloneive_io_obuf   obufa_15
	( 
	.i(wire_obufa_i[15:15]),
	.o(wire_obufa_o[15:15]),
	.obar(),
	.oe(wire_obufa_oe[15:15])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.seriesterminationcontrol({16{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devoe(1'b1)
	// synopsys translate_on
	);
	defparam
		obufa_15.bus_hold = "true",
		obufa_15.open_drain_output = "true",
		obufa_15.lpm_type = "cycloneive_io_obuf";
	assign
		wire_obufa_i = datain,
		wire_obufa_oe = oe;
	assign
		dataio = wire_obufa_o,
		dataout = wire_ibufa_o;
endmodule //alt_io_buffer_iobuf_bidir_3to
//VALID FILE


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module alt_io_buffer (
	datain,
	oe,
	dataio,
	dataout);

	input	[15:0]  datain;
	input	[15:0]  oe;
	inout	[15:0]  dataio;
	output	[15:0]  dataout;

	wire [15:0] sub_wire0;
	wire [15:0] dataout = sub_wire0[15:0];

	alt_io_buffer_iobuf_bidir_3to	alt_io_buffer_iobuf_bidir_3to_component (
				.dataio (dataio),
				.datain (datain),
				.oe (oe),
				.dataout (sub_wire0));

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
// Retrieval info: CONSTANT: enable_bus_hold STRING "TRUE"
// Retrieval info: CONSTANT: number_of_channels NUMERIC "16"
// Retrieval info: CONSTANT: open_drain_output STRING "TRUE"
// Retrieval info: CONSTANT: use_differential_mode STRING "FALSE"
// Retrieval info: CONSTANT: use_dynamic_termination_control STRING "FALSE"
// Retrieval info: CONSTANT: use_termination_control STRING "FALSE"
// Retrieval info: USED_PORT: datain 0 0 16 0 INPUT NODEFVAL "datain[15..0]"
// Retrieval info: USED_PORT: dataio 0 0 16 0 BIDIR NODEFVAL "dataio[15..0]"
// Retrieval info: USED_PORT: dataout 0 0 16 0 OUTPUT NODEFVAL "dataout[15..0]"
// Retrieval info: USED_PORT: oe 0 0 16 0 INPUT NODEFVAL "oe[15..0]"
// Retrieval info: CONNECT: @datain 0 0 16 0 datain 0 0 16 0
// Retrieval info: CONNECT: @oe 0 0 16 0 oe 0 0 16 0
// Retrieval info: CONNECT: dataio 0 0 16 0 @dataio 0 0 16 0
// Retrieval info: CONNECT: dataout 0 0 16 0 @dataout 0 0 16 0
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_io_buffer.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_io_buffer.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_io_buffer.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_io_buffer.bsf TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_io_buffer_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL alt_io_buffer_bb.v TRUE
// Retrieval info: LIB_FILE: cycloneive