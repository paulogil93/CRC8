-- XOR 2:1--
library ieee;
use ieee.std_logic_1164.all;

entity xorGate2 is
	port (x0, x1 : IN STD_LOGIC;
			y: OUT STD_LOGIC);
end xorGate2;

architecture logicFunction of xorGate2 is
begin
	y<= x0 xor x1;
end logicFunction;

-- Remainder CRC-8 Bluetooth --
-- x^8 + x^7 + x^5 + x^2 + x + 1 --
-- 38 xor gates --

library ieee;
use ieee.std_logic_1164.all;

entity remainderBlock is
	port (a : IN STD_LOGIC_VECTOR (15 downto 0);
			r : OUT STD_LOGIC_VECTOR (7 downto 0));

end remainderBlock;

architecture structure of remainderBlock is
	signal s_a1_a6, s_a2_a4, s_a2_a5, s_a3_a5, s_a4_a6 		: STD_LOGIC;
	signal s_a7_a9, s_a8_a14, s_a8_a15, s_a3_a10, s_a0_a13 	: STD_LOGIC;
	signal s_a1_a12, s_a10_a12, s_a11_a15, s_a0_a3_a5			: STD_LOGIC;
	signal s_a2_a5_a10, s_a3_a5_a7, s_a8_a11_a14 				: STD_LOGIC;
	signal s_a10_a12_a14, s_a11_a13_a15, s_a11_a12_a15			: STD_LOGIC;
	signal s_a0_a1_a12_a13, s_a0_a7_a9_a13, s_a0_a8_a13_a14	: STD_LOGIC;
	signal s_a1_a2_a4_a6, s_a1_a3_a6_a10, s_a3_a4_a5_a6		: STD_LOGIC;
	signal s_a2_a4_a7_a9, s_a0_a3_a5_a10_a12_a14					: STD_LOGIC;
	signal s_a3_a5_a7_a11_a13_a15,  s_a3_a4_a5_a6_a8_a15		: STD_LOGIC;
	
	component xorGate2
		port (x0,x1 : IN STD_LOGIC;
				y: OUT STD_LOGIC);
	end component;

begin
	
	-- Level 1 --
	a1_a6: xorGate2 port map(a(1), a(6), s_a1_a6);
	a2_a4: xorGate2 port map(a(2), a(4), s_a2_a4);
	a2_a5: xorGate2 port map(a(2), a(5), s_a2_a5);
	a3_a5: xorGate2 port map(a(3), a(5), s_a3_a5);
	a4_a6: xorGate2 port map(a(4), a(6), s_a4_a6);
	a7_a9: xorGate2 port map(a(7), a(9), s_a7_a9);
	a8_a14: xorGate2 port map(a(8), a(14), s_a8_a14);
	a8_a15: xorGate2 port map(a(8), a(15), s_a8_a15);
	a3_a10: xorGate2 port map(a(3), a(10), s_a3_a10);
	a0_a13: xorGate2 port map(a(0), a(13), s_a0_a13);
	a1_a12: xorGate2 port map(a(1), a(12), s_a1_a12);
	a10_a12: xorGate2 port map(a(10), a(12), s_a10_a12);
	a11_a15: xorGate2 port map(a(11), a(15), s_a11_a15);
	
	-- Level 2 --
	a0_a3_a5: xorGate2 port map(s_a3_a5, a(0), s_a0_a3_a5);
	a2_a5_a10: xorGate2 port map(s_a2_a5, a(10), s_a2_a5_a10);
	a3_a5_a7: xorGate2 port map(s_a3_a5, a(7), s_a3_a5_a7);
	a8_a11_a14: xorGate2 port map(s_a8_a14, a(11), s_a8_a11_a14);
	a10_a12_a14: xorGate2 port map(s_a10_a12, a(14), s_a10_a12_a14);
	a11_a13_a15: xorGate2 port map(s_a11_a15, a(13), s_a11_a13_a15);
	a11_a12_a15: xorGate2 port map(s_a11_a15, a(12), s_a11_a12_a15);
	a0_a1_a12_a13: xorGate2 port map(s_a0_a13, s_a1_a12, s_a0_a1_a12_a13);
	a0_a7_a9_a13: xorGate2 port map(s_a0_a13, s_a7_a9, s_a0_a7_a9_a13);
	a0_a8_a13_a14: xorGate2 port map(s_a0_a13, s_a8_a14, s_a0_a8_a13_a14);
	a1_a2_a4_a6: xorGate2 port map(s_a1_a6, s_a2_a4, s_a1_a2_a4_a6);
	a1_a3_a6_a10: xorGate2 port map(s_a1_a6, s_a3_a10, s_a1_a3_a6_a10);
	a3_a4_a5_a6: xorGate2 port map(s_a3_a5, s_a4_a6, s_a3_a4_a5_a6);
	a2_a4_a7_a9: xorGate2 port map(s_a2_a4, s_a7_a9, s_a2_a4_a7_a9);
	
	
	-- Level 3
	a0_a3_a5_a10_a12_a14 : xorGate2 port map(s_a0_a3_a5, s_a10_a12_a14, s_a0_a3_a5_a10_a12_a14);
	a3_a5_a7_a11_a13_a15: xorGate2 port map(s_a3_a5_a7, s_a11_a13_a15, s_a3_a5_a7_a11_a13_a15);
	a3_a4_a5_a6_a8_a15: xorGate2 port map(s_a3_a4_a5_a6, s_a8_a15, s_a3_a4_a5_a6_a8_a15);
	
	-- Level 4 --
	r7: xorGate2 port map(s_a0_a1_a12_a13, s_a3_a5_a7, r(7)); 				--r7 = a0 xor a1 xor a3 xor a5 xor a7 xor a12 xor a13
	r6: xorGate2 port map(s_a1_a2_a4_a6, s_a3_a5_a7_a11_a13_a15, r(6));	--r6 = a1 xor a2 xor a3 xor a4 xor a5 xor a6 xor a7 xor a11 xor a13 xor a15
	r5: xorGate2 port map(s_a1_a2_a4_a6, s_a0_a3_a5_a10_a12_a14, r(5));	--r5 = a0 xor a1 xor a2 xor a3 xor a4 xor a5 xor a6 xor a10 xor a12 xor a14
	r4: xorGate2 port map(s_a11_a12_a15, s_a2_a4_a7_a9, r(4));				--r4 = a2 xor a4 xor a7 xor a9 xor a11 xor a12 xor a15
	r3: xorGate2 port map(s_a8_a11_a14, s_a1_a3_a6_a10, r(3));				--r3 = a1 xor a3 xor a6 xor a8 xor a10 xor a11 xor a14
	r2: xorGate2 port map(s_a2_a5_a10, s_a0_a7_a9_a13, r(2));				--r2 = a0 xor a2 xor a5 xor a7 xor a9 xor a10 xor a13
	r1: xorGate2 port map(s_a0_a7_a9_a13, s_a3_a4_a5_a6_a8_a15, r(1));	--r1 = a0 xor a3 xor a4 xor a5 xor a6 xor a7 xor a8 xor a9 xor a 13 xor a15
	r0: xorGate2 port map(s_a0_a8_a13_a14, s_a1_a2_a4_a6, r(0));			--r0 = a0 xor a1 xor a2 xor a4 xor a6 xor a8 xor a13 xor a14
	

end structure;

--CRC Encoder--

library ieee;
use ieee.std_logic_1164.all;

entity CRC8Encoder is
	port ( din : IN STD_LOGIC_VECTOR (15 downto 0);
			 dout : OUT STD_LOGIC_VECTOR (23 downto 0));			 
end CRC8Encoder;

architecture structure of CRC8Encoder is
	component remainderBlock
		port ( a : IN STD_LOGIC_VECTOR (15 downto 0);
				 r : OUT STD_LOGIC_VECTOR (7 downto 0));
	end component;
begin	
	
	remainder: remainderBlock  port map (din (15 downto 0), dout (7 downto 0));
	
	dout (23 downto 8) <= din;
	
end structure;			