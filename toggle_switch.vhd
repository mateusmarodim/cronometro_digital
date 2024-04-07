library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity toggle_switch is
    Port (
        Button : in  STD_LOGIC;
        Switch : out STD_LOGIC
    );
end toggle_switch;

architecture a_toggle_switch of toggle_switch is
    signal Toggle : STD_LOGIC := '1';  -- sinal para alternar entre 0 e 1
begin
    process(Button)
    begin
        if rising_edge(Button) then
            Toggle <= not Toggle;  -- Inverte o valor de Toggle quando o botão é pressionado
        end if;
    Switch <= Toggle;  -- Atribui o valor de Toggle ao Switch
    end process;

end a_toggle_switch;