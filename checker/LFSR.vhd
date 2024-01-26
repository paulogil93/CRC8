LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY DFlipFlop;
USE DFlipFlop.all;

LIBRARY simpleLogic;
USE simpleLogic.all;

entity LFSR is
	port(
		clk 	 : in std_logic;
		rst	 : in std_logic;
		dIn	 : in std_logic;
		dOut	 : out std_logic_vector(7 downto 0)
	);
end LFSR;

architecture Structural of LFSR is
	signal x0x8, x1, x2, x5, x7 : std_logic;
	signal dff0_out, dff1_out, dff2_out, dff3_out, dff4_out, dff5_out, dff6_out, dff7_out : std_logic;
	
	COMPONENT gateXor2
	PORT (x1, x2: IN STD_LOGIC;
			y:      OUT STD_LOGIC);
	END COMPONENT;
	
	component DFlipFlop 
   port(
      clk :in std_logic; 
		rst: in std_logic;
      d :in  std_logic;
      q : out std_logic    		
   );
	end component;
begin

	xor0: gateXor2 PORT MAP (dff0_out, dIn, x0x8);
	xor1: gateXor2 PORT MAP (x0x8, dff7_out, x1);
	xor2: gateXor2 PORT MAP (x0x8, dff6_out, x2);
	xor3: gateXor2 PORT MAP (x0x8, dff3_out, x5);
	xor4: gateXor2 PORT MAP (x0x8, dff1_out, x7);
	
	dff7: DFlipFlop PORT MAP (clk, rst, x0x8, dff7_out);
	dff6: DFlipFlop PORT MAP (clk, rst, x1, dff6_out);
	dff5: DFlipFlop PORT MAP (clk, rst, x2, dff5_out);
	dff4: DFlipFlop PORT MAP (clk, rst, dff5_out, dff4_out);
	dff3: DFlipFlop PORT MAP (clk, rst, dff4_out, dff3_out);
	dff2: DFlipFlop PORT MAP (clk, rst, x5, dff2_out);
	dff1: DFlipFlop PORT MAP (clk, rst, dff2_out, dff1_out);
	dff0: DFlipFlop PORT MAP (clk, rst, x7, dff0_out);
		
	dOut <= dff0_out & dff1_out & dff2_out & dff3_out & dff4_out & dff5_out & dff6_out & dff7_out;
end Structural;