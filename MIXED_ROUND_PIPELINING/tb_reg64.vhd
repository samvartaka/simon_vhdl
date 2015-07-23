-- SIMON 64/128
-- reg_64 test bench
-- 
-- @Author: Jos Wetzels
-- @Author: Wouter Bokslag
--

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
  
ENTITY tb_reg_64 IS
END tb_reg_64;
 
ARCHITECTURE behavior OF tb_reg_64 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
	COMPONENT reg_64 is
	port(clk : in std_logic;
	     rst : in std_logic;
		 data_in : in std_logic_vector(63 downto 0);
         data_out : out std_logic_vector(63 downto 0)
         );
	END COMPONENT;
    

	--Inputs
	signal clk : std_logic := '0';
	signal rst : std_logic := '1';
	signal data_in : std_logic_vector(63 downto 0) := (others => '0'); -- input

	--Outputs
	signal data_out : std_logic_vector(63 downto 0);  				   -- output

   -- Clock period definitions
   constant clk_period : time := 10 ns;

   signal clk_generator_finish : STD_LOGIC := '0';
   signal test_bench_finish : STD_LOGIC := '0';
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: reg_64 PORT MAP (
          clk => clk,
          rst => rst,
          data_in => data_in,
          data_out => data_out
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

		rst <= '1';

		wait for clk_period;

		assert data_out = X"0000000000000000"
			report "REG_64 ERROR (r_1)" severity FAILURE;

		rst <= '0';
		data_in <= X"CAFECAFE0BADC0DE";

		wait for clk_period;

		assert data_out = X"CAFECAFE0BADC0DE"
			report "REG_64 ERROR (r_1)" severity FAILURE;
			
   test_bench_finish <= '1';
	clk_generator_finish <= '1';
	wait for clk_period;
	wait;
   end process;

END;
