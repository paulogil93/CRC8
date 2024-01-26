LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY DFlipFlop IS 
	PORT(clk: in std_logic;   
		rst: in std_logic;
      d: in  std_logic;
      q: out std_logic );
END DFlipFlop;

ARCHITECTURE Behavioral OF DFlipFlop IS  
BEGIN
	PROCESS(clk, rst)
	BEGIN 
		IF (rst = '0') THEN
			q <= '0';
		ELSIF(rising_edge(clk)) THEN
			q <= d; 
		END IF;       
	END PROCESS;  
END Behavioral; 