
-- SIMON 64/128
-- key scheduling function
--
-- @Author: Jos Wetzels
-- @Author: Wouter Bokslag
--
-- Parameters:
--          r: round index
--     k_0..k_3: key
-- subkey_out: round subkey
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity key_schedule is
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

end key_schedule;

architecture Behavioral of key_schedule is
	signal int_0 : std_logic_vector(31 downto 0);
	signal int_1 : std_logic_vector(31 downto 0);
	signal int_2 : std_logic_vector(31 downto 0);
	signal int_3 : std_logic_vector(31 downto 0);
	signal int_4 : std_logic_vector(31 downto 0);
	signal int_5 : std_logic_vector(31 downto 0);
	signal int_6 : std_logic_vector(31 downto 0);
	signal int_7 : std_logic_vector(31 downto 0);
	signal int_8 : std_logic_vector(31 downto 0);
	signal int_9 : std_logic_vector(31 downto 0);
	signal int_10 : std_logic_vector(31 downto 0);
	signal int_11 : std_logic_vector(31 downto 0);
	signal int_12 : std_logic_vector(31 downto 0);
	signal int_13 : std_logic_vector(31 downto 0);
	signal int_14 : std_logic_vector(31 downto 0);
	signal int_15 : std_logic_vector(31 downto 0);
	signal int_16 : std_logic_vector(31 downto 0);
	signal int_17 : std_logic_vector(31 downto 0);
	signal int_18 : std_logic_vector(31 downto 0);
	signal int_19 : std_logic_vector(31 downto 0);
	signal int_20 : std_logic_vector(31 downto 0);
	signal int_21 : std_logic_vector(31 downto 0);
	signal int_22 : std_logic_vector(31 downto 0);
	signal int_23 : std_logic_vector(31 downto 0);
	signal int_24 : std_logic_vector(31 downto 0);
	signal int_25 : std_logic_vector(31 downto 0);
	signal int_26 : std_logic_vector(31 downto 0);
	signal int_27 : std_logic_vector(31 downto 0);
	signal int_28 : std_logic_vector(31 downto 0);
	signal int_29 : std_logic_vector(31 downto 0);
	signal int_30 : std_logic_vector(31 downto 0);
	signal int_31 : std_logic_vector(31 downto 0);
	signal int_32 : std_logic_vector(31 downto 0);
	signal int_33 : std_logic_vector(31 downto 0);
	signal int_34 : std_logic_vector(31 downto 0);
	signal int_35 : std_logic_vector(31 downto 0);
	signal int_36 : std_logic_vector(31 downto 0);
	signal int_37 : std_logic_vector(31 downto 0);
	signal int_38 : std_logic_vector(31 downto 0);
	signal int_39 : std_logic_vector(31 downto 0);
	signal int_40 : std_logic_vector(31 downto 0);
	signal int_41 : std_logic_vector(31 downto 0);
	signal int_42 : std_logic_vector(31 downto 0);
	signal int_43 : std_logic_vector(31 downto 0);
   
	signal op_3_s : std_logic_vector(31 downto 0);
	signal op_xor_0 : std_logic_vector(31 downto 0);
	signal op_1_s : std_logic_vector(31 downto 0);
	signal c_const : std_logic_vector(30 downto 0);
	signal sequence : std_logic_vector(61 downto 0);
begin
	-- C ^ sequence[(r-4) % 62]
	sequence <= "11110000101100111001010001001000000111101001100011010111011011"; -- z3
	c_const <= "1111111111111111111111111111110";
	
	-- Round 0 to 3
	k_0 <= k_in_0;
	int_0 <= k_in_0; 	

	k_1 <= k_in_1;
	int_1 <= k_in_1; 

	k_2 <= k_in_2;
	int_2 <= k_in_2; 

	k_3 <= k_in_3;
	int_3 <= k_in_3;
	
    -- Round 4
	int_4 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_3), 3)) xor int_1)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_3), 3)) xor int_1) 
				xor int_0 xor (c_const & sequence(0)));
	k_4 <= int_4;

    -- Round 5
	int_5 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_4), 3)) xor int_2)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_4), 3)) xor int_2) 
				xor int_1 xor (c_const & sequence(1)));
	k_5 <= int_5;

    -- Round 6
	int_6 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_5), 3)) xor int_3)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_5), 3)) xor int_3) 
				xor int_2 xor (c_const & sequence(2)));
	k_6 <= int_6;

    -- Round 7
	int_7 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_6), 3)) xor int_4)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_6), 3)) xor int_4) 
				xor int_3 xor (c_const & sequence(3)));
	k_7 <= int_7;

    -- Round 8
	int_8 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_7), 3)) xor int_5)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_7), 3)) xor int_5) 
				xor int_4 xor (c_const & sequence(4)));
	k_8 <= int_8;

    -- Round 9
	int_9 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_8), 3)) xor int_6)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_8), 3)) xor int_6) 
				xor int_5 xor (c_const & sequence(5)));
	k_9 <= int_9;

    -- Round 10
	int_10 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_9), 3)) xor int_7)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_9), 3)) xor int_7) 
				xor int_6 xor (c_const & sequence(6)));
	k_10 <= int_10;

    -- Round 11
	int_11 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_10), 3)) xor int_8)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_10), 3)) xor int_8) 
				xor int_7 xor (c_const & sequence(7)));
	k_11 <= int_11;

    -- Round 12
	int_12 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_11), 3)) xor int_9)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_11), 3)) xor int_9) 
				xor int_8 xor (c_const & sequence(8)));
	k_12 <= int_12;

    -- Round 13
	int_13 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_12), 3)) xor int_10)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_12), 3)) xor int_10) 
				xor int_9 xor (c_const & sequence(9)));
	k_13 <= int_13;

    -- Round 14
	int_14 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_13), 3)) xor int_11)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_13), 3)) xor int_11) 
				xor int_10 xor (c_const & sequence(10)));
	k_14 <= int_14;

    -- Round 15
	int_15 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_14), 3)) xor int_12)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_14), 3)) xor int_12) 
				xor int_11 xor (c_const & sequence(11)));
	k_15 <= int_15;

    -- Round 16
	int_16 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_15), 3)) xor int_13)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_15), 3)) xor int_13) 
				xor int_12 xor (c_const & sequence(12)));
	k_16 <= int_16;

    -- Round 17
	int_17 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_16), 3)) xor int_14)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_16), 3)) xor int_14) 
				xor int_13 xor (c_const & sequence(13)));
	k_17 <= int_17;

    -- Round 18
	int_18 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_17), 3)) xor int_15)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_17), 3)) xor int_15) 
				xor int_14 xor (c_const & sequence(14)));
	k_18 <= int_18;

    -- Round 19
	int_19 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_18), 3)) xor int_16)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_18), 3)) xor int_16) 
				xor int_15 xor (c_const & sequence(15)));
	k_19 <= int_19;

    -- Round 20
	int_20 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_19), 3)) xor int_17)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_19), 3)) xor int_17) 
				xor int_16 xor (c_const & sequence(16)));
	k_20 <= int_20;

    -- Round 21
	int_21 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_20), 3)) xor int_18)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_20), 3)) xor int_18) 
				xor int_17 xor (c_const & sequence(17)));
	k_21 <= int_21;

    -- Round 22
	int_22 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_21), 3)) xor int_19)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_21), 3)) xor int_19) 
				xor int_18 xor (c_const & sequence(18)));
	k_22 <= int_22;

    -- Round 23
	int_23 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_22), 3)) xor int_20)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_22), 3)) xor int_20) 
				xor int_19 xor (c_const & sequence(19)));
	k_23 <= int_23;

    -- Round 24
	int_24 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_23), 3)) xor int_21)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_23), 3)) xor int_21) 
				xor int_20 xor (c_const & sequence(20)));
	k_24 <= int_24;

    -- Round 25
	int_25 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_24), 3)) xor int_22)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_24), 3)) xor int_22) 
				xor int_21 xor (c_const & sequence(21)));
	k_25 <= int_25;

    -- Round 26
	int_26 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_25), 3)) xor int_23)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_25), 3)) xor int_23) 
				xor int_22 xor (c_const & sequence(22)));
	k_26 <= int_26;

    -- Round 27
	int_27 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_26), 3)) xor int_24)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_26), 3)) xor int_24) 
				xor int_23 xor (c_const & sequence(23)));
	k_27 <= int_27;

    -- Round 28
	int_28 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_27), 3)) xor int_25)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_27), 3)) xor int_25) 
				xor int_24 xor (c_const & sequence(24)));
	k_28 <= int_28;

    -- Round 29
	int_29 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_28), 3)) xor int_26)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_28), 3)) xor int_26) 
				xor int_25 xor (c_const & sequence(25)));
	k_29 <= int_29;

    -- Round 30
	int_30 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_29), 3)) xor int_27)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_29), 3)) xor int_27) 
				xor int_26 xor (c_const & sequence(26)));
	k_30 <= int_30;

    -- Round 31
	int_31 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_30), 3)) xor int_28)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_30), 3)) xor int_28) 
				xor int_27 xor (c_const & sequence(27)));
	k_31 <= int_31;

    -- Round 32
	int_32 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_31), 3)) xor int_29)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_31), 3)) xor int_29) 
				xor int_28 xor (c_const & sequence(28)));
	k_32 <= int_32;

    -- Round 33
	int_33 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_32), 3)) xor int_30)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_32), 3)) xor int_30) 
				xor int_29 xor (c_const & sequence(29)));
	k_33 <= int_33;

    -- Round 34
	int_34 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_33), 3)) xor int_31)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_33), 3)) xor int_31) 
				xor int_30 xor (c_const & sequence(30)));
	k_34 <= int_34;

    -- Round 35
	int_35 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_34), 3)) xor int_32)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_34), 3)) xor int_32) 
				xor int_31 xor (c_const & sequence(31)));
	k_35 <= int_35;

    -- Round 36
	int_36 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_35), 3)) xor int_33)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_35), 3)) xor int_33) 
				xor int_32 xor (c_const & sequence(32)));
	k_36 <= int_36;

    -- Round 37
	int_37 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_36), 3)) xor int_34)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_36), 3)) xor int_34) 
				xor int_33 xor (c_const & sequence(33)));
	k_37 <= int_37;

    -- Round 38
	int_38 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_37), 3)) xor int_35)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_37), 3)) xor int_35) 
				xor int_34 xor (c_const & sequence(34)));
	k_38 <= int_38;

    -- Round 39
	int_39 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_38), 3)) xor int_36)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_38), 3)) xor int_36) 
				xor int_35 xor (c_const & sequence(35)));
	k_39 <= int_39;

    -- Round 40
	int_40 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_39), 3)) xor int_37)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_39), 3)) xor int_37) 
				xor int_36 xor (c_const & sequence(36)));
	k_40 <= int_40;

    -- Round 41
	int_41 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_40), 3)) xor int_38)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_40), 3)) xor int_38) 
				xor int_37 xor (c_const & sequence(37)));
	k_41 <= int_41;

    -- Round 42
	int_42 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_41), 3)) xor int_39)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_41), 3)) xor int_39) 
				xor int_38 xor (c_const & sequence(38)));
	k_42 <= int_42;

    -- Round 43
	int_43 <= (std_logic_vector(rotate_right(unsigned((std_logic_vector(rotate_right(unsigned(int_42), 3)) xor int_40)), 1))
				xor (std_logic_vector(rotate_right(unsigned(int_42), 3)) xor int_40) 
				xor int_39 xor (c_const & sequence(39)));
	k_43 <= int_43;

end Behavioral;