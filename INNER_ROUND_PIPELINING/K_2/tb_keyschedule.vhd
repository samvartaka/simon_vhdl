-- SIMON 64/128
-- key schedule test bench
-- 
-- @Author: Jos Wetzels
-- @Author: Wouter Bokslag
--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.NUMERIC_STD.ALL;
  
ENTITY tb_keyschedule IS
END tb_keyschedule;
 
ARCHITECTURE behavior OF tb_keyschedule IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
	COMPONENT key_schedule
       	port (
       		  r : in std_logic_vector(7 downto 0);
		      k_0 : in std_logic_vector(31 downto 0);
		      k_1 : in std_logic_vector(31 downto 0);
		      k_3 : in std_logic_vector(31 downto 0);
		      subkey_out : out std_logic_vector(31 downto 0));
	END COMPONENT;    

	--Inputs
	signal clk : std_logic := '0';
    signal r : std_logic_vector(7 downto 0);		-- round index
	
	type key_t is array (0 to 3) of std_logic_vector(31 downto 0);
	signal key_s : key_t; -- k0..3

	--Outputs
	signal subkey_out : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;

   signal clk_generator_finish : STD_LOGIC := '0';
   signal test_bench_finish : STD_LOGIC := '0';
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: key_schedule PORT MAP (
          r => r,
          k_0 => key_s(0),
          k_1 => key_s(1),
          k_3 => key_s(3),
          subkey_out => subkey_out
        );

   -- Clock process definitions
	clock : process
	begin
	    while ( clk_generator_finish /= '1') loop
	       clk <= not clk;
	       wait for clk_period/2;
	    end loop;
	    wait;
	end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		wait for clk_period/2 + 10*clk_period;

		-- SIMON 64/128 test vectors
		key_s(0) <= X"03020100";
		key_s(1) <= X"0b0a0908";
		key_s(2) <= X"13121110";
		key_s(3) <= X"1b1a1918";

		r <= X"00";
		wait for clk_period;

		assert subkey_out = X"70a011c3"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"b770ec49"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"57e3e835"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"d397bc42"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"94dcf81f"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"bf4b5f18"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"8e5dabb9"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"dbf4a863"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"cd0c28fc"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"5cb69911"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"79f112a5"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"77205863"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"99880c12"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"1ce97c58"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"c8ed2145"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"b800dbb8"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"e86a2756"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"7c06d4dd"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"ab52df0a"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"247f66a8"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"53587ca6"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"d25c13f1"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"4583b64b"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"7d9c960d"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"efbfc2f3"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"89ed8513"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"308dfc4e"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"bf1a2a36"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"e1499d70"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"4ce4d2ff"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"32b7ebef"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"c47505c1"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"d0e929e8"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"8fe484b9"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"42054bee"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"af77bae2"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"18199c02"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"719e3f1c"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"0c1cf793"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		key_s(0) <= key_s(1);
		key_s(1) <= key_s(2);
		key_s(2) <= key_s(3);
		key_s(3) <= subkey_out;

		r <= std_logic_vector(unsigned(r) + 1);
		wait for clk_period;

		assert subkey_out = X"15df4696"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

   test_bench_finish <= '1';
	clk_generator_finish <= '1';
	wait for clk_period;
	wait;
   end process;

END;
