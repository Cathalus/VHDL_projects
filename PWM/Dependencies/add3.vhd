-- Add3: Adder for binary to bcd converter
-- File: Add3.vhd
-- 2004-07-15 H. Frey 
---------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-- Entity -----------------------------------------------------------------
entity Add3 is
    port(A:     in  std_logic_vector(3 downto 0);    -- input
         S:     out std_logic_vector(3 downto 0));   -- output
end entity Add3;
-- Architecture -----------------------------------------------------------
architecture arch_Add3 of Add3 is
begin
    -- process: counter
    proc_wht: process(A)
    begin
        case A is
            when "0000" => S <= "0000"; -- 0 -> 0
            when "0001" => S <= "0001"; -- 1 -> 1
            when "0010" => S <= "0010"; -- 2 -> 2
            when "0011" => S <= "0011"; -- 3 -> 3
            when "0100" => S <= "0100"; -- 4 -> 4
            when "0101" => S <= "1000"; -- 5 + 3 =  8
            when "0110" => S <= "1001"; -- 6 + 3 =  9
            when "0111" => S <= "1010"; -- 7 + 3 = 10
            when "1000" => S <= "1011"; -- 8 + 3 = 11
            when "1001" => S <= "1100"; -- 9 + 3 = 12 
            when others => S <= "----"; -- rest: don't care
        end case;
    end process proc_wht;
end architecture arch_Add3;

