Library IEEE;
USE IEEE.Std_logic_1164.all;

entity latch_t_tb is 
end entity;

architecture a of latch_t_tb is
component latch_t is
    port (
        Q: out std_logic;
        CLK: in std_logic;
        T: in std_logic;
        Q_bar: out std_logic;
        RST: in std_logic
    );
end component;
signal q_s: std_logic;
signal clk_s: std_logic;
signal rst_s: std_logic;
signal t_s: std_logic;
signal q_bar_s: std_logic;
begin
    LATCH: latch_t port map(
        Q => q_s,
        CLK => clk_s,
        T => t_s,
        Q_bar => q_bar_s,
        RST => rst_s
    );

    RST_GEN: Process
    Begin
        rst_s <= '1';
        wait for 15 ns;
        rst_s <= '0';
        wait;
    End Process;

    CLK_GEN: Process
    Begin
        clk_s <= '0';
        WAIT FOR 10 ns;
        clk_s <= '1';
        WAIT FOR 10 ns;
    End Process;

    T_gen: Process
    Begin
        t_s <= '0';
        wait for 100 ns;
        t_s <= '1';
        wait for 15 ns;
        t_s <= '0';
        wait for 100 ns;
        t_s <= '1';
        wait for 20 ns;
        t_s <= '0';
        wait;
    end process;
end architecture;