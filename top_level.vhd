library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is -- integração de todos os componentes para interfacear com a placa
    port (
        EN: in std_logic;
        RST: in std_logic;
        CLR: in std_logic;
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
        CLK, EN, RST, CONT_CLEAR: in std_logic;
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

component toggle_switch is
    port (
        Button : in  STD_LOGIC;
        Switch : out STD_LOGIC
    );
end component;

component maquina_de_estados is
    port (
        CLK: in std_logic;
        RST: in std_logic;
        EN: in std_logic;
        CLR: in std_logic;
        CONT_CLEAR: out std_logic;
        CONT_RESET: out std_logic;
        CONT_ENABLE: out std_logic
    );
end component;

signal q_bar_s: std_logic;
signal cronometro_clk_s: std_logic;
signal cronometro_en_s: std_logic;
signal cont_clear_s: std_logic;
signal cont_reset_s: std_logic;
signal cont_enable_s: std_logic;
signal seg_dezena_s: std_logic_vector(3 downto 0);
signal seg_unidade_s: std_logic_vector(3 downto 0);
signal cent_dezena_s: std_logic_vector(3 downto 0);
signal cent_unidade_s: std_logic_vector(3 downto 0);
signal seg_dezena_7seg_s: std_logic_vector(6 downto 0);
signal seg_unidade_7seg_s: std_logic_vector(6 downto 0);
signal cent_dezena_7seg_s: std_logic_vector(6 downto 0);
signal cent_unidade_7seg_s: std_logic_vector(6 downto 0);
signal estado_en_s: std_logic;
signal estado_clr_s: std_logic;

begin
    DIV: divisor port map(
        CLK => CLK,
        RST => '0',
        DIV50 => cronometro_clk_s
    );

    CRON: cronometro port map(
        CLK => cronometro_clk_s,
        EN => cont_enable_s,
        RST => cont_reset_s,
        CONT_CLEAR => cont_clear_s,
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

    ESTADO: maquina_de_estados port map(
        CLK => cronometro_clk_s,
        RST => RST, --switch
        EN => estado_en_s, -- botao 1
        CLR => estado_clr_s, -- botao 2
        CONT_CLEAR => cont_clear_s, -- signal para limpar contagem
        CONT_RESET => cont_reset_s, -- signal para reset do cronometro
        CONT_ENABLE => cont_enable_s -- signal para ativar/desativar a contagem
    );

    estado_en_s <= not EN;
    estado_clr_s <= not CLR;

    SEG_UNIDADE <= not seg_unidade_7seg_s;
    SEG_DEZENA <= not seg_dezena_7seg_s;
    CENT_UNIDADE <= not cent_unidade_7seg_s;
    CENT_DEZENA <= not cent_dezena_7seg_s;
    

end architecture;