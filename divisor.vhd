Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity divisor is
port	
    (
		-- responsável por ajustar o clock da placa na proporção desejada
        CLK: in std_logic;
        RST: in std_logic;
        DIV50: out std_logic
	);
		 
End entity;

Architecture a_divisor of divisor is


SIGNAL CONT: integer range 0 to 500000;

begin
process (RST,CLK)
begin
	if RST = '1' then
		DIV50 <= '0';
		CONT <= 0;
	Elsif CLK = '1' and CLK'event then
		if CONT = 500000 then
			DIV50 <= '1';
			CONT <= 0;
		ELSE
			CONT <= CONT +1;
			DIV50 <= '0';
		end if;
	end if;
end process;
end architecture;