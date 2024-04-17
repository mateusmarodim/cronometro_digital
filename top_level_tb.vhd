library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level_tb is
end entity;

architecture a_top_level_tb of top_level_tb is
component top_level is
   port (
        EN: in std_logic;
        RST: in std_logic;
        CLK: in std_logic;
        CLR: in std_logic;
        SEG_UNIDADE: out std_logic_vector(6 downto 0);
        SEG_DEZENA: out std_logic_vector(6 downto 0);
        CENT_UNIDADE: out std_logic_vector(6 downto 0);
        CENT_DEZENA: out std_logic_vector(6 downto 0)
    );
end component;
signal en_s: std_logic;
signal rst_s: std_logic;
signal clk_s: std_logic;
signal clr_s: std_logic;
signal seg_dezena_s: std_logic_vector(6 downto 0);
signal seg_unidade_s: std_logic_vector(6 downto 0);
signal cent_dezena_s: std_logic_vector(6 downto 0);
signal cent_unidade_s: std_logic_vector(6 downto 0);
begin
    top_level_UNIT: top_level port map (
        EN => en_s,
        RST => rst_s,
        CLK => clk_s,
        CLR => clr_s,
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
        EN_s <= '';
        WAIT FOR 25000 ns;
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
