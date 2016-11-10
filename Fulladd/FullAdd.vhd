--------------------------------------------------------------
-- Fulladder with boolean logic
-- Raymond Walter, Paul Flaemig-Abrell 2016-10-27
--------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY FullAdd IS 
	PORT(A, B, Cin :	IN		STD_LOGIC;
		  Sum, Cout	:	OUT		STD_LOGIC);
END FullAdd;

--------------------------------------------------------------
-- ARCHITECTURE
--------------------------------------------------------------
ARCHITECTURE arch_FullAdd OF FullAdd IS
-- Lokale Signale
SIGNAL I1, I2, I3	: 	STD_LOGIC;

-- Komponentendeklaration
COMPONENT HalfAdd IS 
	PORT(A, B		: 	IN		STD_LOGIC;
		  Sum, Cout	:	OUT	STD_LOGIC);
END COMPONENT HalfAdd;

BEGIN
	HA1: HalfAdd PORT MAP(A, B, I1, I2);
	HA2: HalfAdd PORT MAP(I1, Cin, Sum, I3);
	Cout <= I2 OR I3;
END arch_FullAdd;