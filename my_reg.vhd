LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
---------------------------------------------------
ENTITY my_reg IS 
	GENERIC (MAX_WIDTH	:	INTEGER := 8);
	PORT (	clk	  :	IN		STD_LOGIC;
				rst	  :   IN 	STD_LOGIC;
				ena	  :   IN 	STD_LOGIC;
				d	  	  :   IN 	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
				q		  :   OUT	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0));
END ENTITY my_reg;
ARCHITECTURE rtl OF my_reg IS
BEGIN
	dff: PROCESS(clk, rst, d)
	BEGIN
		IF(rst = '1') THEN
			q <= (OTHERS => '0');
		ELSIF (rising_edge(clk)) THEN
			IF (ena = '1') THEN 
				q <= d; 
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;	
		