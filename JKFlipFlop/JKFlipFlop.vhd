---------------------------------------------------------------------
-- JK Flip-Flop
---------------------------------------------------------------------
---------------------------------------------------------------------
-- 2016-11-19 Raymond Walter
---------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned;
---------------------------------------------------------------------
-- ENTITY
---------------------------------------------------------------------
ENTITY JKFlipFlop IS
	PORT	(	Clk, Ena, J, K		:	IN 	STD_LOGIC;
				Q, NQ				:	OUT	STD_LOGIC
			);
END JKFlipFlop;	
---------------------------------------------------------------------
-- ARCHITECTURE
---------------------------------------------------------------------
ARCHITECTURE arch_JKFlipFlop OF JKFlipFlop IS
BEGIN
	PROCESS(Clk)
	VARIABLE output : STD_LOGIC;
	BEGIN
		IF RISING_EDGE(Clk) THEN
			IF (Ena = '1') THEN
				output := output;
				IF (J = '0' AND K = '1') THEN
					output := '0';
				ELSIF (J = '1' AND K = '0') THEN
					output := '1';
				ELSIF (J = '1' AND K = '1') THEN
					output := NOT output;
				END IF;
			END IF;
		END IF;
		Q <= output;
		NQ <= NOT output;
	END PROCESS;
END ARCHITECTURE arch_JKFlipFlop;