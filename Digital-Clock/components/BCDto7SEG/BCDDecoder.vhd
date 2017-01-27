----------------------------------------------------------
-- BCD to 7 Segment DECODER
-- Raymond Walter, Paul Flaemig-Abrell 2016-10-27
----------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

----------------------------------------------------------
-- ENTITY
----------------------------------------------------------
ENTITY BCDDecoder is
	PORT(	Inp		:  IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
			Outp	:  OUT		STD_LOGIC_VECTOR(6 DOWNTO 0));
END BCDDecoder;

----------------------------------------------------------
-- ARCHITECTURE
----------------------------------------------------------
ARCHITECTURE arch_BCDDecoder of BCDDecoder is
BEGIN
	PROCESS(Inp)
	BEGIN
		CASE Inp IS 				   	-- GFEDCBA  		active low
			WHEN	"0000"	=> Outp <= "1000000";		-- 0
			WHEN	"0001"	=> Outp <= "1111001";		-- 1
			WHEN	"0010"	=> Outp <= "0100100";		-- 2
			WHEN	"0011"	=> Outp <= "0110000";		-- 3
			WHEN	"0100"	=> Outp <= "0011001";		-- 4
			WHEN	"0101"	=> Outp <= "0010010";		-- 5
			WHEN	"0110"	=> Outp <= "0000010";		-- 6
			WHEN	"0111"	=> Outp <= "1111000";		-- 7
			WHEN	"1000"	=> Outp <= "0000000";		-- 8
			WHEN	"1001"	=> Outp <= "0010000";		-- 9
			WHEN	"1010"	=> Outp <= "0001000";		-- A
			WHEN	"1011"	=> Outp <= "0000011";		-- B
			WHEN	"1100"	=> Outp <= "1000110";		-- C
			WHEN	"1101"	=> Outp <= "0100001";		-- D
			WHEN	"1110"	=> Outp <= "0000110";		-- E
			WHEN	"1111"	=> Outp <= "0001110";		-- F
			WHEN    OTHERS  => Outp <= "0001001";		-- ERR (H)
		END CASE;
	END PROCESS;
END arch_BCDDecoder;
