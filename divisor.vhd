Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity divisor is

port	
    (
        CLK: in std_logic;
        RST: in std_logic;
        DIV50: out std_logic
	);
		 
End entity;

Architecture a_divisor of divisor is

--SIGNAL LEDAUX: std_logic;
SIGNAL CONT: integer range 0 to 50000000;

begin
process (RST,CLK)
begin
	if RST = '1' then
		DIV50 <= '0';
		CONT <= 0;
	Elsif CLK = '1' and CLK'event then
		if CONT = 50000000 then
			--LEDAUX <= '1';
			DIV50 <= '1';
			CONT <= 0;
		ELSE
			--LEDAUX <= '0';
			CONT <= CONT +1;
			DIV50 <= '0';
		end if;
	end if;
--DIV50 <= LEDAUX;
end process;
end architecture;