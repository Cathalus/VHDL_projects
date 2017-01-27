---------------------------------------------------------------------
-- Generic BCD Up/Down Counter [0-9]
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
ENTITY GenericBCDCounter IS
	GENERIC	(	MAX_VALUE				:		NATURAL := 9	);
	PORT		(	Ena, Clk, Rst, UD		:		IN	STD_LOGIC;
					Over						:		OUT	STD_LOGIC;
					CntBcd					:		OUT	STD_LOGIC_VECTOR(3 DOWNTO 0)
				);
END GenericBCDCounter;
---------------------------------------------------------------------
-- ARCHITECTURE
---------------------------------------------------------------------
ARCHITECTURE arch_GenericBCDCounter OF GenericBCDCounter IS
	SIGNAL value : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL val_numeric : NATURAL := 0;
BEGIN
	PROCESS(Clk)
	BEGIN
		IF Rst = '0' THEN 
			-- Reset
			IF UD = '1' THEN
				value <= "0000";
				val_numeric <= 0;
			ELSIF UD = '0' THEN
				CASE MAX_VALUE IS
					WHEN 9 => value <= "1001";
					WHEN 8 => value <= "1000";
					WHEN 7 => value <= "0111";
					WHEN 6 => value <= "0110";
					WHEN 5 => value <= "0101";
					WHEN 4 => value <= "0100";
					WHEN 3 => value <= "0011";
					WHEN 2 => value <= "0010";
					WHEN 1 => value <= "0001";
					WHEN others => value <= "1001";
				END CASE;
				val_numeric <= MAX_VALUE;
			END IF;
		ELSE
			IF RISING_EDGE(Clk) THEN
				Over <= '0';
				IF Ena = '1' THEN
					IF UD = '1' THEN 		-- count up
						IF val_numeric = MAX_VALUE THEN
							-- overflow
							Over <= '1';
							val_numeric <= 0;
							value <= "0000";
						ELSE
							value <= value+1;
							val_numeric <= val_numeric+1;
						END IF;
					ELSIF UD = '0' THEN	-- count down
						IF val_numeric = 0 THEN
							Over <= '1';
							val_numeric <= MAX_VALUE;
							CASE MAX_VALUE IS
								WHEN 9 => value <= "1001";
								WHEN 8 => value <= "1000";
								WHEN 7 => value <= "0111";
								WHEN 6 => value <= "0110";
								WHEN 5 => value <= "0101";
								WHEN 4 => value <= "0100";
								WHEN 3 => value <= "0011";
								WHEN 2 => value <= "0010";
								WHEN 1 => value <= "0001";
								WHEN others => value <= "1001";
							END CASE;
						ELSE
							value <= value-1;
							val_numeric <= val_numeric-1;
						END IF;
					END IF;
				END IF;
			END IF;
		END IF;
		CntBcd <= value;
	END PROCESS;
END ARCHITECTURE arch_GenericBCDCounter;