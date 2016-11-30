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
ENTITY ShiftRegister IS
	GENERIC(NumBit: INTEGER := 8);
	PORT	(	Ena					:		IN		STD_LOGIC;
				SinR, SinL			:		IN		STD_LOGIC;
				Clk					:		IN		STD_LOGIC;
				Reset, Load, Dir	:		IN		STD_LOGIC;
				Pin					:		IN		STD_LOGIC_VECTOR(NumBit-1 DOWNTO 0);
				Pout				:		OUT		STD_LOGIC_VECTOR(Pin'range)
			);
END ENTITY ShiftRegister;
---------------------------------------------------------------------
-- ARCHITECTURE
---------------------------------------------------------------------
ARCHITECTURE arch_ShiftRegister OF ShiftRegister IS
	SIGNAL	current		:	STD_LOGIC_VECTOR(Pin'range);
BEGIN
	PROCESS(Clk, Reset)
	BEGIN
		IF	Reset = '0' THEN
			current <= (others => '0');
		ELSIF RISING_EDGE(Clk) THEN
			IF Load = '0' THEN			-- Load
				current <= Pin;
			ELSE								-- Shift
				IF Ena = '1' THEN
					IF Dir = '1' THEN			-- Right
						current  <= SinR & current(current'high downto current'low+1);
					ELSE
						current  <= current(current'high-1 downto current'low) & SinL;
					END IF;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	Pout <= current;
END ARCHITECTURE arch_ShiftRegister;