---------------------------------------------------------------------
-- VGA Test Screen Generator
---------------------------------------------------------------------
---------------------------------------------------------------------
-- 2016-12-01 Raymond Walter, Paul Flaemig-Abrell
---------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
---------------------------------------------------------------------
-- ENTITY
---------------------------------------------------------------------
ENTITY VGA IS
	GENERIC	(	LINE_PERIOD		:		NATURAL := (1065-1);
					NUM_ROWS			:		NATURAL := (625-1)
				);
	PORT		(	Clk									:	IN		STD_LOGIC;
					VGA_R, VGA_G, VGA_B				:	OUT	STD_LOGIC_VECTOR(9 downto 0);
					VGA_CLK, VGA_BLANK, VGA_SYNC	:	OUT	STD_LOGIC;
					VGA_HS, VGA_VS						:	OUT	STD_LOGIC
				);
END VGA;
---------------------------------------------------------------------
-- ARCHITECTURE
---------------------------------------------------------------------
ARCHITECTURE arch_VGA OF VGA IS
	SIGNAL LINE_OVERFLOW : STD_LOGIC := '0';
	SIGNAL H_COUNT : NATURAL RANGE 0 TO LINE_PERIOD := 0;
	SIGNAL V_COUNT : NATURAL RANGE 0 TO NUM_ROWS := 0;
BEGIN
	horCTR:	PROCESS(Clk)
	VARIABLE hCnt : NATURAL RANGE 0 TO LINE_PERIOD := 0;
	BEGIN
		IF RISING_EDGE(Clk) THEN
			IF (hCnt >= LINE_PERIOD) THEN
				-- Reset Counter and set overflow signal
				hCnt := 0;
				LINE_OVERFLOW <= '1';
			ELSE
				hCnt := hCnt + 1;
				LINE_OVERFLOW <= '0';
			END IF;
			H_COUNT <= hCnt;
		END IF;
	END PROCESS;
	
	verCTR:	PROCESS(Clk)
	VARIABLE vCnt : NATURAL RANGE 0 TO NUM_ROWS := 0;
	BEGIN
		IF RISING_EDGE(Clk) THEN
			IF	LINE_OVERFLOW = '1' THEN
				IF (vCnt >= NUM_ROWS) THEN
					vCnt := 0;
				ELSE
					vCnt := vCnt + 1;
				END IF;
			END IF;
			V_COUNT <= vCnt;
		END IF;
	END PROCESS;
	
	PROCESS(Clk)
	BEGIN
		IF RISING_EDGE(Clk) THEN
			VGA_HS <= '0';
			VGA_VS <= '0';
			VGA_BLANK <= '0';
			VGA_R <= (others => '0');
			VGA_G <= (others => '0');
			VGA_B <= (others => '0');
			
			IF H_COUNT < 80 THEN		-- sync horizontal
				VGA_HS <= '1';
			END IF;
			IF	V_COUNT < 3 THEN		-- sync vertical
				VGA_VS <= '1';
			END IF;
			IF (H_COUNT >= 245 AND H_COUNT < 1045) AND
				(V_COUNT >= 24 AND V_COUNT < 624) THEN
				VGA_BLANK <= '1';
				IF (H_COUNT >= 245 AND H_COUNT < 345) THEN
					-- White
					VGA_R <= (others => '1');
					VGA_G <= (others => '1');
					VGA_B <= (others => '1');
				ELSIF (H_COUNT >= 345 AND H_COUNT < 445) THEN
					-- Yellow
					VGA_R <= (others => '1');
					VGA_G <= (others => '1');
					VGA_B <= (others => '0');
				ELSIF (H_COUNT >= 445 AND H_COUNT < 545) THEN
					-- Cyan
					VGA_R <= (others => '0');
					VGA_G <= (others => '1');
					VGA_B <= (others => '1');
				ELSIF (H_COUNT >= 545 AND H_COUNT < 645) THEN
					-- Green
					VGA_R <= (others => '0');
					VGA_G <= (others => '1');
					VGA_B <= (others => '0');
				ELSIF (H_COUNT >= 645 AND H_COUNT < 745) THEN
					-- Magenta
					VGA_R <= (others => '1');
					VGA_G <= (others => '0');
					VGA_B <= (others => '1');
				ELSIF (H_COUNT >= 745 AND H_COUNT < 845) THEN
					-- Red
					VGA_R <= (others => '1');
					VGA_G <= (others => '0');
					VGA_B <= (others => '0');
				ELSIF (H_COUNT >= 845 AND H_COUNT < 945) THEN
					-- Blue
					VGA_R <= (others => '0');
					VGA_G <= (others => '0');
					VGA_B <= (others => '1');
				ELSIF (H_COUNT >= 945 AND H_COUNT < 1045) THEN
					-- Black
					VGA_R <= (others => '0');
					VGA_G <= (others => '0');
					VGA_B <= (others => '0');
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
	VGA_CLK <= Clk;
END ARCHITECTURE arch_VGA;