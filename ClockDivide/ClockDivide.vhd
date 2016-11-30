---------------------------------------------------------------------
-- Frequency divider using a variable division factor
---------------------------------------------------------------------
---------------------------------------------------------------------
-- 2016-11-19 Raymond Walter
---------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned;
---------------------------------------------------------------------
-- ENTITY
---------------------------------------------------------------------
ENTITY ClockDivide IS
	GENERIC	(	DIV_FACTOR	:	NATURAL := 50000000);
	PORT	(	Clk			:		IN	STD_LOGIC;
				SubClk		:		OUT	STD_LOGIC	
		    );
END ClockDivide;
---------------------------------------------------------------------
-- ARCHITECTURE
---------------------------------------------------------------------
ARCHITECTURE arch_ClockDivide OF ClockDivide IS
BEGIN
	PROCESS(Clk)
	VARIABLE Cnt : NATURAL RANGE 0 TO DIV_FACTOR -1 := 0;
	BEGIN
		IF RISING_EDGE(Clk) THEN
			IF(Cnt >= (DIV_FACTOR - 1)) THEN
				-- Reset Counter
				Cnt := 0;
				SubClk <= '1';
			ELSE
				Cnt := Cnt + 1;
				SubClk <= '0';
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE arch_ClockDivide;