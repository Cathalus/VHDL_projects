----------------------------------------------------------
-- Halfadder with boolean logic
-- Raymond Walter, Paul Flaemig-Abrell 2016-10-27
----------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

----------------------------------------------------------
-- ENTITY
----------------------------------------------------------
ENTITY HalfAdd is
	PORT(A, B		: IN	STD_LOGIC;
	     Sum, Cout	: OUT	STD_LOGIC);
END HalfAdd;

----------------------------------------------------------
-- ARCHITECTURE
----------------------------------------------------------
ARCHITECTURE arch_HalfAdd OF HalfAdd IS
BEGIN
	Sum  <= A xor B;
	Cout <= A and B;
END arch_HalfAdd;
