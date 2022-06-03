--Full Adder, based upon a multiplexer perspective
--by using a whith select writing
--Jairo Esteban Acevedo Fajardo
---------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
---------------------------------------------------
ENTITY full_adder IS 
	PORT (	a    		:	IN		STD_LOGIC;
				b			:  IN    STD_LOGIC;
				C_in		: 	IN 	STD_LOGIC;
				C_out		:	OUT	STD_LOGIC;
				S			:	OUT	STD_LOGIC);
	END ENTITY full_adder;
---------------------------------------------------
ARCHITECTURE functional OF full_adder IS
	SIGNAL input: STD_LOGIC_VECTOR(2 DOWNTO 0);
---------------------------------------------------
BEGIN
	input	<= a & b & C_in;
	WITH input SELECT
	   C_out <= '1' WHEN "011",
					'1' WHEN "101",
					'1' WHEN "110",
					'1' WHEN "111",
					'0' WHEN OTHERS;
	WITH input SELECT
		S		<=	'1' WHEN "001",
					'1' WHEN "010",
					'1' WHEN "100",
					'1' WHEN "111",
					'0' WHEN OTHERS;
			  
END ARCHITECTURE functional;