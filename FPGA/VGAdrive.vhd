Library IEEE;
use IEEE.STD_Logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity VGAdrive is
  port( clock       : in std_logic;  -- 25 Mhz clock
        reset       : in std_logic;  -- reset
		  enable      : in std_logic;  -- enable
        row, column : out std_logic_vector(9 downto 0); -- for current pixel
        H, V,BUFER,RESET_BL,BUFER_CHANGE,READ_OUT_EN        : out std_logic  -- VGA drive signals
		  
        );
  -- The signals Rout, Gout, Bout, H and V are output to the monitor.
  -- The row and column outputs are used to know when to assert red,
  -- green and blue to color the current pixel.  For VGA, the column
  -- values that are valid are from 0 to 639, all other values should
  -- be ignored.  The row values that are valid are from 0 to 479 and
  -- again, all other values are ignored.  To turn on a pixel on the
  -- VGA monitor, some combination of red, green and blue should be
  -- asserted before the rising edge of the clock.  Objects which are
  -- displayed on the monitor, assert their combination of red, green and
  -- blue when they detect the row and column values are within their
  -- range.  For multiple objects sharing a screen, they must be combined
  -- using logic to create single red, green, and blue signals.
end;

architecture behaviour1 of VGAdrive is
  -- clock period = 40 ns; the constants are integer multiples of the
  -- clock frequency and are close but not exact
  -- row counter will go from 0 to 524; column counter from 0 to 799
  subtype counter is std_logic_vector(9 downto 0);
  constant B : natural := 96;  -- Sync pulcs: 3.77 us
  constant C : natural := 48;  -- Back porch: 1.89 us
  constant D : natural := 640; -- horizontal columns: 25.17 us
  constant E : natural := 16;  -- front porch: 0.94 us
  constant A : natural := B + C + D + E;  --=850 one horizontal sync cycle: 31.77 us 
  constant P : natural := 2;   -- vertical blank: 64 us
  constant Q : natural := 33;  -- front guard: 1.02 ms
  constant R : natural := 480; -- vertical rows: 15.25 ms
  constant S : natural := 10;  -- rear guard: 0.35 ms
  constant O : natural := P + Q + R + S;  -- one vertical sync cycle: 16.6 ms
	signal change : std_logic;	
	
begin
	
  process(clock, reset)
    variable vertical, horizontal, counter_row: counter;  -- define counters
  begin
    if reset = '1' then
      vertical := (others => '0');
      horizontal := (others => '0');
		counter_row := (others => '0');
		change<='0';
		--WRITE_EN_FROM_VGA<='1';
	  elsif rising_edge(clock) then
		if enable='1' then
  -- increment counters
			if  horizontal < A - 1  then
			   horizontal := horizontal + 1;
				RESET_BL<='0';
			else
			   horizontal := (others => '0');
			   change<= not change;
		   	if  vertical < O - 1  then -- less than oh
				  vertical := vertical + 1;
				  	
			   else
				  vertical := (others => '0');       -- is set to zero
			 	  RESET_BL<='1';
				  counter_row:= (others => '0');
			   end if;
			end if;

	  -- define H pulse
			if  horizontal >= 0  and  horizontal <  B  then
			  H <= '0';
			else
			  H <= '1';
			end if;

	  -- define V pulse
			if  vertical >= 0  and  vertical <  P  then
			  V <= '0';
			else
			  V <= '1';
			end if;
		
--	if vertical=(P+Q-1) and horizontal=0 then
	--			READ_OUT_EN<='1';
		--	else 
--				READ_OUT_EN<='0';
	--		end if;
			
			if vertical>=(P+Q) and vertical<(P+Q+R-1) and horizontal=0 then
				counter_row :=counter_row+1 ;
			end if;
		
		
			
			
			 
			if vertical>=(P+Q-1) and vertical<(P+Q+R-1) and horizontal=0 then
				READ_OUT_EN<='1';
				
			else 
				READ_OUT_EN<='0';
			end if;
			 
			
			if vertical>=(P+Q) and vertical<(P+Q+R) and horizontal>=(B+C)  and  horizontal<(B+C+D) then
				BUFER<='1';
			else 
				BUFER<='0';
			end if;
			
			
			 -- mapping of the variable to the signals
			 -- negative signs are because the conversion bits are reversed
			 row <= counter_row;
			 column <= horizontal;
			 BUFER_CHANGE<=change;
		else
		H<='0';
		V<='0';
		BUFER<='0';
		RESET_BL<='0';
		BUFER_CHANGE<='0';
		READ_OUT_EN<='0'; 
		

		end if;
	end if;
  end process;

end architecture;

