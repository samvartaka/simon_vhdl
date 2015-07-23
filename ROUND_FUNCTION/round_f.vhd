
-- SIMON 64/128
-- feistel round function
-- 
-- @Author: Jos Wetzels
-- @Author: Wouter Bokslag
--
-- Parameters:
--       v_in: plaintext block
--        v_k: subkey
--      v_out: ciphertext block
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity round_f is
	port(v_in : in std_logic_vector(63 downto 0);
	     v_k : in std_logic_vector(31 downto 0);
         v_out : out std_logic_vector(63 downto 0)
         );
end round_f;

architecture Behavioral of round_f is
	signal op_1_s : std_logic_vector(31 downto 0);
	signal op_2_s : std_logic_vector(31 downto 0);
	signal op_8_s : std_logic_vector(31 downto 0);
begin
	-- shifts over left half
	op_1_s <= std_logic_vector(rotate_left(unsigned(v_in(63 downto 32)), 1));
	op_2_s <= std_logic_vector(rotate_left(unsigned(v_in(63 downto 32)), 2));
	op_8_s <= std_logic_vector(rotate_left(unsigned(v_in(63 downto 32)), 8));

	-- xors/ands over subkey and right half
	v_out <= ((op_1_s and op_8_s) xor op_2_s xor v_in(31 downto 0) xor v_k) & v_in(63 downto 32);
end Behavioral;