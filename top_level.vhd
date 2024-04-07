library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
    port (
        EN: in std_logic;
        RST: in std_logic;
        CLK: in std_logic;
        SEG_UNIDADE: out std_logic_vector(6 downto 0);
        SEG_DEZENA: out std_logic_vector(6 downto 0);
        CENT_UNIDADE: out std_logic_vector(6 downto 0);
        CENT_DEZENA: out std_logic_vector(6 downto 0)
    );
end entity;

architecture a_top_level of top_level is
component cronometro is
    port (
        CLK, EN, RST: in std_logic;
        SEG_UNIDADE: out std_logic_vector(3 downto 0);
        SEG_DEZENA: out std_logic_vector(3 downto 0);
        CENT_UNIDADE: out std_logic_vector(3 downto 0);
        CENT_DEZENA: out std_logic_vector(3 downto 0)
    );
end component;

component dec_bcd_7seg is 
    port(
        BCD:in  std_logic_vector(3 downto 0);
        SEGMENT7: out std_logic_vector(6 downto 0)
    );
end component;
    
component divisor is
    port(
        CLK: in std_logic;
        RST: in std_logic;
        DIV50: out std_logic
	);
end component;

component latch_t is
    Port ( T, CLK, RST : in  STD_LOGIC;
           Q, Q_bar : out  STD_LOGIC);
end component;
signal q_bar_s: std_logic;
signal cronometro_clk_s: std_logic;
signal cronometro_en_s: std_logic;
signal seg_dezena_s: std_logic_vector(3 downto 0);
signal seg_unidade_s: std_logic_vector(3 downto 0);
signal cent_dezena_s: std_logic_vector(3 downto 0);
signal cent_unidade_s: std_logic_vector(3 downto 0);
signal seg_dezena_7seg_s: std_logic_vector(6 downto 0);
signal seg_unidade_7seg_s: std_logic_vector(6 downto 0);
signal cent_dezena_7seg_s: std_logic_vector(6 downto 0);
signal cent_unidade_7seg_s: std_logic_vector(6 downto 0);
begin
    DIV: divisor port map(
        CLK => CLK,
        RST => RST,
        DIV50 => cronometro_clk_s
    );

    CRON: cronometro port map(
        CLK => cronometro_clk_s,
        EN => EN,
        RST => RST,
        SEG_UNIDADE => seg_unidade_s,
        SEG_DEZENA => seg_dezena_s,
        CENT_UNIDADE => cent_unidade_s,
        CENT_DEZENA => cent_dezena_s
    );

    DEC_SEG_DEZENA: dec_bcd_7seg port map(
        BCD => seg_dezena_s,
        SEGMENT7 => seg_dezena_7seg_s
    );

    DEC_SEG_UNIDADE: dec_bcd_7seg port map(
        BCD => seg_unidade_s,
        SEGMENT7 => seg_unidade_7seg_s
    );
    DEC_CENT_DEZENA: dec_bcd_7seg port map(
        BCD => cent_dezena_s,
        SEGMENT7 => cent_dezena_7seg_s
    );
    DEC_CENT_UNIDADE: dec_bcd_7seg port map(
        BCD => cent_unidade_s,
        SEGMENT7 => cent_unidade_7seg_s
    );

    LATCH: latch_t port map(
        Q => cronometro_en_s,
        CLK => CLK,
        T => EN,
        Q_bar => q_bar_s,
        RST => RST
    );

    SEG_UNIDADE <= seg_unidade_7seg_s;
    SEG_DEZENA <= seg_dezena_7seg_s;
    CENT_UNIDADE <= cent_unidade_7seg_s;
    CENT_DEZENA <= cent_dezena_7seg_s;

end architecture;