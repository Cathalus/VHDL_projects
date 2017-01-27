---------------------------------------------------------------------
-- Counter that can count up or down
---------------------------------------------------------------------
---------------------------------------------------------------------
-- 2016-12-14 Raymond Walter, Paul Flaemig-Abrell
---------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
---------------------------------------------------------------------
-- ENTITY
---------------------------------------------------------------------
ENTITY UpDownCounter IS
	GENERIC	(	VAL_MAXIMUM		:	NATURAL := 100);
	PORT		(	Clk, Rst			: IN	STD_LOGIC;
					CntUp, CntDown	: IN	STD_LOGIC;
					Outp 				: OUT	STD_LOGIC_VECTOR(6 DOWNTO 0)
				);
END UpDownCounter;
---------------------------------------------------------------------
-- ARCHITECTURE
---------------------------------------------------------------------
ARCHITECTURE arch_UpDownCounter OF UpDownCounter IS
BEGIN
	PROCESS(Clk)
	VARIABLE Cnt : NATURAL RANGE 0 TO VAL_MAXIMUM - 1 := 0;
	BEGIN
		IF Rst = '1' THEN
			Cnt := 0;
		ELSIF RISING_EDGE(Clk) THEN
			IF CntUp = '1' AND Cnt < 100 THEN
				Cnt := Cnt + 1;
			ELSIF CntDown = '1' AND Cnt > 0 THEN
				Cnt := Cnt - 1;
			END IF;
		END IF;
		Outp <= STD_LOGIC_VECTOR(TO_UNSIGNED(Cnt, Outp'length));
	END PROCESS;
END ARCHITECTURE arch_UpDownCounter;