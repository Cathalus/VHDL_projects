---------------------------------------------------------------------
-- Start Stop Logic
---------------------------------------------------------------------
---------------------------------------------------------------------
-- 2016-11-30 Raymond Walter
---------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
---------------------------------------------------------------------
-- ENTITY
---------------------------------------------------------------------
ENTITY StartStopLogic IS
	PORT	( Start, Stop					:		IN		STD_LOGIC;
				Output						:		OUT		STD_LOGIC
			);
END StartStopLogic;
---------------------------------------------------------------------
-- ARCHITECTURE
---------------------------------------------------------------------
ARCHITECTURE arch_StartStopLogic OF StartStopLogic IS
BEGIN
	PROCESS(Start, Stop)
	BEGIN
		IF START = '0' THEN
			Output <= '1';
		ELSIF STOP = '0' THEN
			Output <= '0';
		END IF;
	END PROCESS;
END ARCHITECTURE;