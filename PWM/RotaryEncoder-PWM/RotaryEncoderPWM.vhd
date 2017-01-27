---------------------------------------------------------------------
-- Rotary Encoder with Pulse-Width-Modulation PWM
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
ENTITY RotaryEncoderPWM IS
	PORT	(	Clk, Rst					:		IN		STD_LOGIC;
				IncA, IncB				:		IN		STD_LOGIC;
				Seg7H, Seg7T, Seg7O	:		OUT	STD_LOGIC_VECTOR(6 DOWNTO 0);
				Pwm						:		OUT	STD_LOGIC
			);
END ENTITY RotaryEncoderPWM;
---------------------------------------------------------------------
-- ARCHITECTURE
---------------------------------------------------------------------
ARCHITECTURE arch_RotaryEncoderPWM OF RotaryEncoderPWM IS

	COMPONENT ClockDivide IS
		GENERIC	(	DIV_FACTOR	:	NATURAL := 500);
		PORT		(	Clk			:	IN	STD_LOGIC;
						SubClk		:	OUT	STD_LOGIC	
					);
	END COMPONENT ClockDivide;
	
	-------------------------------------------------------------------------------------------------------
	
	COMPONENT UpDownCounter IS
		GENERIC	(	VAL_MAXIMUM		: NATURAL := 100);
		PORT		(	Clk, Rst			: IN	STD_LOGIC;
						CntUp, CntDown	: IN	STD_LOGIC;
						Outp 				: OUT	STD_LOGIC_VECTOR(6 DOWNTO 0)
					);
	END COMPONENT UpDownCounter;
	
	-------------------------------------------------------------------------------------------------------
	
	COMPONENT PWMCounter IS
		PORT		(	Cnt_Value			:		IN 	STD_LOGIC_VECTOR(6 DOWNTO 0);
						Ena, Rst, Clk		:		IN		STD_LOGIC;
						Pwm					:		OUT	STD_LOGIC
					);
	END COMPONENT PWMCounter;
	
	-------------------------------------------------------------------------------------------------------
	
	COMPONENT Bin2Bcd is
		port(Inp:     in  std_logic_vector(7 downto 0);    -- input
			  BcdA:    out std_logic_vector(3 downto 0);    -- output: BCD A = units
			  BcdB:    out std_logic_vector(3 downto 0);    -- output: BCD B = tens
			  BcdC:    out std_logic_vector(3 downto 0));   -- output: BCD C = hundreds
	end COMPONENT Bin2Bcd;

	-------------------------------------------------------------------------------------------------------
	
	COMPONENT DecodeInp IS
	PORT	(	IncA, IncB				:		IN 	STD_LOGIC;
				Rst, Clk					:		IN 	STD_LOGIC;
				CntUp, CntDown			:		OUT	STD_LOGIC
			);
	END COMPONENT DecodeInp;
	
	-------------------------------------------------------------------------------------------------------
	
	COMPONENT BCDDecoder is
	PORT(	Inp		:  IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
			Outp	:  OUT		STD_LOGIC_VECTOR(6 DOWNTO 0));
	END COMPONENT BCDDecoder;
	
	-------------------------------------------------------------------------------------------------------
	
	SIGNAL sig_CntUp, sig_CntDown : STD_LOGIC := '0';
	SIGNAL sig_CntValue : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000";
	SIGNAL sig_SubClk : STD_LOGIC := '0';
	SIGNAL sig_BCDH, sig_BCDT, sig_BCDO : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
	DCInp:		DecodeInp	PORT MAP (IncA,IncB,NOT Rst,Clk,sig_CntUp,sig_CntDown);
	UDC:			UpDownCounter PORT MAP (Clk,NOT Rst,sig_CntUp,sig_CntDown,sig_CntValue);
	B2BCD:		Bin2Bcd PORT MAP ('0'&sig_CntValue,sig_BCDO,sig_BCDT,sig_BCDH);
	BCDDH:		BCDDecoder PORT MAP (sig_BCDH,Seg7H);
	BCDDT:		BCDDecoder PORT MAP (sig_BCDT,Seg7T);
	BCDDO:		BCDDecoder PORT MAP (sig_BCDO,Seg7O);
	CLKDIV:		ClockDivide PORT MAP (Clk,sig_SubClk);
	PWMCnt:		PWMCounter PORT MAP (sig_CntValue,sig_SubClk,NOT Rst,Clk,Pwm);

END ARCHITECTURE arch_RotaryEncoderPWM;