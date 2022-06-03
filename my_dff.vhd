--Jairo Esteban Acevedo Fajardo
-- D FLIP FLOP
---------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
---------------------------------------------------
ENTITY my_dff IS 
	PORT (	clk	  :	IN		STD_LOGIC;
				rst	  :   IN 	STD_LOGIC;
				ena	  :   IN 	STD_LOGIC;
				d	  	  :   IN 	STD_LOGIC;
				q		  :   OUT	STD_LOGIC);
END ENTITY my_dff;
ARCHITECTURE rtl OF my_dff IS
BEGIN
	dff: PROCESS(clk, rst, d)
	BEGIN
		IF(rst = '1') THEN
			q <= '0';
		ELSIF (rising_edge(clk)) THEN
			IF (ena = '1') THEN 
				q <= d; 
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;	
		