LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY simpleLogic;
USE simpleLogic.all;

LIBRARY binCounter_5bit;
USE binCounter_5bit.all;

LIBRARY ControlUnit;
USE ControlUnit.all;

LIBRARY LFSR;
USE LFSR.all;

LIBRARY gateOr8;
USE gateOr8.all;

ENTITY CRC8Decoder IS
  PORT (nGRst: IN STD_LOGIC;
        clk:   IN STD_LOGIC;
        dIn:   IN STD_LOGIC;
        error:  OUT STD_LOGIC);
END CRC8Decoder;

ARCHITECTURE structure OF CRC8Decoder IS
	signal iNRst, iNSet, iNClk, s_error: STD_LOGIC;
	signal stat : STD_LOGIC_VECTOR(4 DOWNTO 0);
	signal lsfr_out : STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	COMPONENT binCounter_5bit
		PORT (nRst: IN STD_LOGIC;
				clk:  IN STD_LOGIC;
				c:    OUT STD_LOGIC_VECTOR (4 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT ControlUnit
		PORT (nGRst:	 IN STD_LOGIC;
				clk:   IN STD_LOGIC;
				add:   IN STD_LOGIC_VECTOR (4 DOWNTO 0);
				nRst:  OUT STD_LOGIC;
				nSetO: OUT STD_LOGIC;
				clkO:  OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT LFSR
		PORT (clk: IN STD_LOGIC;
				rst: IN STD_LOGIC;
				dIn: IN STD_LOGIC;
				dOut: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT gateOr8
		PORT (x: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
				y: OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT flipFlopDPET
		PORT (clk, D:     IN STD_LOGIC;
				nSet, nRst: IN STD_LOGIC;
				Q, nQ:      OUT STD_LOGIC);
	END COMPONENT;
	
BEGIN
	binCounter: binCounter_5bit PORT MAP (iNRst, clk, stat);
	control: ControlUnit PORT MAP (nGRst, clk, stat, iNRst, iNSet, iNClk);
	reg: LFSR PORT MAP (clk, iNRst, dIn, lsfr_out);
	or8: gateOr8 PORT MAP (lsfr_out, s_error);
	ff: flipFlopDPET PORT MAP (iNClk, s_error, iNSet, '1', error);
END structure;