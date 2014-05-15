 -- This file uses the VGA driver and creates 3 squares on the screen which
 -- show all the available colors from mixing red, green and blue

Library IEEE;
use IEEE.STD_Logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity vgatest is
  port(clock         : in std_logic;
       row, column : in std_logic_vector(9 downto 0);
       R, G, B : out std_logic_vector(5 downto 0)
       );
end entity;

architecture test of vgatest is

begin

  -- red square from 0,0 to 360, 350
  -- green square from 0,250 to 360, 640
  -- blue square from 120,150 to 480,500
  RGB : process(row, column)
  begin
    -- wait until clock = '1';

    if  row < 360 and column < 350  then
      R <= (others => '1');
    else
      R <= (others => '0');
    end if;

    if  row < 360 and column > 250 and column < 640  then
      G <= (others => '1');
    else
      G <= (others => '0');
    end if;

    if  row > 120 and row < 480 and column > 150 and column < 500  then
      B <= (others => '1');
    else
      B <= (others => '0');
    end if;

  end process;

end architecture;