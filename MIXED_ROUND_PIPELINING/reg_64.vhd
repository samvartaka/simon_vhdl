-- SIMON 64/128
-- outer-pipelining word (64-bit) registry
-- 
-- @Author: Jos Wetzels
-- @Author: Wouter Bokslag
--
-- Parameters:
--        	 clk: clock
--        	 rst: reset state
--       data_in: registry input
--      data_out: registry output
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_64 is
	port(clk : in std_logic;
	     rst : in std_logic;
		 data_in : in std_logic_vector(63 downto 0);
         data_out : out std_logic_vector(63 downto 0)
         );
end reg_64;

architecture Behavioral of reg_64 is
	signal reg_64_s : std_logic_vector(63 downto 0);
begin

	pr_reg: process(clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				reg_64_s <= (others => '0');
			else
				reg_64_s <= data_in;
			end if;
		end if;
	end process;

	data_out <= reg_64_s;

end Behavioral;