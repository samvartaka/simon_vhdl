-- SIMON 64/128
-- Simon core component
--
-- K=1 inner-round pipelining based of iterative cache-routing architecture
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
	     rst : in std_logic; -- state indicator (1 = init, 0 = run)
	     enc : in std_logic; -- (0 = enc, 1 = dec)
	     key : in std_logic_vector(127 downto 0);
	     block_in : in std_logic_vector(63 downto 0);
	     block_out : out std_logic_vector(63 downto 0));
end simon;

architecture Behavioral of simon is

	component round_f is
	port(clk : in std_logic;
	     rst : in std_logic;

	     v_in : in std_logic_vector(63 downto 0);
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
	ROUND_F_0 : round_f port map (clk, rst, v_in_s, key_s(0), v_out_s);
	RAM_0 : ram port map (key_s(0), ram_rw, clk, r_s, ram_data_out);

	-- SIMON round index regulation
	pr_r : process(clk, rst)
	begin
		if rising_edge(clk) then
			-- initialization clock
			if rst = '1' then
				if enc = '0' then
					if (r_s = X"00") then
						r_s <= X"01";
					else
						r_s <= (others => '0');
					end if;
				else
					r_s <= std_logic_vector(unsigned(r_s) - 1);
				end if;
			-- running clock
			else
				if enc = '0' then
					if r_s /= X"2B" then
						r_s <= std_logic_vector(unsigned(r_s) + 1);
					else
						-- in preparation for subsequent decryption
						r_s <= std_logic_vector(unsigned(r_s) - 1);
					end if;
				else
					if r_s /= X"00" then
						r_s <= std_logic_vector(unsigned(r_s) - 1);
					end if;
				end if;
			end if;
		end if;
	end process;

	-- SIMON key cache rotation
	pr_ks : process(clk, rst, key_s, key, ram_data_out, subkey_out_s)
	begin
		if rising_edge(clk) then
			if enc = '0' then
				if rst = '1' then
					key_s(0) <= key(31 downto 0);
					key_s(1) <= key(63 downto 32);
					key_s(2) <= key(95 downto 64);
					key_s(3) <= key(127 downto 96);
				else
					-- final iteration is just to write final round key to ram
					if (r_s /= X"2B") then
						key_s(0) <= key_s(1);
						key_s(1) <= key_s(2);
						key_s(2) <= key_s(3);
						key_s(3) <= subkey_out_s;
					end if;
				end if;
			else
				key_s(0) <= ram_data_out;
			end if;
		end if;
	end process;

	-- SIMON Core
	pr_smn : process(clk, rst, enc, r_s, block_in, v_in_s, v_out_s, ram_rw)
	begin
		if rising_edge(clk) then
			-- initalize
			if rst = '1' then
				if enc = '0' then
					v_in_s <= block_in;

					-- write every round key to RAM during encryption
					-- so that encryption also functions as pre-expansion for decryption
					ram_rw <= '1';
				else
					-- swap blocks for decryption
					v_in_s <= block_in(31 downto 0) & block_in(63 downto 32);

					ram_rw <= '0';
				end if;
			-- run
			else
				if enc = '0' then
					if (r_s /= X"2B") then
						v_in_s <= v_out_s;
					else
						ram_rw <= '0';
					end if;
				else
					v_in_s <= v_out_s;
				end if;
			end if;
		end if;		
	end process;

	-- v_in_s instead of v_out_s during decryption because of inner-round pipelining with negative-edge triggered registers
	block_out <= v_out_s when (enc = '0') else v_in_s(31 downto 0) & v_in_s(63 downto 32);

end Behavioral;