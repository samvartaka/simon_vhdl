-- SIMON 64/128
-- feistel round function operation phi
-- phi(x) = (((x << 1) & (x << 8)) xor (x << 2))
-- 
-- @Author: Jos Wetzels
-- @Author: Wouter Bokslag
--
-- Parameters:
--       x_in: plaintext block right half
--      x_out: transformed block right half
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity phi is
	port(x_in : in std_logic_vector(31 downto 0);
         x_out : out std_logic_vector(31 downto 0)
         );
end phi;

architecture Behavioral of phi is
	signal op_1_s : std_logic_vector(31 downto 0);
	signal op_2_s : std_logic_vector(31 downto 0);
	signal op_8_s : std_logic_vector(31 downto 0);
begin
	op_1_s <= std_logic_vector(rotate_left(unsigned(x_in), 1));
	op_2_s <= std_logic_vector(rotate_left(unsigned(x_in), 2));
	op_8_s <= std_logic_vector(rotate_left(unsigned(x_in), 8));
	
	x_out <= (op_1_s and op_8_s) xor op_2_s;
end Behavioral;