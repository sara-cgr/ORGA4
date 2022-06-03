LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
---------------------------------------------------
ENTITY my_reg_8 IS 
	GENERIC (EIGHT	:	INTEGER := 8);
	PORT (	clk	  :	IN		STD_LOGIC;
				rst	  :   IN 	STD_LOGIC;
				ena	  :   IN 	STD_LOGIC;
				d	  	  :   IN 	STD_LOGIC_VECTOR(EIGHT-1 DOWNTO 0);
				q		  :   OUT	STD_LOGIC_VECTOR(EIGHT-1 DOWNTO 0));
END ENTITY my_reg_8;
ARCHITECTURE rtl OF my_reg_8 IS
BEGIN
my_reg_8bits : ENTITY work.my_reg
GENERIC MAP (MAX_WIDTH => EIGHT)
PORT MAP (  clk	  => clk,
				rst	  => rst,
				ena	  => ena,
				d	  	  => d,
				q		  => q);
END ARCHITECTURE;	