-- SIMON 64/128
-- negative-edge triggered inner-round pipelining word (32-bit) registry
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

entity neg_reg_32 is
	port(clk : in std_logic;
	     rst : in std_logic;
		 data_in : in std_logic_vector(31 downto 0);
         data_out : out std_logic_vector(31 downto 0)
         );
end neg_reg_32;

architecture Behavioral of neg_reg_32 is
	signal neg_reg_32_s : std_logic_vector(31 downto 0);
begin

	pr_reg: process(clk)
	begin
		-- triggers on negative edge
		if falling_edge(clk) then
			if rst = '1' then
				neg_reg_32_s <= (others => '0');
			else
				neg_reg_32_s <= data_in;
			end if;
		end if;
	end process;

	data_out <= neg_reg_32_s;

end Behavioral;