library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity dec_bcd_7seg is

port(
    -- entra com sinal BCD de 4 bits e converte para sinal de 7 segmentos
	BCD		:in  std_logic_vector(3 downto 0);
	SEGMENT7	:out std_logic_vector(6 downto 0)

);
end Entity;

architecture a_dec_bcd_7seg of dec_bcd_7seg is
begin

	SEGMENT7 <= "0111111" when BCD = x"0" else -- 0
                "0000110" when BCD = x"1" else -- 1
                "1011011" when BCD = x"2" else -- 2
                "1001111" when BCD = x"3" else -- 3
            
                "1100110" when BCD = x"4" else -- 4
                "1101101" when BCD = x"5" else -- 5
                "1111101" when BCD = x"6" else -- 6
                "0000111" when BCD = x"7" else -- 7
                
                "1111111" when BCD = x"8" else -- 8
                "1100111" when BCD = x"9" else -- 9
                "1110111" when BCD = x"A" else -- A
                "1111100" when BCD = x"B" else -- B
                
                "0111001" when BCD = x"C" else -- C
                "1011110" when BCD = x"D" else -- D
                "1111001" when BCD = x"E" else -- E
                "1110001" when BCD = x"F";	   -- F
				
end a_dec_bcd_7seg;