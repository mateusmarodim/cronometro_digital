library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity latch_t is
    Port ( T, CLK, RST : in  STD_LOGIC;
           Q, Q_bar : out  STD_LOGIC);
end latch_t;

architecture Behavioral of latch_t is
    signal temp : STD_LOGIC;
begin
    process(CLK, RST)
    begin
        if RST = '1' then
            temp <= '0';
        elsif rising_edge(CLK) then
            if T = '1' then
                temp <= not temp;
            end if;
        end if;
    Q <= temp;
    Q_bar <= not temp;
    end process;


end Behavioral;