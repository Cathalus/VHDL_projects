---------------------------------------------------------------------
-- PWM Counter
---------------------------------------------------------------------
---------------------------------------------------------------------
-- 2016-12-14 Raymond Walter
---------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned;
USE ieee.numeric_std.ALL; 
---------------------------------------------------------------------
-- ENTITY
---------------------------------------------------------------------
ENTITY PWMCounter IS
	PORT		(	Cnt_Value			:		IN 	STD_LOGIC_VECTOR(6 DOWNTO 0);
					Ena, Rst, Clk		:		IN		STD_LOGIC;
					Pwm					:		OUT	STD_LOGIC
				);
END PWMCounter;
---------------------------------------------------------------------
-- ARCHITECTURE
---------------------------------------------------------------------
ARCHITECTURE arch_PWMCounter OF PWMCounter IS
BEGIN
	PROCESS(Clk)
	VARIABLE Cnt : NATURAL RANGE 0 TO 100-1 := 0;
	BEGIN
		IF Rst = '1' THEN
			Cnt := 0;
		ELSIF RISING_EDGE(Clk) THEN
			IF Ena = '1' THEN
				IF Cnt >= 100 THEN
					Cnt := 0;
				END IF;
				
				IF Cnt_Value = "0000000" THEN
					Pwm <= '0';
				ELSIF Cnt_Value = "1100100" THEN
					Pwm <= '1';
				ELSE
					IF Cnt < TO_INTEGER(UNSIGNED(Cnt_Value)) THEN
						Pwm <= '1';
					ELSE
						Pwm <= '0';
					END IF;
				END IF;
				
				Cnt := Cnt + 1;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE arch_PWMCounter;