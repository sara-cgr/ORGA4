LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
----------------------------------------------------------------------------
ENTITY mdr_register IS 
	GENERIC (DATA_WIDTH	 :	INTEGER := 8 );
	PORT (	clk	  		 :	  IN	STD_LOGIC;
				rst			 :	  IN  STD_LOGIC;
				mdr_alu_n	 :   IN 	STD_LOGIC;
				mdr_en		 :   IN 	STD_LOGIC;
				BUS_DATA_IN  :   IN 	STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
				bus_alu	    :   IN 	STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
				busC			 :   OUT	STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
				BUS_DATA_OUT :   OUT	STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0));
END ENTITY mdr_register;
----------------------------------------------------------------------------
ARCHITECTURE rtl OF mdr_register IS
	SIGNAL q_data : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
BEGIN
	alu_reg_8bits : ENTITY work.my_reg_8
	PORT MAP (  clk	  => clk,
					rst	  => rst,
					ena	  => mdr_en,
					d	  	  => bus_alu,
					q		  => BUS_DATA_OUT);
	data_reg_8bits : ENTITY work.my_reg_8
	PORT MAP (  clk	  => clk,
					rst	  => rst,
					ena	  => mdr_en,
					d	  	  => BUS_DATA_IN,
					q		  => q_data);
	busC <= bus_alu 				WHEN mdr_alu_n = '0' ELSE
			  q_data  				WHEN mdr_alu_n = '1' ELSE
			  (OTHERS => '0');
END ARCHITECTURE;
---------------------------------------------------------------------------