-- Implementing a Continuous �Jet� Colormap Function

Library IEEE;
use IEEE.STD_Logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity jet is
  port(
       en      : in std_logic;
       Y       : in std_logic_vector(13 downto 0);
       R, G, B : out std_logic_vector(9 downto 0);
		 MODE_FPGA: in std_logic_vector (31 downto 0)
       );
end entity;

architecture jet_arch of jet is

begin

  RGB : process(Y, en)
    variable tmp1: std_logic_vector(15 downto 0);
    variable tmp2: std_logic_vector(16 downto 0);
    
  begin
    if en = '1' then
		if MODE_FPGA(17)='1' then
		  
			case  Y(13 downto 11) is
			when "000" =>
			  R <= (others => '0');
			  G <= (others => '0');
			  tmp1 := Y&"00"+"0010000000000000"; -- b = 4y + 0.5
			  B <= tmp1(13 downto 4);
			when "001"|"010" =>
			  R <= (others => '0');
			  tmp1 := Y&"00"-"0010000000000000"; -- g = 4y - 0.5
			  G <= tmp1(13 downto 4);
			  B <= (others => '1');
			when "011"|"100" =>
			  tmp1 := Y&"00"-"0110000000000000"; -- r = 4y - 1.5
			  R <= tmp1(13 downto 4);
			  G <= (others => '1');
			  tmp2 :=  not ("0"&Y&"00") + "01010000000000000"; -- b = -4y + 2.5
			  B <= tmp2(13 downto 4);
			when "101"|"110" =>
			  R <= (others => '1');
			  tmp2 :=  not ("0"&Y&"00") + "01110000000000000"; -- g = -4y + 3.5
			  G <= tmp2(13 downto 4);
			  B <= (others => '0');
			when "111" =>
			  tmp2 :=  not ("0"&Y&"00") + "10010000000000000"; -- r = -4y + 4.5
			  R <= tmp2(13 downto 4);
			  G <= (others => '0');
			  B <= (others => '0');
		  end case;
		else
		  R <= Y(13 downto 4);
        G <= Y(13 downto 4);
        B <= Y(13 downto 4);	
		end if;
    else
        R <= (others => '0');
        G <= (others => '0');
        B <= (others => '0');
    end if;
  end process;

end architecture;
