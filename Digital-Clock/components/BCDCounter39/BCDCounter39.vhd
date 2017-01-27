---------------------------------------------------------------------
-- Generic BCD Up Counter (0-9|0-3)
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
ENTITY BCDCounter39 IS
	PORT		(	Ena, Clk, Rst					:		IN		STD_LOGIC;
					Over								:		OUT	STD_LOGIC;
					CntBcd							:		OUT	STD_LOGIC_VECTOR(3 DOWNTO 0)
				);
END BCDCounter39;
---------------------------------------------------------------------
-- ARCHITECTURE
---------------------------------------------------------------------
ARCHITECTURE arch_BCDCounter39 OF BCDCounter39 IS
	SIGNAL value : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL overflow_cnt : NATURAL := 0;
BEGIN
	PROCESS(Clk)
	BEGIN
		IF Rst = '0' THEN 
			value <= "0000";
			overflow_cnt <= 0;
		ELSIF RISING_EDGE(Clk) THEN
			Over <= '0';
			IF Ena = '1' THEN
				IF overflow_cnt = 2 THEN
					IF value = "0011" THEN
						-- overflow
						overflow_cnt <= 0;
						value <= "0000";
						Over <= '1';
					ELSE
						value <= value+1;
					END IF;
				ELSE
					IF value = "1001" THEN
						-- overflow
						value <= "0000";
						overflow_cnt <= overflow_cnt+1;
						Over <= '1';
					ELSE
						value <= value+1;
					END IF;
				END IF;
			END IF;
		END IF;
		CntBcd <= value;
	END PROCESS;
END ARCHITECTURE arch_BCDCounter39;