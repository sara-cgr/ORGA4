--N_bit adder Jairo Esteban Acevedo Fajardo
---------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
------------------------------ENTITY N_bit_Adder IS 
---------------------
ENTITY N_bit_Adder IS
	GENERIC (N:	INTEGER	:= 8);
	PORT (	C_in0	     :	IN			STD_LOGIC;
				a			  :	IN			STD_LOGIC_VECTOR(N-1 DOWNTO 0);--Each bit represents a corrsponding bit for the number
				b			  :	IN			STD_LOGIC_VECTOR(N-1 DOWNTO 0);--Each bit represents a corrsponding bit for the number
				C_out      :	OUT		STD_LOGIC;
				S			  :	OUT		STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END ENTITY N_bit_Adder;
---------------------------------------------------
ARCHITECTURE rtl OF N_bit_Adder IS
	SIGNAL carry : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
---------------------------------------------------
BEGIN
	
	adder: FOR i IN N-1 DOWNTO 0 GENERATE
		BIT0: IF i=0 GENERATE
			B0: ENTITY work.full_adder PORT MAP (a(i),b(i),C_in0,carry(i),S(i));
			END GENERATE;
		BITN: IF i/=0 GENERATE
			BN: ENTITY work.full_adder PORT MAP (a(i),b(i),carry(i-1),carry(i),S(i));
			END GENERATE;
	END GENERATE;
	C_out <= carry(N-1);
END ARCHITECTURE rtl;