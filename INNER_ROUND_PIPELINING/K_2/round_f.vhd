
-- SIMON 64/128
-- feistel round function
-- Inner-round pipelining using negative-edge triggered registers
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
	port(clk : in std_logic;
	     rst : in std_logic;

	     v_in : in std_logic_vector(63 downto 0);
	     v_k : in std_logic_vector(31 downto 0);
         v_out : out std_logic_vector(63 downto 0)

         );
end round_f;

architecture Behavioral of round_f is
	signal op_0_s : std_logic_vector(31 downto 0);
	signal op_1_s : std_logic_vector(31 downto 0);
	signal op_2_s : std_logic_vector(31 downto 0);

	signal stage_0_out_s : std_logic_vector(31 downto 0);
	signal stage_1_out_s : std_logic_vector(31 downto 0);

	component phi is
		port(x_in : in std_logic_vector(31 downto 0);
			 x_out : out std_logic_vector(31 downto 0));
		end component;

	component gamma is
		port(x_in : in std_logic_vector(31 downto 0);
		 	 y_in : in std_logic_vector(31 downto 0);
         	 x_out : out std_logic_vector(31 downto 0));				  
		end component;

	component neg_reg_32 is
		port(clk : in std_logic;
		     rst : in std_logic;
			 data_in : in std_logic_vector(31 downto 0);
	         data_out : out std_logic_vector(31 downto 0));		  
		end component;
begin

	PHI_0 : phi port map (v_in(63 downto 32), op_0_s);

	REG_STAGE_0 : neg_reg_32 port map (clk, rst, op_0_s, stage_0_out_s);

	GAMMA_0 : gamma port map (v_in(31 downto 0), v_k, op_1_s);

	REG_STAGE_1 : neg_reg_32 port map (clk, rst, op_1_s, stage_1_out_s);

	GAMMA_1 : gamma port map (stage_0_out_s, stage_1_out_s, op_2_s);

	v_out <= op_2_s & v_in(63 downto 32);
end Behavioral;