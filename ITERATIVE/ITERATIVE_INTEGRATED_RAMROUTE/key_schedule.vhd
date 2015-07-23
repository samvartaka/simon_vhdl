
-- SIMON 64/128
-- key scheduling function
--
-- @Author: Jos Wetzels
-- @Author: Wouter Bokslag
--
-- Parameters:
--          r: round index
--     k_0..k_3: key
-- subkey_out: round subkey
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity key_schedule is
       	port (
       		  r : in std_logic_vector(7 downto 0);
       		  -- we don't need k_2 here because of the way we schedule k(r) in the simon component
		      k_0 : in std_logic_vector(31 downto 0);
		      k_1 : in std_logic_vector(31 downto 0);
		      k_3 : in std_logic_vector(31 downto 0);
		      subkey_out : out std_logic_vector(31 downto 0));
end key_schedule;

architecture Behavioral of key_schedule is
	signal op_3_s : std_logic_vector(31 downto 0);
	signal op_xor_0 : std_logic_vector(31 downto 0);
	signal op_1_s : std_logic_vector(31 downto 0);
	signal seqC : std_logic_vector(31 downto 0);
	signal sequence : std_logic_vector(61 downto 0);
begin
	-- C ^ sequence[(r-4) % 62]
	sequence <= "11110000101100111001010001001000000111101001100011010111011011"; -- z3
	
	-- 0xFFFFFFFFFFFFFFFC xor sequence[(r-4) % 62]
	-- TODO: 1-bit latch for seqC(0) is used, not recommended...
	seqC <= ("1111111111111111111111111111110" & sequence((to_integer(unsigned(r)) - 4) mod 62)) when (to_integer(unsigned(r)) > 3) else ("11111111111111111111111111111100");

	-- tmp = K[3] >> 3
	op_3_s <= std_logic_vector(rotate_right(unsigned(k_3), 3));

	-- tmp = tmp xor k[1]
	op_xor_0 <= (op_3_s xor k_1);

	-- tmp >> 1
	op_1_s <= std_logic_vector(rotate_right(unsigned(op_xor_0), 1));

	-- Original NSA specification lists ~K[0] ^ 3 but this can be rewritten to K[0] ^ ((1 << word_size)-4) where the latter can be stored as a constant for speed

	subkey_out <= k_0 when (to_integer(unsigned(r)) < 4) else (op_1_s xor op_xor_0 xor k_0 xor seqC);

end Behavioral;