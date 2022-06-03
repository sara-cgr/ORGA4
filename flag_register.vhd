LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-----------------------------------------------------
ENTITY flag_register IS
	GENERIC(MAX_WIDTH			:	INTEGER	:=8);
	PORT(	  clk			:	IN		STD_LOGIC;
			  rst			:	IN 	STD_LOGIC;
			  enaf		:	IN		STD_LOGIC;
			  dataa		:	IN		STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
			  carry		:	IN 	STD_LOGIC;
			  C,N,Z,P	:	OUT	STD_LOGIC);
END ENTITY flag_register;
--------------------------------------------------------------
ARCHITECTURE rtl OF flag_register IS
	CONSTANT ZEROS	:	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
BEGIN
	PROCESS(clk,rst)
	BEGIN
		IF(rst = '1') THEN
			N <= '0';
			C <= '0';
			Z <= '0';
			P <= '0';
		ELSIF(rising_edge(clk)) THEN
			IF(enaf = '1')THEN
				N <= dataa(7);
				c <= carry;
				P <= NOT (dataa(7) XOR dataa(6) XOR dataa(5) XOR dataa(4) XOR dataa(5) XOR dataa(2) XOR dataa(1) XOR dataa(0));
				IF dataa = ZEROS THEN
					Z <= '1';
				ELSE
					Z <= '0';
				END IF;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;
			