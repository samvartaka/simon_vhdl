-- SIMON 64/128
-- Simon core component (encryption and decryption presume pre-expansion of key to RAM)
--
-- @Author: Jos Wetzels
-- @Author: Wouter Bokslag
--
-- Parameters:
--        clk: clock
--        rst: reset state
--        enc: encrypt/decrypt mode
--        key: key
--   block_in: plaintext block
--  block_out: ciphertext block
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity simon is
	port(clk : in std_logic;
	     rst : in std_logic_vector(1 downto 0); -- state indicator (11 = init, 01 = pre-expand, 00 = run)
	     enc : in std_logic; -- (0 = enc, 1 = dec)
	     key : in std_logic_vector(127 downto 0);
	     block_in : in std_logic_vector(63 downto 0);
	     block_out : out std_logic_vector(63 downto 0));
end simon;

architecture Behavioral of simon is

	component round_f is
	port(v_in : in std_logic_vector(63 downto 0);
	     v_k : in std_logic_vector(31 downto 0);
         v_out : out std_logic_vector(63 downto 0)
         );
	end component;

	component key_schedule is
       	port (r : in std_logic_vector(7 downto 0);
		      k_0 : in std_logic_vector(31 downto 0);
		      k_1 : in std_logic_vector(31 downto 0);
		      k_3 : in std_logic_vector(31 downto 0);
		      subkey_out : out std_logic_vector(31 downto 0));
	end component;

	component ram is
       	port (data_in : in std_logic_vector(31 downto 0);
			  rw : in std_logic;
			  clk : in std_logic;
			  address : in std_logic_vector(7 downto 0);
			  data_out : out std_logic_vector(31 downto 0));
	end component;

	type key_t is array (0 to 3) of std_logic_vector(31 downto 0);
	
	signal r_s : std_logic_vector(7 downto 0); -- round index
	signal key_s : key_t; -- intermediate key (in words)
	signal subkey_out_s : std_logic_vector(31 downto 0); -- round key

	signal v_in_s : std_logic_vector(63 downto 0); -- intermediate 'plaintext'
	signal v_out_s : std_logic_vector(63 downto 0); -- intermediate 'ciphertext'

	signal ram_rw : std_logic;
	signal ram_data_out : std_logic_vector(31 downto 0);
begin

	KEY_SCHEDULE_0 : key_schedule port map (r_s, key_s(0), key_s(1), key_s(3), subkey_out_s);
	ROUND_F_0 : round_f port map (v_in_s, ram_data_out, v_out_s);

	-- round index is used as ram address, round key is ram input
	RAM_0 : ram port map (subkey_out_s, ram_rw, clk, r_s, ram_data_out);

	pr_r : process(clk, rst)
	begin
		if rising_edge(clk) then
			-- initialization clock
			if rst = "11" then
				r_s <= (others => '0');

			-- pre-expansion clock
			elsif rst = "01" then
				if (r_s = X"2B") then
					if (enc = '0') then
						r_s <= (others => '0');
					else
						r_s <= X"2A";
					end if;
				else
					r_s <= std_logic_vector(unsigned(r_s) + 1);
				end if;
			-- running clock
			else
				if enc = '0' then
					if r_s /= X"2B" then
						r_s <= std_logic_vector(unsigned(r_s) + 1);
					end if;
				else
					if r_s /= X"00" then
						r_s <= std_logic_vector(unsigned(r_s) - 1);
					end if;
				end if;
			end if;
		end if;
	end process;

	-- SIMON Core
	-- Take 2 clock cycle for initialization (since we route key through RAM) + 1 clock cycle per round for encryption/decryption
	pr_smn : process(clk, rst, enc, r_s, key, key_s, subkey_out_s, block_in, v_in_s, v_out_s, ram_rw, ram_data_out)
	begin
		if rising_edge(clk) then
			-- initalize
			if rst = "11" then
				if enc = '0' then
					v_in_s <= block_in;
				else
					v_in_s <= block_in(31 downto 0) & block_in(63 downto 32);
				end if;
				
				-- initialize intermediate key from master key
				key_s(0) <= key(31 downto 0);
				key_s(1) <= key(63 downto 32);
				key_s(2) <= key(95 downto 64);
				key_s(3) <= key(127 downto 96);

				-- write pre-expansion to RAM
				ram_rw <= '1';

			-- pre-expansion (run 0x2C times, 0x2B to expand + 1 to put correct value on ram_data_out)
			elsif rst = "01" then
				-- intermediate key rotates for initial 4 key words, beyond that gets gradually filled in by expansion
				key_s(0) <= key_s(1);
				key_s(1) <= key_s(2);
				key_s(2) <= key_s(3);
				key_s(3) <= subkey_out_s;

				if r_s = X"2B" then
					ram_rw <= '0';
				end if;
			-- run
			else
				v_in_s <= v_out_s;
			end if;
		end if;		
	end process;

	block_out <= v_out_s when (enc = '0') else v_out_s(31 downto 0) & v_out_s(63 downto 32);

end Behavioral;