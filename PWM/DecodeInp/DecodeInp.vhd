---------------------------------------------------------------------
-- Rotary Encoder Input Decoder
---------------------------------------------------------------------
---------------------------------------------------------------------
-- 2016-12-08 Raymond Walter, Paul Flaemig-Abrell
---------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
---------------------------------------------------------------------
-- ENTITY
---------------------------------------------------------------------
ENTITY DecodeInp IS
	PORT	(	IncA, IncB				:		IN 	STD_LOGIC;
				Rst, Clk					:		IN 	STD_LOGIC;
				CntUp, CntDown			:		OUT	STD_LOGIC
			);
END ENTITY DecodeInp;
---------------------------------------------------------------------
-- ARCHITECTURE
---------------------------------------------------------------------
ARCHITECTURE arch_DecodeInp OF DecodeInp IS
	TYPE T_STATE IS (S_HIGH, S_LOW, S_SET);
	SIGNAL NEXT_STATE, STATE : T_STATE := S_HIGH;
BEGIN
	proc_NS: PROCESS(STATE)
	BEGIN
		NEXT_STATE <= STATE;
		CASE STATE IS
			WHEN S_HIGH =>
				IF IncA = '0' THEN
					NEXT_STATE <= S_LOW;
				END IF;
			WHEN S_LOW =>
				IF IncA = '1' THEN
					NEXT_STATE <= S_SET;
				END IF;
			WHEN S_SET =>
				NEXT_STATE <= S_HIGH;
		END CASE;
	END PROCESS;
	
	proc_OUT: PROCESS(STATE)
	BEGIN
		IF STATE = S_SET THEN

				IF IncB = '0' THEN
					CntUp <= '1';
					CntDown <= '0';
				ELSE
					CntDown <= '1';
					CntUp <= '0';
				END IF;
		ELSE
				CntUp <= '0';
				CntDown <= '0';	
		END IF;
	END PROCESS;
	
	proc_REG: PROCESS(Clk, Rst)
	BEGIN
		IF Rst = '1' THEN
			STATE <= S_HIGH;
		ELSIF RISING_EDGE(Clk) THEN
			STATE <= NEXT_STATE;
		END IF;
	END PROCESS;
END ARCHITECTURE arch_DecodeInp;