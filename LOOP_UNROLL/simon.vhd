-- SIMON 64/128
-- Simon core component
--
-- @Author: Jos Wetzels
-- @Author: Wouter Bokslag
--
-- Parameters:
--        rst: reset state
--        enc: encrypt/decrypt mode
--        key: key
-- 		 block_in: plaintext block
-- 		 block_out: ciphertext block
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity simon is
	port(clk : in std_logic;
		 enc : in std_logic; -- (0 = enc, 1 = dec)
	     key : in std_logic_vector(127 downto 0);
	     block_in : in std_logic_vector(63 downto 0);
	     block_out : out std_logic_vector(63 downto 0));
end simon;

architecture Behavioral of simon is

	component key_schedule is
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
	end component;

	component round_f
	port(enc : std_logic;
		 v_in : in std_logic_vector(63 downto 0);
	     v_k_e : in std_logic_vector(31 downto 0);
	     v_k_d : in std_logic_vector(31 downto 0);
         v_out : out std_logic_vector(63 downto 0)
         );
	END component;

	type key_t is array (0 to 3) of std_logic_vector(31 downto 0);
	signal key_s : key_t; -- intermediate key (in words)
	
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
	
	signal ct_0 : std_logic_vector(63 downto 0); -- intermediate ciphertext after round 0
	signal ct_1 : std_logic_vector(63 downto 0);
	signal ct_2 : std_logic_vector(63 downto 0);
	signal ct_3 : std_logic_vector(63 downto 0);
	signal ct_4 : std_logic_vector(63 downto 0);
	signal ct_5 : std_logic_vector(63 downto 0);
	signal ct_6 : std_logic_vector(63 downto 0);
	signal ct_7 : std_logic_vector(63 downto 0);
	signal ct_8 : std_logic_vector(63 downto 0);
	signal ct_9 : std_logic_vector(63 downto 0);
	signal ct_10 : std_logic_vector(63 downto 0); 
	signal ct_11 : std_logic_vector(63 downto 0);
	signal ct_12 : std_logic_vector(63 downto 0);
	signal ct_13 : std_logic_vector(63 downto 0);
	signal ct_14 : std_logic_vector(63 downto 0);
	signal ct_15 : std_logic_vector(63 downto 0);
	signal ct_16 : std_logic_vector(63 downto 0);
	signal ct_17 : std_logic_vector(63 downto 0);
	signal ct_18 : std_logic_vector(63 downto 0);
	signal ct_19 : std_logic_vector(63 downto 0);
	signal ct_20 : std_logic_vector(63 downto 0); 
	signal ct_21 : std_logic_vector(63 downto 0);
	signal ct_22 : std_logic_vector(63 downto 0);
	signal ct_23 : std_logic_vector(63 downto 0);
	signal ct_24 : std_logic_vector(63 downto 0);
	signal ct_25 : std_logic_vector(63 downto 0);
	signal ct_26 : std_logic_vector(63 downto 0);
	signal ct_27 : std_logic_vector(63 downto 0);
	signal ct_28 : std_logic_vector(63 downto 0);
	signal ct_29 : std_logic_vector(63 downto 0);
	signal ct_30 : std_logic_vector(63 downto 0); 
	signal ct_31 : std_logic_vector(63 downto 0);
	signal ct_32 : std_logic_vector(63 downto 0);
	signal ct_33 : std_logic_vector(63 downto 0);
	signal ct_34 : std_logic_vector(63 downto 0);
	signal ct_35 : std_logic_vector(63 downto 0);
	signal ct_36 : std_logic_vector(63 downto 0);
	signal ct_37 : std_logic_vector(63 downto 0);
	signal ct_38 : std_logic_vector(63 downto 0);
	signal ct_39 : std_logic_vector(63 downto 0);
	signal ct_40 : std_logic_vector(63 downto 0); 
	signal ct_41 : std_logic_vector(63 downto 0);
	signal ct_42 : std_logic_vector(63 downto 0);
	signal ct_43 : std_logic_vector(63 downto 0);
	
begin

	KEY_SCHEDULE_0 : key_schedule port map (
		key_s(0), key_s(1), key_s(2), key_s(3), 
		k_0, k_1, k_2, k_3, k_4, k_5, k_6, k_7, k_8, k_9, k_10, 
		k_11, k_12, k_13, k_14, k_15, k_16, k_17, k_18, k_19, k_20, 
		k_21, k_22, k_23, k_24, k_25, k_26, k_27, k_28, k_29, k_30, 
		k_31, k_32, k_33, k_34, k_35, k_36, k_37, k_38, k_39, k_40, 
		k_41, k_42, k_43);

	ROUND_F_0 : round_f port map (enc, block_in, k_0, k_43, ct_0);
	ROUND_F_1 : round_f port map (enc, ct_0, k_1, k_42, ct_1);
	ROUND_F_2 : round_f port map (enc, ct_1, k_2, k_41, ct_2);
	ROUND_F_3 : round_f port map (enc, ct_2, k_3, k_40, ct_3);
	ROUND_F_4 : round_f port map (enc, ct_3, k_4, k_39, ct_4);
	ROUND_F_5 : round_f port map (enc, ct_4, k_5, k_38, ct_5);
	ROUND_F_6 : round_f port map (enc, ct_5, k_6, k_37, ct_6);
	ROUND_F_7 : round_f port map (enc, ct_6, k_7, k_36, ct_7);
	ROUND_F_8 : round_f port map (enc, ct_7, k_8, k_35, ct_8);
	ROUND_F_9 : round_f port map (enc, ct_8, k_9, k_34, ct_9);
	ROUND_F_10 : round_f port map (enc, ct_9, k_10, k_33, ct_10);
	ROUND_F_11 : round_f port map (enc, ct_10, k_11, k_32, ct_11);
	ROUND_F_12 : round_f port map (enc, ct_11, k_12, k_31, ct_12);
	ROUND_F_13 : round_f port map (enc, ct_12, k_13, k_30, ct_13);
	ROUND_F_14 : round_f port map (enc, ct_13, k_14, k_29, ct_14);
	ROUND_F_15 : round_f port map (enc, ct_14, k_15, k_28, ct_15);
	ROUND_F_16 : round_f port map (enc, ct_15, k_16, k_27, ct_16);
	ROUND_F_17 : round_f port map (enc, ct_16, k_17, k_26, ct_17);
	ROUND_F_18 : round_f port map (enc, ct_17, k_18, k_25, ct_18);
	ROUND_F_19 : round_f port map (enc, ct_18, k_19, k_24, ct_19);
	ROUND_F_20 : round_f port map (enc, ct_19, k_20, k_23, ct_20);
	ROUND_F_21 : round_f port map (enc, ct_20, k_21, k_22, ct_21);
	ROUND_F_22 : round_f port map (enc, ct_21, k_22, k_21, ct_22);
	ROUND_F_23 : round_f port map (enc, ct_22, k_23, k_20, ct_23);
	ROUND_F_24 : round_f port map (enc, ct_23, k_24, k_19, ct_24);
	ROUND_F_25 : round_f port map (enc, ct_24, k_25, k_18, ct_25);
	ROUND_F_26 : round_f port map (enc, ct_25, k_26, k_17, ct_26);
	ROUND_F_27 : round_f port map (enc, ct_26, k_27, k_16, ct_27);
	ROUND_F_28 : round_f port map (enc, ct_27, k_28, k_15, ct_28);
	ROUND_F_29 : round_f port map (enc, ct_28, k_29, k_14, ct_29);
	ROUND_F_30 : round_f port map (enc, ct_29, k_30, k_13, ct_30);
	ROUND_F_31 : round_f port map (enc, ct_30, k_31, k_12, ct_31);
	ROUND_F_32 : round_f port map (enc, ct_31, k_32, k_11, ct_32);
	ROUND_F_33 : round_f port map (enc, ct_32, k_33, k_10, ct_33);
	ROUND_F_34 : round_f port map (enc, ct_33, k_34, k_9, ct_34);
	ROUND_F_35 : round_f port map (enc, ct_34, k_35, k_8, ct_35);
	ROUND_F_36 : round_f port map (enc, ct_35, k_36, k_7, ct_36);
	ROUND_F_37 : round_f port map (enc, ct_36, k_37, k_6, ct_37);
	ROUND_F_38 : round_f port map (enc, ct_37, k_38, k_5, ct_38);
	ROUND_F_39 : round_f port map (enc, ct_38, k_39, k_4, ct_39);
	ROUND_F_40 : round_f port map (enc, ct_39, k_40, k_3, ct_40);
	ROUND_F_41 : round_f port map (enc, ct_40, k_41, k_2, ct_41);
	ROUND_F_42 : round_f port map (enc, ct_41, k_42, k_1, ct_42);
	ROUND_F_43 : round_f port map (enc, ct_42, k_43, k_0, ct_43);

	block_out <= ct_43;
		
	-- SIMON Core
	pr_smn : process(clk, enc, key, key_s)
	begin
		if rising_edge(clk) then
			-- no rst switch/phase distinction needed due to full unrolling of key schedule
			key_s(0) <= key(31 downto 0);
			key_s(1) <= key(63 downto 32);
			key_s(2) <= key(95 downto 64);
			key_s(3) <= key(127 downto 96);
		end if;
	end process;
	
end Behavioral;