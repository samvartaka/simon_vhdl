-- SIMON 64/128
-- Encryption & decryption test bench
--
-- @Author: Jos Wetzels
-- @Author: Wouter Bokslag
--
--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
  
ENTITY tb_simon IS
END tb_simon;
 
ARCHITECTURE behavior OF tb_simon IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT simon
	port(clk : in std_logic;
	     rst : in std_logic;
	     enc : in std_logic; -- (0 = enc, 1 = dec)
	     key : in std_logic_vector(127 downto 0);
	     block_in : in std_logic_vector(63 downto 0);
	     block_out : out std_logic_vector(63 downto 0));
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '1';
   signal enc : std_logic := '0';

   signal key : std_logic_vector(127 downto 0) := (others => '0');
   signal block_in : std_logic_vector(63 downto 0) := (others => '0');

 	--Outputs
	signal block_out : std_logic_vector(63 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;

   signal clk_generator_finish : STD_LOGIC := '0';
   signal test_bench_finish : STD_LOGIC := '0';
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: simon PORT MAP (
          clk => clk,
          rst => rst,
          enc => enc,
          key => key,
          block_in => block_in,
          block_out => block_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		wait for clk_period/2 + 10*clk_period;

		-- ==============================================
		-- T_0: Test encryption and subsequent decryption
		-- ==============================================

		-- SIMON 64/128 test vectors
		block_in <= X"656b696c20646e75";
		key <= X"1b1a1918131211100b0a090803020100";

		-- Test encryption		
		enc <= '0';

		-- Initialize
		rst <= '1';

		-- Wait for initialization
		wait for clk_period;

		-- Run
		rst <= '0';

		-- Wait for registers
		wait for 43*clk_period;

		assert block_out = X"44c8fc20b9dfa07a"
			report "ENCRYPT ERROR (e_0)" severity FAILURE;
			
		-- Use output of encryption as input for decryption
		block_in <= block_out;

		-- Test decryption		
		enc <= '1';
		
		-- Initialize
		rst <= '1';

		-- Wait for initialization
		wait for clk_period;

		-- Run
		rst <= '0';
		
		-- Wait for registers
		wait for 43*clk_period;

		assert block_out = X"656b696c20646e75"
			report "DECRYPT ERROR (d_0)" severity FAILURE;

	    test_bench_finish <= '1';
		clk_generator_finish <= '1';
		wait for clk_period;
		wait;
   end process;

END;
