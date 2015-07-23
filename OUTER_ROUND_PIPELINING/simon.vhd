-- SIMON 64/128
-- Simon core component
--
-- @Author: Jos Wetzels
-- @Author: Wouter Bokslag
--
-- Parameters:
--        clk: clock
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
	     rst : in std_logic; -- state indicator (1 = init, 0 = run)
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

	component reg_64 is
		port(clk : in std_logic;
		     rst : in std_logic;
			 data_in : in std_logic_vector(63 downto 0);
	         data_out : out std_logic_vector(63 downto 0));		  
	end component;

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
	
	signal ct_in_0 : std_logic_vector(63 downto 0); -- intermediate ciphertext after round 0
	signal ct_in_1 : std_logic_vector(63 downto 0);
	signal ct_in_2 : std_logic_vector(63 downto 0);
	signal ct_in_3 : std_logic_vector(63 downto 0);
	signal ct_in_4 : std_logic_vector(63 downto 0);
	signal ct_in_5 : std_logic_vector(63 downto 0);
	signal ct_in_6 : std_logic_vector(63 downto 0);
	signal ct_in_7 : std_logic_vector(63 downto 0);
	signal ct_in_8 : std_logic_vector(63 downto 0);
	signal ct_in_9 : std_logic_vector(63 downto 0);
	signal ct_in_10 : std_logic_vector(63 downto 0); 
	signal ct_in_11 : std_logic_vector(63 downto 0);
	signal ct_in_12 : std_logic_vector(63 downto 0);
	signal ct_in_13 : std_logic_vector(63 downto 0);
	signal ct_in_14 : std_logic_vector(63 downto 0);
	signal ct_in_15 : std_logic_vector(63 downto 0);
	signal ct_in_16 : std_logic_vector(63 downto 0);
	signal ct_in_17 : std_logic_vector(63 downto 0);
	signal ct_in_18 : std_logic_vector(63 downto 0);
	signal ct_in_19 : std_logic_vector(63 downto 0);
	signal ct_in_20 : std_logic_vector(63 downto 0); 
	signal ct_in_21 : std_logic_vector(63 downto 0);
	signal ct_in_22 : std_logic_vector(63 downto 0);
	signal ct_in_23 : std_logic_vector(63 downto 0);
	signal ct_in_24 : std_logic_vector(63 downto 0);
	signal ct_in_25 : std_logic_vector(63 downto 0);
	signal ct_in_26 : std_logic_vector(63 downto 0);
	signal ct_in_27 : std_logic_vector(63 downto 0);
	signal ct_in_28 : std_logic_vector(63 downto 0);
	signal ct_in_29 : std_logic_vector(63 downto 0);
	signal ct_in_30 : std_logic_vector(63 downto 0); 
	signal ct_in_31 : std_logic_vector(63 downto 0);
	signal ct_in_32 : std_logic_vector(63 downto 0);
	signal ct_in_33 : std_logic_vector(63 downto 0);
	signal ct_in_34 : std_logic_vector(63 downto 0);
	signal ct_in_35 : std_logic_vector(63 downto 0);
	signal ct_in_36 : std_logic_vector(63 downto 0);
	signal ct_in_37 : std_logic_vector(63 downto 0);
	signal ct_in_38 : std_logic_vector(63 downto 0);
	signal ct_in_39 : std_logic_vector(63 downto 0);
	signal ct_in_40 : std_logic_vector(63 downto 0); 
	signal ct_in_41 : std_logic_vector(63 downto 0);
	signal ct_in_42 : std_logic_vector(63 downto 0);
	signal ct_in_43 : std_logic_vector(63 downto 0);

	signal ct_out_0 : std_logic_vector(63 downto 0); -- intermediate ciphertext after round 0
	signal ct_out_1 : std_logic_vector(63 downto 0);
	signal ct_out_2 : std_logic_vector(63 downto 0);
	signal ct_out_3 : std_logic_vector(63 downto 0);
	signal ct_out_4 : std_logic_vector(63 downto 0);
	signal ct_out_5 : std_logic_vector(63 downto 0);
	signal ct_out_6 : std_logic_vector(63 downto 0);
	signal ct_out_7 : std_logic_vector(63 downto 0);
	signal ct_out_8 : std_logic_vector(63 downto 0);
	signal ct_out_9 : std_logic_vector(63 downto 0);
	signal ct_out_10 : std_logic_vector(63 downto 0); 
	signal ct_out_11 : std_logic_vector(63 downto 0);
	signal ct_out_12 : std_logic_vector(63 downto 0);
	signal ct_out_13 : std_logic_vector(63 downto 0);
	signal ct_out_14 : std_logic_vector(63 downto 0);
	signal ct_out_15 : std_logic_vector(63 downto 0);
	signal ct_out_16 : std_logic_vector(63 downto 0);
	signal ct_out_17 : std_logic_vector(63 downto 0);
	signal ct_out_18 : std_logic_vector(63 downto 0);
	signal ct_out_19 : std_logic_vector(63 downto 0);
	signal ct_out_20 : std_logic_vector(63 downto 0); 
	signal ct_out_21 : std_logic_vector(63 downto 0);
	signal ct_out_22 : std_logic_vector(63 downto 0);
	signal ct_out_23 : std_logic_vector(63 downto 0);
	signal ct_out_24 : std_logic_vector(63 downto 0);
	signal ct_out_25 : std_logic_vector(63 downto 0);
	signal ct_out_26 : std_logic_vector(63 downto 0);
	signal ct_out_27 : std_logic_vector(63 downto 0);
	signal ct_out_28 : std_logic_vector(63 downto 0);
	signal ct_out_29 : std_logic_vector(63 downto 0);
	signal ct_out_30 : std_logic_vector(63 downto 0); 
	signal ct_out_31 : std_logic_vector(63 downto 0);
	signal ct_out_32 : std_logic_vector(63 downto 0);
	signal ct_out_33 : std_logic_vector(63 downto 0);
	signal ct_out_34 : std_logic_vector(63 downto 0);
	signal ct_out_35 : std_logic_vector(63 downto 0);
	signal ct_out_36 : std_logic_vector(63 downto 0);
	signal ct_out_37 : std_logic_vector(63 downto 0);
	signal ct_out_38 : std_logic_vector(63 downto 0);
	signal ct_out_39 : std_logic_vector(63 downto 0);
	signal ct_out_40 : std_logic_vector(63 downto 0); 
	signal ct_out_41 : std_logic_vector(63 downto 0);
	signal ct_out_42 : std_logic_vector(63 downto 0);
	
begin

	KEY_SCHEDULE_0 : key_schedule port map (
		key_s(0), key_s(1), key_s(2), key_s(3), 
		k_0, k_1, k_2, k_3, k_4, k_5, k_6, k_7, k_8, k_9, k_10, 
		k_11, k_12, k_13, k_14, k_15, k_16, k_17, k_18, k_19, k_20, 
		k_21, k_22, k_23, k_24, k_25, k_26, k_27, k_28, k_29, k_30, 
		k_31, k_32, k_33, k_34, k_35, k_36, k_37, k_38, k_39, k_40, 
		k_41, k_42, k_43);

	-- Outer-round registers

	REG_STAGE_0 : reg_64 port map (clk, rst, ct_in_0, ct_out_0);
	REG_STAGE_1 : reg_64 port map (clk, rst, ct_in_1, ct_out_1);
	REG_STAGE_2 : reg_64 port map (clk, rst, ct_in_2, ct_out_2);
	REG_STAGE_3 : reg_64 port map (clk, rst, ct_in_3, ct_out_3);
	REG_STAGE_4 : reg_64 port map (clk, rst, ct_in_4, ct_out_4);
	REG_STAGE_5 : reg_64 port map (clk, rst, ct_in_5, ct_out_5);
	REG_STAGE_6 : reg_64 port map (clk, rst, ct_in_6, ct_out_6);
	REG_STAGE_7 : reg_64 port map (clk, rst, ct_in_7, ct_out_7);
	REG_STAGE_8 : reg_64 port map (clk, rst, ct_in_8, ct_out_8);
	REG_STAGE_9 : reg_64 port map (clk, rst, ct_in_9, ct_out_9);
	REG_STAGE_10 : reg_64 port map (clk, rst, ct_in_10, ct_out_10);
	REG_STAGE_11 : reg_64 port map (clk, rst, ct_in_11, ct_out_11);
	REG_STAGE_12 : reg_64 port map (clk, rst, ct_in_12, ct_out_12);
	REG_STAGE_13 : reg_64 port map (clk, rst, ct_in_13, ct_out_13);
	REG_STAGE_14 : reg_64 port map (clk, rst, ct_in_14, ct_out_14);
	REG_STAGE_15 : reg_64 port map (clk, rst, ct_in_15, ct_out_15);
	REG_STAGE_16 : reg_64 port map (clk, rst, ct_in_16, ct_out_16);
	REG_STAGE_17 : reg_64 port map (clk, rst, ct_in_17, ct_out_17);
	REG_STAGE_18 : reg_64 port map (clk, rst, ct_in_18, ct_out_18);
	REG_STAGE_19 : reg_64 port map (clk, rst, ct_in_19, ct_out_19);
	REG_STAGE_20 : reg_64 port map (clk, rst, ct_in_20, ct_out_20);
	REG_STAGE_21 : reg_64 port map (clk, rst, ct_in_21, ct_out_21);
	REG_STAGE_22 : reg_64 port map (clk, rst, ct_in_22, ct_out_22);
	REG_STAGE_23 : reg_64 port map (clk, rst, ct_in_23, ct_out_23);
	REG_STAGE_24 : reg_64 port map (clk, rst, ct_in_24, ct_out_24);
	REG_STAGE_25 : reg_64 port map (clk, rst, ct_in_25, ct_out_25);
	REG_STAGE_26 : reg_64 port map (clk, rst, ct_in_26, ct_out_26);
	REG_STAGE_27 : reg_64 port map (clk, rst, ct_in_27, ct_out_27);
	REG_STAGE_28 : reg_64 port map (clk, rst, ct_in_28, ct_out_28);
	REG_STAGE_29 : reg_64 port map (clk, rst, ct_in_29, ct_out_29);
	REG_STAGE_30 : reg_64 port map (clk, rst, ct_in_30, ct_out_30);
	REG_STAGE_31 : reg_64 port map (clk, rst, ct_in_31, ct_out_31);
	REG_STAGE_32 : reg_64 port map (clk, rst, ct_in_32, ct_out_32);
	REG_STAGE_33 : reg_64 port map (clk, rst, ct_in_33, ct_out_33);
	REG_STAGE_34 : reg_64 port map (clk, rst, ct_in_34, ct_out_34);
	REG_STAGE_35 : reg_64 port map (clk, rst, ct_in_35, ct_out_35);
	REG_STAGE_36 : reg_64 port map (clk, rst, ct_in_36, ct_out_36);
	REG_STAGE_37 : reg_64 port map (clk, rst, ct_in_37, ct_out_37);
	REG_STAGE_38 : reg_64 port map (clk, rst, ct_in_38, ct_out_38);
	REG_STAGE_39 : reg_64 port map (clk, rst, ct_in_39, ct_out_39);
	REG_STAGE_40 : reg_64 port map (clk, rst, ct_in_40, ct_out_40);
	REG_STAGE_41 : reg_64 port map (clk, rst, ct_in_41, ct_out_41);
	REG_STAGE_42 : reg_64 port map (clk, rst, ct_in_42, ct_out_42);

	-- round function combinatorial logic

	ROUND_F_0 : round_f port map (enc, block_in, k_0, k_43, ct_in_0);
	ROUND_F_1 : round_f port map (enc, ct_out_0, k_1, k_42, ct_in_1);
	ROUND_F_2 : round_f port map (enc, ct_out_1, k_2, k_41, ct_in_2);
	ROUND_F_3 : round_f port map (enc, ct_out_2, k_3, k_40, ct_in_3);
	ROUND_F_4 : round_f port map (enc, ct_out_3, k_4, k_39, ct_in_4);
	ROUND_F_5 : round_f port map (enc, ct_out_4, k_5, k_38, ct_in_5);
	ROUND_F_6 : round_f port map (enc, ct_out_5, k_6, k_37, ct_in_6);
	ROUND_F_7 : round_f port map (enc, ct_out_6, k_7, k_36, ct_in_7);
	ROUND_F_8 : round_f port map (enc, ct_out_7, k_8, k_35, ct_in_8);
	ROUND_F_9 : round_f port map (enc, ct_out_8, k_9, k_34, ct_in_9);
	ROUND_F_10 : round_f port map (enc, ct_out_9, k_10, k_33, ct_in_10);
	ROUND_F_11 : round_f port map (enc, ct_out_10, k_11, k_32, ct_in_11);
	ROUND_F_12 : round_f port map (enc, ct_out_11, k_12, k_31, ct_in_12);
	ROUND_F_13 : round_f port map (enc, ct_out_12, k_13, k_30, ct_in_13);
	ROUND_F_14 : round_f port map (enc, ct_out_13, k_14, k_29, ct_in_14);
	ROUND_F_15 : round_f port map (enc, ct_out_14, k_15, k_28, ct_in_15);
	ROUND_F_16 : round_f port map (enc, ct_out_15, k_16, k_27, ct_in_16);
	ROUND_F_17 : round_f port map (enc, ct_out_16, k_17, k_26, ct_in_17);
	ROUND_F_18 : round_f port map (enc, ct_out_17, k_18, k_25, ct_in_18);
	ROUND_F_19 : round_f port map (enc, ct_out_18, k_19, k_24, ct_in_19);
	ROUND_F_20 : round_f port map (enc, ct_out_19, k_20, k_23, ct_in_20);
	ROUND_F_21 : round_f port map (enc, ct_out_20, k_21, k_22, ct_in_21);
	ROUND_F_22 : round_f port map (enc, ct_out_21, k_22, k_21, ct_in_22);
	ROUND_F_23 : round_f port map (enc, ct_out_22, k_23, k_20, ct_in_23);
	ROUND_F_24 : round_f port map (enc, ct_out_23, k_24, k_19, ct_in_24);
	ROUND_F_25 : round_f port map (enc, ct_out_24, k_25, k_18, ct_in_25);
	ROUND_F_26 : round_f port map (enc, ct_out_25, k_26, k_17, ct_in_26);
	ROUND_F_27 : round_f port map (enc, ct_out_26, k_27, k_16, ct_in_27);
	ROUND_F_28 : round_f port map (enc, ct_out_27, k_28, k_15, ct_in_28);
	ROUND_F_29 : round_f port map (enc, ct_out_28, k_29, k_14, ct_in_29);
	ROUND_F_30 : round_f port map (enc, ct_out_29, k_30, k_13, ct_in_30);
	ROUND_F_31 : round_f port map (enc, ct_out_30, k_31, k_12, ct_in_31);
	ROUND_F_32 : round_f port map (enc, ct_out_31, k_32, k_11, ct_in_32);
	ROUND_F_33 : round_f port map (enc, ct_out_32, k_33, k_10, ct_in_33);
	ROUND_F_34 : round_f port map (enc, ct_out_33, k_34, k_9, ct_in_34);
	ROUND_F_35 : round_f port map (enc, ct_out_34, k_35, k_8, ct_in_35);
	ROUND_F_36 : round_f port map (enc, ct_out_35, k_36, k_7, ct_in_36);
	ROUND_F_37 : round_f port map (enc, ct_out_36, k_37, k_6, ct_in_37);
	ROUND_F_38 : round_f port map (enc, ct_out_37, k_38, k_5, ct_in_38);
	ROUND_F_39 : round_f port map (enc, ct_out_38, k_39, k_4, ct_in_39);
	ROUND_F_40 : round_f port map (enc, ct_out_39, k_40, k_3, ct_in_40);
	ROUND_F_41 : round_f port map (enc, ct_out_40, k_41, k_2, ct_in_41);
	ROUND_F_42 : round_f port map (enc, ct_out_41, k_42, k_1, ct_in_42);
	ROUND_F_43 : round_f port map (enc, ct_out_42, k_43, k_0, ct_in_43);

	block_out <= ct_in_43;
		
	-- SIMON Core
	pr_smn : process(clk, rst, enc, key, key_s)
	begin
		-- no rst switch/phase distinction needed due to full unrolling of key schedule
		key_s(0) <= key(31 downto 0);
		key_s(1) <= key(63 downto 32);
		key_s(2) <= key(95 downto 64);
		key_s(3) <= key(127 downto 96);
	end process;
	
end Behavioral;