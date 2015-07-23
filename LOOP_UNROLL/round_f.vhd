
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
	port(enc : std_logic;
		 v_in : in std_logic_vector(63 downto 0);
	     v_k_e : in std_logic_vector(31 downto 0);
	     v_k_d : in std_logic_vector(31 downto 0);
         v_out : out std_logic_vector(63 downto 0)
         );
end round_f;

architecture Behavioral of round_f is
	signal op_1_s : std_logic_vector(31 downto 0);
	signal op_2_s : std_logic_vector(31 downto 0);
	signal op_8_s : std_logic_vector(31 downto 0);
	
	signal v_l : std_logic_vector(31 downto 0);
	signal v_r : std_logic_vector(31 downto 0);
begin
	-- written out for clarity but this is optimized to single expression by synthesis

	v_l <= v_in(31 downto 0) when enc = '0' else v_in(63 downto 32);
	v_r <= v_in(63 downto 32) when enc = '0' else v_in(31 downto 0);

	-- shifts over left half
	op_1_s <= std_logic_vector(rotate_left(unsigned(v_r), 1));
	op_2_s <= std_logic_vector(rotate_left(unsigned(v_r), 2));
	op_8_s <= std_logic_vector(rotate_left(unsigned(v_r), 8));

	-- xors/ands over subkey and right half
	v_out <= (((op_1_s and op_8_s) xor op_2_s xor v_l xor v_k_e) & v_r) when enc = '0' else (v_r & ((op_1_s and op_8_s) xor op_2_s xor v_l xor v_k_d));

end Behavioral;