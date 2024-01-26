LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY simpleLogic;
USE simpleLogic.all;

ENTITY gateOr8 IS
  PORT (x: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        y: OUT STD_LOGIC);
END gateOr8;

ARCHITECTURE logicFunction OF gateOr8 IS
  SIGNAL l0_1, l0_2, l0_3, l0_4, l1_1, l1_2: STD_LOGIC;
  COMPONENT gateOr2
    PORT (x1, x2: IN STD_LOGIC;
          y: OUT STD_LOGIC);
  END COMPONENT;
BEGIN
  or0:  gateOr2  PORT MAP (x(0), x(1), l0_1);
  or1:  gateOr2  PORT MAP (x(2), x(3), l0_2);
  or2:  gateOr2  PORT MAP (x(4), x(5), l0_3);
  or3:  gateOr2  PORT MAP (x(6), x(7), l0_4);
  or4:  gateOr2  PORT MAP (l0_1, l0_2, l1_1);
  or5:  gateOr2  PORT MAP (l0_3, l0_4, l1_2);
  or6:  gateOr2  PORT MAP (l1_1, l1_2, y);
END logicFunction;