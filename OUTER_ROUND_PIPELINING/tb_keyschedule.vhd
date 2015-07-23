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
		      k_in_0 : in std_logic_vector(31 downto 0);
				k_in_1 : in std_logic_vector(31 downto 0);
		      k_in_2 : in std_logic_vector(31 downto 0);
		      k_in_3 : in std_logic_vector(31 downto 0);
		      k_0 : out std_logic_vector(31 downto 0);
				k_1 : out std_logic_vector(31 downto 0);
				k_2 : out std_logic_vector(31 downto 0);
				k_3 : out std_logic_vector(31 downto 0);
				k_4 : out std_logic_vector(31 downto 0);
				k_5 : out std_logic_vector(31 downto 0);
				k_6 : out std_logic_vector(31 downto 0);
				k_7 : out std_logic_vector(31 downto 0);
				k_8 : out std_logic_vector(31 downto 0);
				k_9 : out std_logic_vector(31 downto 0);
				k_10 : out std_logic_vector(31 downto 0);
				k_11 : out std_logic_vector(31 downto 0);
				k_12 : out std_logic_vector(31 downto 0);
				k_13 : out std_logic_vector(31 downto 0);
				k_14 : out std_logic_vector(31 downto 0);
				k_15 : out std_logic_vector(31 downto 0);
				k_16 : out std_logic_vector(31 downto 0);
				k_17 : out std_logic_vector(31 downto 0);
				k_18 : out std_logic_vector(31 downto 0);
				k_19 : out std_logic_vector(31 downto 0);
				k_20 : out std_logic_vector(31 downto 0);
				k_21 : out std_logic_vector(31 downto 0);
				k_22 : out std_logic_vector(31 downto 0);
				k_23 : out std_logic_vector(31 downto 0);
				k_24 : out std_logic_vector(31 downto 0);
				k_25 : out std_logic_vector(31 downto 0);
				k_26 : out std_logic_vector(31 downto 0);
				k_27 : out std_logic_vector(31 downto 0);
				k_28 : out std_logic_vector(31 downto 0);
				k_29 : out std_logic_vector(31 downto 0);
				k_30 : out std_logic_vector(31 downto 0);
				k_31 : out std_logic_vector(31 downto 0);
				k_32 : out std_logic_vector(31 downto 0);
				k_33 : out std_logic_vector(31 downto 0);
				k_34 : out std_logic_vector(31 downto 0);
				k_35 : out std_logic_vector(31 downto 0);
				k_36 : out std_logic_vector(31 downto 0);
				k_37 : out std_logic_vector(31 downto 0);
				k_38 : out std_logic_vector(31 downto 0);
				k_39 : out std_logic_vector(31 downto 0);
				k_40 : out std_logic_vector(31 downto 0);
				k_41 : out std_logic_vector(31 downto 0);
				k_42 : out std_logic_vector(31 downto 0);
				k_43 : out std_logic_vector(31 downto 0));
	END COMPONENT;    

	--Inputs
	signal clk : std_logic := '0';
	type key_t is array (0 to 3) of std_logic_vector(31 downto 0);
	signal key_s : key_t; -- k0..3

	--Outputs
	signal k_0 : std_logic_vector(31 downto 0);
	signal k_1 : std_logic_vector(31 downto 0);
	signal k_2 : std_logic_vector(31 downto 0);
	signal k_3 : std_logic_vector(31 downto 0);
	signal k_4 : std_logic_vector(31 downto 0);
	signal k_5 : std_logic_vector(31 downto 0);
	signal k_6 : std_logic_vector(31 downto 0);
	signal k_7 : std_logic_vector(31 downto 0);
	signal k_8 : std_logic_vector(31 downto 0);
	signal k_9 : std_logic_vector(31 downto 0);
	signal k_10 : std_logic_vector(31 downto 0);
	signal k_11 : std_logic_vector(31 downto 0);
	signal k_12 : std_logic_vector(31 downto 0);
	signal k_13 : std_logic_vector(31 downto 0);
	signal k_14 : std_logic_vector(31 downto 0);
	signal k_15 : std_logic_vector(31 downto 0);
	signal k_16 : std_logic_vector(31 downto 0);
	signal k_17 : std_logic_vector(31 downto 0);
	signal k_18 : std_logic_vector(31 downto 0);
	signal k_19 : std_logic_vector(31 downto 0);
	signal k_20 : std_logic_vector(31 downto 0);
	signal k_21 : std_logic_vector(31 downto 0);
	signal k_22 : std_logic_vector(31 downto 0);
	signal k_23 : std_logic_vector(31 downto 0);
	signal k_24 : std_logic_vector(31 downto 0);
	signal k_25 : std_logic_vector(31 downto 0);
	signal k_26 : std_logic_vector(31 downto 0);
	signal k_27 : std_logic_vector(31 downto 0);
	signal k_28 : std_logic_vector(31 downto 0);
	signal k_29 : std_logic_vector(31 downto 0);
	signal k_30 : std_logic_vector(31 downto 0);
	signal k_31 : std_logic_vector(31 downto 0);
	signal k_32 : std_logic_vector(31 downto 0);
	signal k_33 : std_logic_vector(31 downto 0);
	signal k_34 : std_logic_vector(31 downto 0);
	signal k_35 : std_logic_vector(31 downto 0);
	signal k_36 : std_logic_vector(31 downto 0);
	signal k_37 : std_logic_vector(31 downto 0);
	signal k_38 : std_logic_vector(31 downto 0);
	signal k_39 : std_logic_vector(31 downto 0);
	signal k_40 : std_logic_vector(31 downto 0);
	signal k_41 : std_logic_vector(31 downto 0);
	signal k_42 : std_logic_vector(31 downto 0);
	signal k_43 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;

   signal clk_generator_finish : STD_LOGIC := '0';
   signal test_bench_finish : STD_LOGIC := '0';
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: key_schedule PORT MAP (
          k_in_0 => key_s(0),
          k_in_1 => key_s(1),
			 k_in_2 => key_s(2),
          k_in_3 => key_s(3),
          k_0 => k_0,
			 k_1 => k_1,
			 k_2 => k_2,
			 k_3 => k_3,
			 k_4 => k_4,
			 k_5 => k_5, 
			 k_6 => k_6,
			 k_7 => k_7,
			 k_8 => k_8,
			 k_9 => k_9,
			 k_10 => k_10,
			 k_11 => k_11,
			 k_12 => k_12,
			 k_13 => k_13,
			 k_14 => k_14,
			 k_15 => k_15, 
			 k_16 => k_16,
			 k_17 => k_17,
			 k_18 => k_18,
			 k_19 => k_19,
			 k_20 => k_20,
			 k_21 => k_21,
			 k_22 => k_22,
			 k_23 => k_23,
			 k_24 => k_24,
			 k_25 => k_25, 
			 k_26 => k_26,
			 k_27 => k_27,
			 k_28 => k_28,
			 k_29 => k_29,
			 k_30 => k_30,
			 k_31 => k_31,
			 k_32 => k_32,
			 k_33 => k_33,
			 k_34 => k_34,
			 k_35 => k_35, 
			 k_36 => k_36,
			 k_37 => k_37,
			 k_38 => k_38,
			 k_39 => k_39,
			 k_40 => k_40,
			 k_41 => k_41,
			 k_42 => k_42,
			 k_43 => k_43			 
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

		-- Round 0
		key_s(0) <= X"03020100";
		key_s(1) <= X"0b0a0908";
		key_s(2) <= X"13121110";
		key_s(3) <= X"1b1a1918";

		wait for 20*clk_period;

		assert k_0 = X"03020100"
			report "KEY_SCHEDULE ERROR (0)" severity FAILURE;

		assert k_1 = X"0b0a0908"
			report "KEY_SCHEDULE ERROR (1)" severity FAILURE;

		assert k_2 = X"13121110"
			report "KEY_SCHEDULE ERROR (2)" severity FAILURE;

		assert k_3 = X"1b1a1918"
			report "KEY_SCHEDULE ERROR (3)" severity FAILURE;

		assert k_4 = X"70a011c3"
			report "KEY_SCHEDULE ERROR (4)" severity FAILURE;

		assert k_5 = X"b770ec49"
			report "KEY_SCHEDULE ERROR (5)" severity FAILURE;

		assert k_6 = X"57e3e835"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_7 = X"d397bc42"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_8 = X"94dcf81f"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_9 = X"bf4b5f18"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_10 = X"8e5dabb9"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_11 = X"dbf4a863"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_12 = X"cd0c28fc"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_13 = X"5cb69911"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_14 = X"79f112a5"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_15 = X"77205863"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_16 = X"99880c12"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_17 = X"1ce97c58"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_18 = X"c8ed2145"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_19 = X"b800dbb8"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_20 = X"e86a2756"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_21 = X"7c06d4dd"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_22 = X"ab52df0a"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_23 = X"247f66a8"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_24 = X"53587ca6"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_25 = X"d25c13f1"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_26 = X"4583b64b"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_27 = X"7d9c960d"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_28 = X"efbfc2f3"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_29 = X"89ed8513"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_30 = X"308dfc4e"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_31 = X"bf1a2a36"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_32 = X"e1499d70"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_33 = X"4ce4d2ff"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_34 = X"32b7ebef"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_35 = X"c47505c1"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_36 = X"d0e929e8"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_37 = X"8fe484b9"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_38 = X"42054bee"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_39 = X"af77bae2"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_40 = X"18199c02"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_41 = X"719e3f1c"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_42 = X"0c1cf793"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

		assert k_43 = X"15df4696"
		  report "KEY_SCHEDULE ERROR (k)" severity FAILURE;

   test_bench_finish <= '1';
	clk_generator_finish <= '1';
	wait for clk_period;
	wait;
   end process;

END;
