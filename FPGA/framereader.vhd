-- megafunction wizard: %Frame Reader v11.0%
-- GENERATION: XML
-- framereader.vhd

-- 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity framereader is
	port (
		clock                : in  std_logic                      := '0';             --             clock_reset.clk
		reset                : in  std_logic                      := '0';             --       clock_reset_reset.reset
		master_clock         : in  std_logic                      := '0';             --            clock_master.clk
		master_reset         : in  std_logic                      := '0';             --      clock_master_reset.reset
		slave_address        : in  std_logic_vector(4 downto 0)   := (others => '0'); --            avalon_slave.address
		slave_write          : in  std_logic                      := '0';             --                        .write
		slave_writedata      : in  std_logic_vector(31 downto 0)  := (others => '0'); --                        .writedata
		slave_read           : in  std_logic                      := '0';             --                        .read
		slave_readdata       : out std_logic_vector(31 downto 0);                     --                        .readdata
		slave_irq            : out std_logic;                                         --        interrupt_sender.irq
		dout_data            : out std_logic_vector(23 downto 0);                     -- avalon_streaming_source.data
		dout_valid           : out std_logic;                                         --                        .valid
		dout_ready           : in  std_logic                      := '0';             --                        .ready
		dout_startofpacket   : out std_logic;                                         --                        .startofpacket
		dout_endofpacket     : out std_logic;                                         --                        .endofpacket
		master_address       : out std_logic_vector(31 downto 0);                     --           avalon_master.address
		master_burstcount    : out std_logic_vector(5 downto 0);                      --                        .burstcount
		master_readdata      : in  std_logic_vector(255 downto 0) := (others => '0'); --                        .readdata
		master_read          : out std_logic;                                         --                        .read
		master_readdatavalid : in  std_logic                      := '0';             --                        .readdatavalid
		master_waitrequest   : in  std_logic                      := '0'              --                        .waitrequest
	);
end entity framereader;

architecture rtl of framereader is
	component alt_vipvfr110_vfr is
		generic (
			BITS_PER_PIXEL_PER_COLOR_PLANE : integer := 8;
			NUMBER_OF_CHANNELS_IN_PARALLEL : integer := 3;
			NUMBER_OF_CHANNELS_IN_SEQUENCE : integer := 1;
			MAX_IMAGE_WIDTH                : integer := 640;
			MAX_IMAGE_HEIGHT               : integer := 480;
			MEM_PORT_WIDTH                 : integer := 256;
			RMASTER_FIFO_DEPTH             : integer := 64;
			RMASTER_BURST_TARGET           : integer := 32;
			CLOCKS_ARE_SEPARATE            : integer := 1
		);
		port (
			clock                : in  std_logic                      := 'X';             -- clk
			reset                : in  std_logic                      := 'X';             -- reset
			master_clock         : in  std_logic                      := 'X';             -- clk
			master_reset         : in  std_logic                      := 'X';             -- reset
			slave_address        : in  std_logic_vector(4 downto 0)   := (others => 'X'); -- address
			slave_write          : in  std_logic                      := 'X';             -- write
			slave_writedata      : in  std_logic_vector(31 downto 0)  := (others => 'X'); -- writedata
			slave_read           : in  std_logic                      := 'X';             -- read
			slave_readdata       : out std_logic_vector(31 downto 0);                     -- readdata
			slave_irq            : out std_logic;                                         -- irq
			dout_data            : out std_logic_vector(23 downto 0);                     -- data
			dout_valid           : out std_logic;                                         -- valid
			dout_ready           : in  std_logic                      := 'X';             -- ready
			dout_startofpacket   : out std_logic;                                         -- startofpacket
			dout_endofpacket     : out std_logic;                                         -- endofpacket
			master_address       : out std_logic_vector(31 downto 0);                     -- address
			master_burstcount    : out std_logic_vector(5 downto 0);                      -- burstcount
			master_readdata      : in  std_logic_vector(255 downto 0) := (others => 'X'); -- readdata
			master_read          : out std_logic;                                         -- read
			master_readdatavalid : in  std_logic                      := 'X';             -- readdatavalid
			master_waitrequest   : in  std_logic                      := 'X'              -- waitrequest
		);
	end component alt_vipvfr110_vfr;

begin

	framereader_inst : component alt_vipvfr110_vfr
		generic map (
			BITS_PER_PIXEL_PER_COLOR_PLANE => 8,
			NUMBER_OF_CHANNELS_IN_PARALLEL => 3,
			NUMBER_OF_CHANNELS_IN_SEQUENCE => 1,
			MAX_IMAGE_WIDTH                => 640,
			MAX_IMAGE_HEIGHT               => 480,
			MEM_PORT_WIDTH                 => 256,
			RMASTER_FIFO_DEPTH             => 64,
			RMASTER_BURST_TARGET           => 32,
			CLOCKS_ARE_SEPARATE            => 1
		)
		port map (
			clock                => clock,                --             clock_reset.clk
			reset                => reset,                --       clock_reset_reset.reset
			master_clock         => master_clock,         --            clock_master.clk
			master_reset         => master_reset,         --      clock_master_reset.reset
			slave_address        => slave_address,        --            avalon_slave.address
			slave_write          => slave_write,          --                        .write
			slave_writedata      => slave_writedata,      --                        .writedata
			slave_read           => slave_read,           --                        .read
			slave_readdata       => slave_readdata,       --                        .readdata
			slave_irq            => slave_irq,            --        interrupt_sender.irq
			dout_data            => dout_data,            -- avalon_streaming_source.data
			dout_valid           => dout_valid,           --                        .valid
			dout_ready           => dout_ready,           --                        .ready
			dout_startofpacket   => dout_startofpacket,   --                        .startofpacket
			dout_endofpacket     => dout_endofpacket,     --                        .endofpacket
			master_address       => master_address,       --           avalon_master.address
			master_burstcount    => master_burstcount,    --                        .burstcount
			master_readdata      => master_readdata,      --                        .readdata
			master_read          => master_read,          --                        .read
			master_readdatavalid => master_readdatavalid, --                        .readdatavalid
			master_waitrequest   => master_waitrequest    --                        .waitrequest
		);

end architecture rtl; -- of framereader
-- Retrieval info: <?xml version="1.0"?>
--<!--
--	Generated by Altera MegaWizard Launcher Utility version 1.0
--	************************************************************
--	THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--	************************************************************
--	Copyright (C) 1991-2013 Altera Corporation
--	Any megafunction design, and related net list (encrypted or decrypted),
--	support information, device programming or simulation file, and any other
--	associated documentation or information provided by Altera or a partner
--	under Altera's Megafunction Partnership Program may be used only to
--	program PLD devices (but not masked PLD devices) from Altera.  Any other
--	use of such megafunction design, net list, support information, device
--	programming or simulation file, or any other related documentation or
--	information is prohibited for any other purpose, including, but not
--	limited to modification, reverse engineering, de-compiling, or use with
--	any other silicon devices, unless such use is explicitly licensed under
--	a separate agreement with Altera or a megafunction partner.  Title to
--	the intellectual property, including patents, copyrights, trademarks,
--	trade secrets, or maskworks, embodied in any such megafunction design,
--	net list, support information, device programming or simulation file, or
--	any other related documentation or information provided by Altera or a
--	megafunction partner, remains with Altera, the megafunction partner, or
--	their respective licensors.  No other licenses, including any licenses
--	needed under any third party's intellectual property, are provided herein.
---->
-- Retrieval info: <instance entity-name="alt_vip_vfr" version="11.0" >
-- Retrieval info: 	<generic name="BITS_PER_PIXEL_PER_COLOR_PLANE" value="8" />
-- Retrieval info: 	<generic name="NUMBER_OF_CHANNELS_IN_PARALLEL" value="3" />
-- Retrieval info: 	<generic name="NUMBER_OF_CHANNELS_IN_SEQUENCE" value="1" />
-- Retrieval info: 	<generic name="MAX_IMAGE_WIDTH" value="640" />
-- Retrieval info: 	<generic name="MAX_IMAGE_HEIGHT" value="480" />
-- Retrieval info: 	<generic name="MEM_PORT_WIDTH" value="256" />
-- Retrieval info: 	<generic name="RMASTER_FIFO_DEPTH" value="64" />
-- Retrieval info: 	<generic name="RMASTER_BURST_TARGET" value="32" />
-- Retrieval info: 	<generic name="CLOCKS_ARE_SEPARATE" value="1" />
-- Retrieval info: 	<generic name="AUTO_CLOCK_RESET_CLOCK_RATE" value="-1" />
-- Retrieval info: 	<generic name="AUTO_CLOCK_MASTER_CLOCK_RATE" value="-1" />
-- Retrieval info: 	<generic name="AUTO_DEVICE_FAMILY" value="Cyclone IV E" />
-- Retrieval info: </instance>
-- IPFS_FILES : framereader.vho
-- RELATED_FILES: framereader.vhd, alt_vipvfr110_vfr.v, alt_vipvfr110_vfr_controller.v, alt_vipvfr110_vfr_control_packet_encoder.v, alt_vipvfr110_prc.v, alt_vipvfr110_prc_core.v, alt_vipvfr110_prc_read_master.v, alt_vipvfr110_common_package.vhd, alt_vipvfr110_common_avalon_mm_bursting_master_fifo.vhd, alt_vipvfr110_common_avalon_mm_master.v, alt_vipvfr110_common_unpack_data.v, alt_vipvfr110_common_avalon_mm_slave.v, alt_vipvfr110_common_stream_output.v, alt_vipvfr110_common_pulling_width_adapter.vhd, alt_vipvfr110_common_general_fifo.vhd, alt_vipvfr110_common_fifo_usedw_calculator.vhd, alt_vipvfr110_common_gray_clock_crosser.vhd, alt_vipvfr110_common_std_logic_vector_delay.vhd, alt_vipvfr110_common_one_bit_delay.vhd, alt_vipvfr110_common_logic_fifo.vhd, alt_vipvfr110_common_ram_fifo.vhd
