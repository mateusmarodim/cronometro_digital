library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cont_mod_100_tb is
end entity;

architecture a_cont_mod_100_tb of cont_mod_100_tb is
component cont_mod_100 is
    port (
        EN: in std_logic;
        RST: in std_logic;
        CLK: in std_logic;
        DEZENA: out std_logic_vector(3 downto 0);
        UNIDADE: out std_logic_vector(3 downto 0)
    );
end component;
signal en_s: std_logic;
signal rst_s: std_logic;
signal clk_s: std_logic;
signal dezena_s: std_logic_vector(3 downto 0);
signal unidade_s: std_logic_vector(3 downto 0);
begin
    CONT_100: cont_mod_100 port map (
        EN => en_s,
        RST => rst_s,
        CLK => clk_s,
        DEZENA => dezena_s,
        UNIDADE => unidade_s
    );

    RST_GEN: Process
    Begin
        RST_s <= '1';
        WAIT FOR 25 ns;
        RST_s <= '0';
        WAIT;
    End Process;

    EN_GEN: Process
    Begin
        EN_s <= '1';
        WAIT FOR 2500 ns;
        EN_s <= '0';
        WAIT;
    End Process;

    CLK_GEN: Process
    Begin
        CLK_s <= '0';
        WAIT FOR 10 ns;
        CLK_s <= '1';
        WAIT FOR 10 ns;
    End Process;

    -- CLR_GEN: Process
    -- Begin
    --     CLR_s <= '0';
    --     WAIT FOR 21100 ns;
    --     CLR_s <= '1';
    --     WAIT FOR 20 ns;
    --     CLR_s <= '0';
    --     wait;
    -- End Process;

end architecture;
