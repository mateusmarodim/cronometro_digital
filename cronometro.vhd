library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cronometro is
    port (
        CLK, EN, RST, CONT_CLEAR: in std_logic;
        SEG_UNIDADE: out std_logic_vector(3 downto 0);
        SEG_DEZENA: out std_logic_vector(3 downto 0);
        CENT_UNIDADE: out std_logic_vector(3 downto 0);
        CENT_DEZENA: out std_logic_vector(3 downto 0)
    );
end entity;

architecture a_cronometro of cronometro is
component cont_mod_100 is
    port (
        EN: in std_logic;
        RST: in std_logic;
        CLK: in std_logic;
        CLR: in std_logic;
        CLR_OUT: out std_logic;
        DEZENA: out std_logic_vector(3 downto 0);
        UNIDADE: out std_logic_vector(3 downto 0)
    );
end component;

component cont_mod_60 is
    port (
        EN: in std_logic;
        RST: in std_logic;
        CLK: in std_logic;
        CLR: in std_logic;
        CLR_GERAL: in std_logic;
        DEZENA: out std_logic_vector(3 downto 0);
        UNIDADE: out std_logic_vector(3 downto 0)
    );
end component;
signal cent_dezena_s: std_logic_vector(3 downto 0);
signal cent_unidade_s: std_logic_vector(3 downto 0);
signal en_segundos_s: std_logic;
signal clr_segundos_s: std_logic;
signal clr_centesimos_s: std_logic;
begin
    -- instancia um contador mod 60 (BCD) para os segundos
    CONT_SEGUNDOS: cont_mod_60 port map (
        EN => en_segundos_s,
        RST => RST,
        CLK => CLK,
        CLR => clr_centesimos_s,
        CLR_GERAL => CONT_CLEAR,
        DEZENA => SEG_DEZENA,
        UNIDADE => SEG_UNIDADE
    );
    -- instancia um contador mod 100 (BCD) para os centésimos

    CONT_CENTESIMOS: cont_mod_100 port map (
        EN => EN,
        RST => RST,
        CLK => CLK,
        CLR => CONT_CLEAR,
        CLR_OUT => clr_centesimos_s,
        DEZENA => cent_dezena_s,
        UNIDADE => cent_unidade_s
    );

    -- ativa o EN do contador dos segundos quando os centésimos chegam em 99
    en_segundos_s <= '1' when cent_dezena_s = "1001" and cent_unidade_s = "1001" else '0';

    CENT_DEZENA <= cent_dezena_s;
    CENT_UNIDADE <= cent_unidade_s;
end architecture;