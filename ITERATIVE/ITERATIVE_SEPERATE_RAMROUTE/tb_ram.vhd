----------------------------------------------------------------------------------
-- Company: Digital Security Gorup - Faculty of Science - University of Radbound
-- Engineer: Pedro Maat C. Massolino
-- 
-- Create Date:    05/02/2015 
-- Design Name:    TB_RAM
-- Module Name:    TB_RAM
-- Project Name:   Example
-- Target Devices: Any
-- Tool versions:  
--
-- Description: 
--
-- A simple test bench for the simple RAM
--
-- Dependencies:
-- VHDL-93
--
-- Revision: 
-- Revision 1.0
-- Additional Comments: 
-- 			
-- 			- Modified RAM to store 40*32 bits for the round keys (Jos Wetzels & Wouter Bokslag)
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_ram is
    Generic (
		PERIOD : time := 10 ns
    );
end tb_ram;

architecture Behavioral of tb_ram is

component ram
	Port (
		data_in : in STD_LOGIC_VECTOR(31 downto 0);
		rw : in STD_LOGIC;
		clk : in STD_LOGIC;
		address : in STD_LOGIC_VECTOR(7 downto 0);
		data_out : out STD_LOGIC_VECTOR(31 downto 0)
	);
end component;

signal test_data_in : STD_LOGIC_VECTOR(31 downto 0);
signal test_rw : STD_LOGIC;
signal test_address : STD_LOGIC_VECTOR(7 downto 0);
signal test_data_out : STD_LOGIC_VECTOR(31 downto 0);

signal clk : STD_LOGIC := '0';
signal clk_generator_finish : STD_LOGIC := '0';

signal test_bench_finish : STD_LOGIC := '0';

begin

test : ram
	Port Map(
		data_in => test_data_in,
		rw => test_rw,
		clk => clk,
		address => test_address,
		data_out => test_data_out
	);
	
clock : process
begin
    while ( clk_generator_finish /= '1') loop
       clk <= not clk;
       wait for PERIOD/2;
    end loop;
    wait;
end process;

process
begin

	wait for PERIOD/2;
	test_data_in <= X"03020100";
	test_rw <= '1';
	test_address <= X"00";
	wait for PERIOD;

	test_data_in <= X"0b0a0908";
	test_rw <= '1';
	test_address <= X"01";
	wait for PERIOD;

	test_data_in <= X"13121110";
	test_rw <= '1';
	test_address <= X"02";
	wait for PERIOD;

	test_data_in <= X"1b1a1918";
	test_rw <= '1';
	test_address <= X"03";
	wait for PERIOD;

	test_rw <= '0';
	test_address <= X"00";
	wait for PERIOD;
	assert test_data_out = X"03020100" report "Error in RAM" severity FAILURE;
	test_address <= X"01";
	wait for PERIOD;
	assert test_data_out = X"0b0a0908" report "Error in RAM" severity FAILURE;
	test_address <= X"02";
	wait for PERIOD;
	assert test_data_out = X"13121110" report "Error in RAM" severity FAILURE;
	test_address <= X"03";
	wait for PERIOD;
	assert test_data_out = X"1b1a1918" report "Error in RAM" severity FAILURE;
   test_bench_finish <= '1';
	clk_generator_finish <= '1';
	wait for PERIOD;
	wait;
end process;


end Behavioral;