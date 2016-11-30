---------------------------------------------------------------------
-- BCD  Counter
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
ENTITY BCD_Counter IS
	PORT	(	Ena, Clk, Rst, UD			:		IN		STD_LOGIC;
				Over						:		OUT	STD_LOGIC;
				CntBcd						:		OUT	STD_LOGIC_VECTOR(3 DOWNTO 0)
			);
END BCD_Counter;
---------------------------------------------------------------------
-- ARCHITECTURE
---------------------------------------------------------------------
ARCHITECTURE arch_BCD_Counter OF BCD_COUNTER IS
	SIGNAL value : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
	PROCESS(Clk)
	
	BEGIN
		IF Rst = '0' THEN 
			-- Reset
			IF UD = '1' THEN
				value <= "0000";
			ELSIF UD = '0' THEN
				value <= "1001";
			END IF;
		ELSE
			IF RISING_EDGE(Clk) THEN	
			Over <= '0';
				IF Ena = '1' THEN
					IF UD = '1' THEN 		-- count up
						IF value = "1001" THEN
							-- overflow
							Over <= '1';
							value <= "0000";
						ELSE
							value <= value+1;
						END IF;
					ELSIF UD = '0' THEN	-- count down
						IF value = "0000" THEN
							-- underflow
							Over <= '1';
							value <= "1001";
						ELSE
							value <= value-1;
						END IF;
					END IF;
				END IF;
			END IF;
		END IF;
		
		CntBcd <= value;
	END PROCESS;
END ARCHITECTURE arch_BCD_Counter;