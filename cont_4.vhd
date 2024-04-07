library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cont_4 is
	port(
		CLK: in std_logic;
		RST: in std_logic;
		EN: in std_logic;
		CLR: in std_logic;
		Q: out std_logic_vector(3 downto 0)
	);
end entity;

architecture rtl of cont_4 is
signal CONT: std_logic_vector(3 downto 0);
begin
	process(CLK, RST)
	begin
		if (RST = '1') then
			CONT <= (others => '0');
		elsif (CLK'event and CLK = '1') then
			if (CLR = '1') then
				CONT <= (others => '0');
			else
				if (EN = '1') then
					CONT <= std_logic_vector(unsigned(CONT) + 1);
				end if;
			end if;
		end if;
	end process;
	Q <= CONT;
end architecture;