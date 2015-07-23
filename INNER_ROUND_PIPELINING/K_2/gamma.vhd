-- SIMON 64/128
-- feistel round function operation gamma
-- gamma(x,y) = (x xor y)
-- 
-- @Author: Jos Wetzels
-- @Author: Wouter Bokslag
--
-- Parameters:
--       x_in: half block 1
--       y_in: half block 2
--      x_out: xor of both inputs
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity gamma is
	port(x_in : in std_logic_vector(31 downto 0);
		 y_in : in std_logic_vector(31 downto 0);
         x_out : out std_logic_vector(31 downto 0)
         );
end gamma;

architecture Behavioral of gamma is
begin	
	x_out <= x_in xor y_in;
end Behavioral;