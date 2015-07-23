-- SIMON 64/128
-- feistel round function operation gamma test bench
-- 
-- @Author: Jos Wetzels
-- @Author: Wouter Bokslag
--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
  
ENTITY tb_gamma IS
END tb_gamma;
 
ARCHITECTURE behavior OF tb_gamma IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
	COMPONENT gamma is
	port(x_in : in std_logic_vector(31 downto 0);
		 y_in : in std_logic_vector(31 downto 0);
         x_out : out std_logic_vector(31 downto 0)
         );
	END COMPONENT;
    

	--Inputs
	signal clk : std_logic := '0';
	signal x_in : std_logic_vector(31 downto 0) := (others => '0'); -- input 1
	signal y_in : std_logic_vector(31 downto 0) := (others => '0'); -- input 2

	--Outputs
	signal x_out : std_logic_vector(31 downto 0);  				   -- Output block

   -- Clock period definitions
   constant clk_period : time := 10 ns;

   signal clk_generator_finish : STD_LOGIC := '0';
   signal test_bench_finish : STD_LOGIC := '0';
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: gamma PORT MAP (
          x_in => x_in,
          y_in => y_in,
          x_out => x_out
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

		x_in <= X"CAFECAFE";
		y_in <= x"FACEFACE";

		wait for clk_period;

		assert x_out = X"30303030"
			report "GAMMA ERROR (r_0)" severity FAILURE;
			
   test_bench_finish <= '1';
	clk_generator_finish <= '1';
	wait for clk_period;
	wait;
   end process;

END;
