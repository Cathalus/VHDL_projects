 ---------------------------------------------------------------------
-- Shift Register
---------------------------------------------------------------------
---------------------------------------------------------------------
-- 2016-11-30 Raymond Walter, Paul Flaemig-Abrell
---------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
---------------------------------------------------------------------
-- ENTITY
---------------------------------------------------------------------
ENTITY ShiftRegister8Bit IS
	PORT	(	Clk, Reset, Start, Stop, Dir, Load	:		IN		STD_LOGIC;
				Inp											:		IN		STD_LOGIC_VECTOR(7 downto 0);
				Outp											:		OUT	STD_LOGIC_VECTOR(7 downto 0)
			);
END ShiftRegister8Bit;
---------------------------------------------------------------------
-- ARCHITECTURE
---------------------------------------------------------------------
ARCHITECTURE arch_ShiftRegister8Bit OF ShiftRegister8Bit IS

	COMPONENT ClockDivide IS
	GENERIC	(	DIV_FACTOR	:	NATURAL := 50000000);
	PORT	(	Clk			:		IN	STD_LOGIC;
				SubClk		:		OUT	STD_LOGIC	
		    );
	END COMPONENT ClockDivide;
	
	COMPONENT StartStopLogic IS
	PORT	(	Start, Stop					:		IN		STD_LOGIC;
				Output						:		OUT	STD_LOGIC
			);
	END COMPONENT StartStopLogic;
	
	COMPONENT ShiftRegister IS
	GENERIC(NumBit: INTEGER := 8);
	PORT	(	Ena					:		IN		STD_LOGIC;
				SinR, SinL			:		IN		STD_LOGIC;
				Clk					:		IN		STD_LOGIC;
				Reset, Load, Dir	:		IN		STD_LOGIC;
				Pin					:		IN		STD_LOGIC_VECTOR(NumBit-1 DOWNTO 0);
				Pout					:		OUT	STD_LOGIC_VECTOR(Pin'range)
			);
	END COMPONENT ShiftRegister;

	SIGNAL Clk2Hz	:	STD_LOGIC;
	SIGNAL Count	:	STD_LOGIC := '0';
	SIGNAL SigOutp : 	STD_LOGIC_VECTOR(7 downto 0);
BEGIN
	Outp <= SigOutp;	

	
	CDiv:			ClockDivide		GENERIC MAP(2500000) 	PORT MAP (Clk, Clk2Hz);
	StStp:		StartStopLogic									PORT MAP (Start, Stop, Count);
	ShReg:		ShiftRegister	GENERIC MAP(8) 			PORT MAP	((Clk2Hz AND Count), SigOutp(0), SigOutp(7), Clk, Reset, Load, Dir, Inp, SigOutp);
END ARCHITECTURE arch_ShiftRegister8Bit;