--------------------------------------------------------------
-- Binary to 7SEG Decoder
-- Raymond Walter, Paul Flaemig-Abrell 2016-11-10
--------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
--------------------------------------------------------------
-- ENTITY
--------------------------------------------------------------
ENTITY DUALto7SEG IS
	PORT( 	Inp:				IN		STD_LOGIC_VECTOR(4 downto 0);
			SegOnes, SegTens:	OUT		STD_LOGIC_VECTOR(6 downto 0)
		  );
END DUALto7SEG;
--------------------------------------------------------------
-- ARCHITECTURE
--------------------------------------------------------------
ARCHITECTURE arch_DUALto7SEG OF DUALto7SEG IS

SIGNAL	LBCDOnes, LBCDTens	: STD_LOGIC_VECTOR(3 downto 0);

COMPONENT BCDDecoder IS
	PORT(	Inp			:	IN	 	STD_LOGIC_VECTOR(3 downto 0);
			Outp		:	OUT 	STD_LOGIC_VECTOR(6 downto 0));
END COMPONENT BCDDecoder;

COMPONENT Dual2BCD IS	
	PORT(	Inp			:	IN		STD_LOGIC_VECTOR(4 downto 0);
			BcdOnes		:	OUT		STD_LOGIC_VECTOR(3 downto 0);
			BcdTens		:	OUT		STD_LOGIC_VECTOR(3 downto 0));
END COMPONENT Dual2BCD;

BEGIN
	D2BCD: 		Dual2BCD 	PORT MAP(Inp, LBCDOnes, LBCDTens);
	BCDTens:	BCDDecoder 	PORT MAP(LBCDTens, SegTens);
	BCDOnes:	BCDDecoder 	PORT MAP(LBCDOnes, SegOnes);
END arch_DUALto7SEG;
