library ieee;
use ieee.std_logic_1164.all;

entity maquina_de_estados is
    port (
        CLK: in std_logic;
        RST: in std_logic;
        EN: in std_logic;
        CLR: in std_logic;
        CONT_CLEAR: out std_logic;
        CONT_RESET: out std_logic;
        CONT_ENABLE: out std_logic
    );
end entity;

architecture a_maquina_de_estados of maquina_de_estados is
    type estado_type is (RESET, COUNT, NCOUNT);
    signal estado_atual: estado_type;

begin

process (RST,CLK)
begin
    if RST = '1' then
        estado_atual <= RESET;
        CONT_RESET <= '1';
    elsif CLK'event and CLK = '1' then
        if estado_atual = RESET then
            if RST = '0' then
                estado_atual <= COUNT;
                CONT_RESET <= '0';
                CONT_ENABLE <= '1';
                CONT_CLEAR <= '0';
            end if;
        elsif estado_atual = COUNT then
            if EN = '1' then
                estado_atual <= NCOUNT;
                CONT_RESET <= '0';
                CONT_ENABLE <= '0';
                CONT_CLEAR <= '0';
            end if;
        elsif estado_atual = NCOUNT then
            CONT_CLEAR <= CLR;
            if EN = '1' then
                estado_atual <= COUNT;
                CONT_RESET <= '0';
                CONT_ENABLE <= '1';
                CONT_CLEAR <= '0'; 
            end if;
        end if;
    end if;
end process;

end architecture;
                