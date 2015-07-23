-- SIMON 64/128
-- feistel round function test bench
-- 
-- @Author: Jos Wetzels
-- @Author: Wouter Bokslag
--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
  
ENTITY tb_round IS
END tb_round;
 
ARCHITECTURE behavior OF tb_round IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
	COMPONENT round_f
	port(v_in : in std_logic_vector(63 downto 0);
	     v_k : in std_logic_vector(31 downto 0);
         v_out : out std_logic_vector(63 downto 0)
         );
	END COMPONENT;
    

	--Inputs
	signal clk : std_logic := '0';
	signal v_k : std_logic_vector(31 downto 0) := (others => '0');	-- Round Key
	signal v_in : std_logic_vector(63 downto 0) := (others => '0'); -- Input block

	--Outputs
	signal v_out : std_logic_vector(63 downto 0);					-- Output block

   -- Clock period definitions
   constant clk_period : time := 10 ns;

   signal clk_generator_finish : STD_LOGIC := '0';
   signal test_bench_finish : STD_LOGIC := '0';
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: round_f PORT MAP (
          v_in => v_in,
          v_k => v_k,
          v_out => v_out
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
		v_in <= X"656B696C20646E75";
		v_k <= X"03020100";

		-- Do round
		wait for clk_period;

		assert v_out = X"FC8B8A84656B696C"
			report "ROUND_F ERROR (r_0)" severity FAILURE;
			
   test_bench_finish <= '1';
	clk_generator_finish <= '1';
	wait for clk_period;
	wait;
   end process;

END;
