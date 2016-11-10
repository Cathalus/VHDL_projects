----------------------------------------------------------
-- Binary to BCD Decoder
-- Raymond Walter, Paul Flaemig-Abrell 2016-11-03
----------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;

----------------------------------------------------------
-- ENTITY
----------------------------------------------------------
ENTITY Dual2BCD IS
	PORT(	Inp		:	IN	std_logic_vector(4 DOWNTO 0);
			BcdOnes	:  OUT	std_logic_vector(3 DOWNTO 0);
			BcdTens	:  OUT	std_logic_vector(3 DOWNTO 0));
END Dual2BCD;

----------------------------------------------------------
-- ARCHITECTURE
----------------------------------------------------------
ARCHITECTURE arch_Dual2BCD of Dual2BCD IS
SIGNAL Temp:	std_logic_vector(7 DOWNTO 0);			-- Output bus
BEGIN
	PROCESS(Inp)
	BEGIN
		CASE Inp IS
			WHEN "00000"	=>	Temp	<= "0000"&"0000";		-- 00
			WHEN "00001"	=>	Temp	<= "0000"&"0001";		-- 01
			WHEN "00010"	=>	Temp	<= "0000"&"0010";		-- 02
			WHEN "00011"	=>	Temp	<= "0000"&"0011";		-- 03
			WHEN "00100"	=>	Temp	<= "0000"&"0100";		-- 04
			WHEN "00101"	=>	Temp	<= "0000"&"0101";		-- 05
			WHEN "00110"	=>	Temp	<= "0000"&"0110";		-- 06
			WHEN "00111"	=>	Temp	<= "0000"&"0111";		-- 07
			WHEN "01000"	=>	Temp	<= "0000"&"1000";		-- 08
			WHEN "01001"	=>	Temp	<= "0000"&"1001";		-- 09
			WHEN "01010"	=>	Temp	<= "0001"&"0000";		-- 10
			WHEN "01011"	=>	Temp	<= "0001"&"0001";		-- 11
			WHEN "01100"	=>	Temp	<= "0001"&"0010";		-- 12
			WHEN "01101"	=>	Temp	<= "0001"&"0011";		-- 13
			WHEN "01110"	=>	Temp	<= "0001"&"0100";		-- 14
			WHEN "01111"	=>	Temp	<= "0001"&"0101";		-- 15
			WHEN "10000"	=>	Temp	<= "0001"&"0110";		-- 16
			WHEN "10001"	=>	Temp	<= "0001"&"0111";		-- 17
			WHEN "10010"	=>	Temp	<= "0001"&"1000";		-- 18
			WHEN "10011"	=>	Temp	<= "0001"&"1001";		-- 19
			WHEN "10100"	=>	Temp	<= "0010"&"0000";		-- 20
			WHEN "10101"	=>	Temp	<= "0010"&"0001";		-- 21
			WHEN "10110"	=>	Temp	<= "0010"&"0010";		-- 22
			WHEN "10111"	=>	Temp	<= "0010"&"0011";		-- 23
			WHEN "11000"	=>	Temp	<= "0010"&"0100";		-- 24
			WHEN "11001"	=>	Temp	<= "0010"&"0101";		-- 25
			WHEN "11010"	=>	Temp	<= "0010"&"0110";		-- 26
			WHEN "11011"	=>	Temp	<= "0010"&"0111";		-- 27
			WHEN "11100"	=>	Temp	<= "0010"&"1000";		-- 28
			WHEN "11101"	=>	Temp	<= "0010"&"1001";		-- 29
			WHEN "11110"	=>	Temp	<= "0011"&"0000";		-- 30
			WHEN "11111"	=>	Temp	<= "0011"&"0001";		-- 31
			WHEN others    => Temp  <= "1111"&"0000";
		END CASE;
		
		BcdOnes <= Temp(3 DOWNTO 0);
		BcdTens <= Temp(7 DOWNTO 4);
	END PROCESS;
END arch_Dual2BCD;