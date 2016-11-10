--------------------------------------------------------------
-- 4 Bit Adder
-- Raymond Walter, Paul Flaemig-Abrell 2016-11-10
--------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
--------------------------------------------------------------
-- ENTITY
--------------------------------------------------------------
ENTITY FourBitAdd IS
	PORT	(	A,B:			IN		STD_LOGIC_VECTOR(3 downto 0);
				Cout:			OUT		STD_LOGIC;
				Sum:			OUT		STD_LOGIC_VECTOR(3 downto 0)
			);
END FourBitAdd;
--------------------------------------------------------------
-- ARCHITECTURE
--------------------------------------------------------------
ARCHITECTURE arch_FourBitAdd OF FourBitAdd IS

	SIGNAL I1, I2, I3 : STD_LOGIC;

	COMPONENT FullAdd IS 
	PORT(A, B, Cin 	:	IN		STD_LOGIC;
		  Sum, Cout	:	OUT		STD_LOGIC);
	END COMPONENT FullAdd;
	
	COMPONENT HalfAdd is
	PORT(A, B		: 	IN		STD_LOGIC;
	     Sum, Cout	: 	OUT		STD_LOGIC);
	END COMPONENT HalfAdd;
BEGIN
							-- A	B 	  Cin 	Sum	  	Cout
	FA1:	FullAdd PORT MAP (A(3), B(3), I3, 	Sum(3), Cout);
	FA2:	FullAdd PORT MAP (A(2), B(2), I2, 	Sum(2), I3);
	FA3:	FullAdd PORT MAP (A(1), B(1), I1, 	Sum(1), I2);
							-- A	B	 	 	Sum	 	Cout
	HA1:	HalfAdd PORT MAP (A(0), B(0), 		Sum(0), I1);
	
END arch_FourBitAdd;