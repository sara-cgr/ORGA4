LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
----------------------------------------------------------------------------
ENTITY register_file IS 
GENERIC (DATA_WIDTH	:	INTEGER := 8 ;
				ADDR_WIDTH  :  INTEGER := 3;
				PCINIT   : INTEGER := 0;
				SPINIT   : INTEGER := 255;
	         DPTRINIT : INTEGER := 0;
				AINIT    : INTEGER := 0;
				AVIINIT 	: INTEGER := 1;
				TEMPINIT : INTEGER := 0;
				CTE1INIT : INTEGER := 255;
				ACCINIT  : INTEGER := 0);
	PORT (	clk	  :	IN		STD_LOGIC;
				rst	  :   IN    STD_LOGIC;
				wr_en	  :   IN 	STD_LOGIC;
				w_addr  :   IN 	STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
				r_addr  :   IN 	STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
				w_data  :   IN 	STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
				Bus_A   :   OUT	STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
				Bus_B   :   OUT	STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0));
END ENTITY register_file;
----------------------------------------------------------------------------
ARCHITECTURE rtl OF register_file IS
	TYPE mem_type IS ARRAY (0  TO 2**ADDR_WIDTH-1) OF STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL array_reg: mem_type;
BEGIN
	write_process: PROCESS(clk)
	BEGIN
	   IF  rst='1' THEN 
		   array_reg(0) <= STD_LOGIC_VECTOR(to_unsigned(PCINIT,8));
			array_reg(1) <= STD_LOGIC_VECTOR(to_unsigned(SPINIT,8));
			array_reg(2) <= STD_LOGIC_VECTOR(to_unsigned(DPTRINIT,8));
			array_reg(3) <= STD_LOGIC_VECTOR(to_unsigned(AINIT,8));
			array_reg(4) <= STD_LOGIC_VECTOR(to_unsigned(AVIINIT,8));
			array_reg(5) <= STD_LOGIC_VECTOR(to_unsigned(TEMPINIT,8));
			array_reg(6) <= STD_LOGIC_VECTOR(to_unsigned(CTE1INIT,8));
			array_reg(7) <= STD_LOGIC_VECTOR(to_unsigned(ACCINIT,8));
		ELSIF (rising_edge(clk)) THEN
			IF (wr_en= '1' )  THEN
				array_reg(to_integer(unsigned(w_addr))) <= w_data;
			END IF;
		END IF;
	END PROCESS;
	Bus_A <= array_reg(7);
	Bus_B <= array_reg(to_integer(unsigned(r_addr)));
END ARCHITECTURE;