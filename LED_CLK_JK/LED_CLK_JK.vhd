--------------------------------------------------------------
-- JK FlipFlop and Clock Divider output to LED
--------------------------------------------------------------
--------------------------------------------------------------
-- 2016-11-19 Raymond Walter
--------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
--------------------------------------------------------------
-- ENTITY
--------------------------------------------------------------
ENTITY LED_CLK_JK IS
	PORT		(	Clk, J, K	:			IN 	STD_LOGIC;
					Q, NQ		:			OUT	STD_LOGIC
				);
END ENTITY LED_CLK_JK;
--------------------------------------------------------------
-- ARCHITECTURE
--------------------------------------------------------------
ARCHITECTURE arch_LED_CLK_JK OF LED_CLK_JK IS
	COMPONENT ClockDivide IS
	GENERIC	(	DIV_FACTOR	:	NATURAL := 50000000);
	PORT		(	Clk			:		IN		STD_LOGIC;
					SubClk		:		OUT	STD_LOGIC	
				);
	END COMPONENT ClockDivide;
	
	COMPONENT JKFlipFlop IS
	PORT		(	Clk, Ena, J, K		:	IN 	STD_LOGIC;
					Q, NQ					:	OUT	STD_LOGIC
				);
	END COMPONENT JKFlipFlop;	

	SIGNAL Clk2Hz : STD_LOGIC;
BEGIN
	CDiv:	ClockDivide		GENERIC MAP(12500000) PORT MAP (Clk, Clk2Hz);
	JKFF:	JKFlipFlop		PORT MAP (Clk, Clk2Hz, J, K, Q, NQ);
END arch_LED_CLK_JK;