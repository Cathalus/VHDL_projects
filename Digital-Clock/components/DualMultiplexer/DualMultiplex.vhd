 ---------------------------------------------------------------------
-- Frequency divider using a variable division factor
---------------------------------------------------------------------
---------------------------------------------------------------------
-- 2017-01-18 Raymond Walter, Paul Flaemig-Abrell
---------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
---------------------------------------------------------------------
-- ENTITY
---------------------------------------------------------------------
ENTITY DualMultiplex IS 
	PORT	(	A, B		:	IN		STD_LOGIC;
				Sel		:	IN		STD_LOGIC;
				Outp		:	OUT	STD_LOGIC
			);
END  ENTITY DualMultiplex;
---------------------------------------------------------------------
-- ARCHITECTURE
---------------------------------------------------------------------
ARCHITECTURE arch_DualMultiplex OF DualMultiplex IS
BEGIN
	PROCESS(A,B)
	BEGIN
		IF Sel = '1' THEN
			Outp <= A;
		ELSIF Sel = '0' THEN
			Outp <= B;
		END IF;
	END PROCESS;
END ARCHITECTURE arch_DualMultiplex;