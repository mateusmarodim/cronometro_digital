library ieee;
use ieee.std_logic_1164.all;

entity maquina_de_estados_tb is
end entity;

architecture tb_arch of maquina_de_estados_tb is
    -- Component Declaration
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
    
    -- Testbench Signals
    signal CLK_tb, RST_tb, EN_tb, CLR_tb: std_logic := '0';
    signal CONT_CLEAR_tb, CONT_RESET_tb, CONT_ENABLE_tb: std_logic;
    
begin
    -- Instantiate the DUT (Design Under Test)
    dut: maquina_de_estados port map (
        CLK => CLK_tb,
        RST => RST_tb,
        EN => EN_tb,
        CLR => CLR_tb,
        CONT_CLEAR => CONT_CLEAR_tb,
        CONT_RESET => CONT_RESET_tb,
        CONT_ENABLE => CONT_ENABLE_tb
    );
    
    -- Clock Process
    clk_process: process
    begin
        while now < 1000 ns loop
            CLK_tb <= '0';
            wait for 5 ns;
            CLK_tb <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;
    
    -- Stimulus Process
    stimulus: process
    begin
        RST_tb <= '1'; -- Initial Reset
        wait for 10 ns;
        RST_tb <= '0'; -- Release Reset
        
        wait for 10 ns;
        EN_tb <= '1'; -- Enable
        wait for 20 ns;
        
        EN_tb <= '0'; -- Disable
        wait for 20 ns;
        
        CLR_tb <= '1'; -- Clear
        wait for 20 ns;
        CLR_tb <= '0'; -- Release Clear
        
        wait;
    end process;
    
    -- Monitor Process
    monitor: process
    begin
        wait for 5 ns; -- Wait for stable signals
        while now < 1000 ns loop
            report "Time = " & time'image(now) &
                   ", CONT_CLEAR = " & std_logic'image(CONT_CLEAR_tb) &
                   ", CONT_RESET = " & std_logic'image(CONT_RESET_tb) &
                   ", CONT_ENABLE = " & std_logic'image(CONT_ENABLE_tb);
            wait for 5 ns;
        end loop;
        wait;
    end process;
    
end architecture;
