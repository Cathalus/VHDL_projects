-- Convert a 8 bit binary number to 3 bcd numbers
-- File: Bin2Bcd.vhd
-- 2004-07-15 H. Frey 
---------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-- Entity -----------------------------------------------------------------
entity Bin2Bcd is
    port(Inp:     in  std_logic_vector(7 downto 0);    -- input
         BcdA:    out std_logic_vector(3 downto 0);    -- output: BCD A = units
         BcdB:    out std_logic_vector(3 downto 0);    -- output: BCD B = tens
         BcdC:    out std_logic_vector(3 downto 0));   -- output: BCD C = hundreds
end entity Bin2Bcd;
-- Architecture -----------------------------------------------------------
architecture arch_Bin2Bcd of Bin2Bcd is
-- local signals
signal C1in:  std_logic_vector(3 downto 0);
signal C2in:  std_logic_vector(3 downto 0);
signal C3in:  std_logic_vector(3 downto 0);
signal C4in:  std_logic_vector(3 downto 0);
signal C5in:  std_logic_vector(3 downto 0);
signal C6in:  std_logic_vector(3 downto 0);
signal C7in:  std_logic_vector(3 downto 0);
signal C1out: std_logic_vector(3 downto 0);
signal C2out: std_logic_vector(3 downto 0);
signal C3out: std_logic_vector(3 downto 0);
signal C4out: std_logic_vector(3 downto 0);
signal C5out: std_logic_vector(3 downto 0);
signal C6out: std_logic_vector(3 downto 0);
signal C7out: std_logic_vector(3 downto 0);
-- component declararion
-- add 3 if input is larger than 4
component Add3 is
    port(A:     in  std_logic_vector(3 downto 0);    -- input
         S:     out std_logic_vector(3 downto 0));   -- output
end component Add3;

begin
    -- shift and add
    C1in <= '0' & Inp(7 downto 5);
    C1: Add3 port map(C1in, C1out);
    C2in <= C1out(2 downto 0) & Inp(4);
    C2: Add3 port map(C2in, C2out);
    C3in <= C2out(2 downto 0) & Inp(3);
    C3: Add3 port map(C3in, C3out);
    C4in <= C3out(2 downto 0) & Inp(2);
    C4: Add3 port map(C4in, C4out);
    C5in <= C4out(2 downto 0) & Inp(1);
    C5: Add3 port map(C5in, C5out);
    C6in <= '0' & C1out(3) & C2out(3) & C3out(3);
    C6: Add3 port map(C6in, C6out);
    C7in <= C6out(2 downto 0) & C4out(3);
    C7: Add3 port map(C7in, C7out);
    -- set output
    BcdC <= '0' & '0' & C6out(3) & C7out(3); -- hundreds
    BcdB <= C7out(2 downto 0) & C5out(3);    -- tens
    BcdA <= C5out(2 downto 0) & Inp(0);      -- units

end architecture arch_Bin2Bcd;

