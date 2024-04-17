library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cronometro_tb is
end entity;

architecture a_cronometro_tb of cronometro_tb is
component cronometro is
    port (
        CLK, EN, RST, CONT_CLEAR: in std_logic;
        SEG_UNIDADE: out std_logic_vector(3 downto 0);
        SEG_DEZENA: out std_logic_vector(3 downto 0);
        CENT_UNIDADE: out std_logic_vector(3 downto 0);
        CENT_DEZENA: out std_logic_vector(3 downto 0)
    );
end component;
signal en_s: std_logic;
signal rst_s: std_logic;
signal clk_s: std_logic;
signal clr_s: std_logic;
signal seg_dezena_s: std_logic_vector(3 downto 0);
signal seg_unidade_s: std_logic_vector(3 downto 0);
signal cent_dezena_s: std_logic_vector(3 downto 0);
signal cent_unidade_s: std_logic_vector(3 downto 0);
begin
    CRONOMETRO_UNIT: cronometro port map (
        EN => en_s,
        RST => rst_s,
        CLK => clk_s,
        CONT_CLEAR => clr_s,
        SEG_DEZENA => seg_dezena_s,
        SEG_UNIDADE => seg_unidade_s,
        CENT_DEZENA => cent_dezena_s,
        CENT_UNIDADE => cent_unidade_s
    );

    RST_GEN: Process
    Begin
        RST_s <= '1';
        WAIT FOR 1.5 ns;
        RST_s <= '0';
        WAIT;
    End Process;

    EN_GEN: Process
    Begin
        EN_s <= '1';
        WAIT FOR 15000 ns;
        EN_s <= '0';
        WAIT;
    End Process;

    CLK_GEN: Process
    Begin
        CLK_s <= '0';
        WAIT FOR 1 ns;
        CLK_s <= '1';
        WAIT FOR 1 ns;
    End Process;

    CLR_GEN: Process
    Begin
        CLR_s <= '0';
        WAIT FOR 2160 ns;
        CLR_s <= '1';
        WAIT FOR 20 ns;
        CLR_s <= '0';
        wait;
    End Process;

end architecture;
