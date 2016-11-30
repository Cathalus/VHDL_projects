---------------------------------------------------------------------
-- BCD  Counter to 7Seg
---------------------------------------------------------------------
---------------------------------------------------------------------
-- 2016-11-24 Raymond Walter, Paul Flaemig-Abrell
---------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
---------------------------------------------------------------------
-- ENTITY
---------------------------------------------------------------------
ENTITY BCD_Counter_7Seg IS
	PORT	(	Clk, Reset, Start, Stop, Dir		:		IN 	STD_LOGIC;
				Seg0, Seg1, Seg2						:		OUT	STD_LOGIC_VECTOR(6 downto 0)
			);
END BCD_Counter_7Seg;
---------------------------------------------------------------------
-- ARCHITECTURE
---------------------------------------------------------------------
ARCHITECTURE arch_BCD_Counter_7SEG OF BCD_Counter_7SEG IS
	COMPONENT BCDDecoder is
	PORT(	Inp		:  IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
			Outp		:  OUT	STD_LOGIC_VECTOR(6 DOWNTO 0));
	END COMPONENT BCDDecoder;

	COMPONENT ClockDivide IS
	GENERIC	(	DIV_FACTOR	:	NATURAL := 50000000);
	PORT	(	Clk			:		IN	STD_LOGIC;
				SubClk		:		OUT	STD_LOGIC	
		    );
	END COMPONENT ClockDivide;
	
	COMPONENT BCD_Counter IS
	PORT	(	Ena, Clk, Rst, UD			:		IN		STD_LOGIC;
				Over							:		OUT	STD_LOGIC;
				CntBcd						:		OUT	STD_LOGIC_VECTOR(3 DOWNTO 0)
			);
	END COMPONENT BCD_Counter;
	
	COMPONENT StartStopLogic IS
	PORT	(	Clk, Start, Stop			:		IN		STD_LOGIC;
				Output						:		OUT	STD_LOGIC
			);
	END COMPONENT StartStopLogic;
	
	SIGNAL Clk2Hz : STD_LOGIC;
	SIGNAL Ov0, Ov1 : STD_LOGIC;
	SIGNAL BCD0, BCD1, BCD2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL CntEna : STD_LOGIC := '0';
BEGIN
	StStp:			StartStopLogic	PORT MAP (Clk2Hz, Start, Stop, CntEna);
	CDiv:			ClockDivide		GENERIC MAP(25000000) PORT MAP (Clk, Clk2Hz);
	CntBCD0:		BCD_Counter		PORT MAP ((Clk2Hz AND CntEna)	, Clk, Reset, Dir, Ov0, BCD0);	-- TODO: START/STOP LOGIC
	CntBCD1:		BCD_Counter		PORT MAP (Ov0					, Clk, Reset, Dir, Ov1, BCD1);
	CntBCD2:		BCD_Counter		PORT MAP (Ov1					, Clk, Reset, Dir, OPEN, BCD2);
	
	BCDDEC0:		BCDDecoder		PORT MAP	(BCD0,	Seg0);
	BCDDEC1:		BCDDecoder		PORT MAP	(BCD1,	Seg1);
	BCDDEC2:		BCDDecoder		PORT MAP	(BCD2,	Seg2);
END ARCHITECTURE;