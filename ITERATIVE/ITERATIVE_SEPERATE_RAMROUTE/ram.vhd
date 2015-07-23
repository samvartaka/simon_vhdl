----------------------------------------------------------------------------------
-- Company: Digital Security Gorup - Faculty of Science - University of Radbound
-- Engineer: Pedro Maat C. Massolino
-- 
-- Create Date:    05/02/2015 
-- Design Name:    RAM
-- Module Name:    RAM
-- Project Name:   Example
-- Target Devices: Any
-- Tool versions:  
--
-- Description: 
--
-- A simple RAM (Random Access Memory)
--
-- Dependencies:
-- VHDL-93
-- 
--
-- Revision: 
-- Revision 1.0
-- Additional Comments: 
-- 			
-- 			- Modified RAM to store 44*32 bits for the round keys (Jos Wetzels & Wouter Bokslag)
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ram is
	Port (
		data_in : in STD_LOGIC_VECTOR(31 downto 0);
		rw : in STD_LOGIC;
		clk : in STD_LOGIC;
		address : in STD_LOGIC_VECTOR(7 downto 0);
		data_out : out STD_LOGIC_VECTOR(31 downto 0)
	);
end ram;

architecture Behavioral of ram is

type ramtype is array(0 to 43) of std_logic_vector(31 downto 0);    

signal memory_ram : ramtype;

begin                                                        

process (clk)                                                
begin                                                        
	if clk'event and clk = '1' then  
		if rw = '1' then                                             
			memory_ram(to_integer(unsigned(address))) <= data_in;         
			data_out <= data_in; -- small modification to make data_out contain what was written upon every write operation
		else
			data_out <= memory_ram(to_integer(unsigned(address)));
		end if;                                                      
	end if;                                                      
end process;             

end Behavioral;