LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------
ENTITY nbit_register_sclr IS
	GENERIC (MAX_WIDTH	:	INTEGER := 3);
	PORT (	clk			:	IN		STD_LOGIC;
				rst			:	IN		STD_LOGIC;
				ena			:	IN		STD_LOGIC;
				sclr			:	IN		STD_LOGIC;
				d				:	IN		STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
				q				:	OUT	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0));
END ENTITY;
-------------------------------------------------------------------
ARCHITECTURE rtl OF nbit_register_sclr IS
BEGIN
	dff: PROCESS(clk, rst, d)
	BEGIN
		IF(rst = '1')THEN
			q <= (OTHERS => '0');
		ELSIF (rising_edge(clk))THEN
			IF (ena='1') THEN
				IF(sclr = '1') THEN
					q <=(OTHERS => '0');
				ELSE
					q <= d;
				END IF;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;