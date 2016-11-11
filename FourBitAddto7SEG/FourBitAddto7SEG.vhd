--------------------------------------------------------------
-- 4 Bit Adder to 7 Segment Display
-- Raymond Walter, Paul Flaemig-Abrell 2016-11-10
--------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
--------------------------------------------------------------
-- ENTITY
--------------------------------------------------------------
ENTITY FourBitAddto7SEG IS
	PORT	(	A, B:					IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
				SumOnes, SumTens: OUT	STD_LOGIC_VECTOR(6 DOWNTO 0)
			);	
END FourBitAddto7SEG;
--------------------------------------------------------------
-- ARCHITECTURE
--------------------------------------------------------------
ARCHITECTURE arch_ForBitAddto7SEG OF FourBitAddto7SEG IS
	COMPONENT FourBitAdd IS
	PORT	(	A,B:			IN		STD_LOGIC_VECTOR(3 downto 0);
				Cout:			OUT	STD_LOGIC;
				Sum:			OUT	STD_LOGIC_VECTOR(3 downto 0)
			);
	END COMPONENT FourBitAdd;
	
	COMPONENT DUALto7SEG IS
	PORT	( 	Inp:					IN		STD_LOGIC_VECTOR(4 downto 0);
				SegOnes, SegTens:	OUT	STD_LOGIC_VECTOR(6 downto 0)
			);
	END COMPONENT DUALto7SEG;
	
	SIGNAL	LCout : STD_LOGIC;
	SIGNAL	LSum	: STD_LOGIC_VECTOR(3 downto 0);
BEGIN
	FBA:	FourBitAdd		PORT MAP (A,B,LCout, LSum);
	DTS:	DUALto7SEG		PORT MAP (LCout&LSum, SUMOnes, SUMTens);
END arch_ForBitAddto7SEG;