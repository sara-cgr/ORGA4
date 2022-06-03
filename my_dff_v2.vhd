LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------
ENTITY my_dff_v2 IS
	PORT (	clk			:	IN		STD_LOGIC;
				rst			:	IN		STD_LOGIC;
				ena			:	IN		STD_LOGIC;
				sclr			:	IN		STD_LOGIC;
				d				:	IN		STD_LOGIC;
				q				:	OUT	STD_LOGIC);
END ENTITY;
-------------------------------------------------------------------
ARCHITECTURE rtl OF my_dff_v2 IS
BEGIN
	dff: PROCESS(clk, rst, d)
	BEGIN
		IF(rst = '1')THEN
			q <= '0';
		ELSIF (rising_edge(clk))THEN
			IF (ena='1') THEN
				IF(sclr = '1') THEN
					q <='0';
				ELSE
					q <= d;
				END IF;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;