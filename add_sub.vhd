--add_sub Jairo Esteban Acevedo Fajardo
--------------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
--------------------------------------------------------ENTITY add_sub IS
ENTITY add_sub IS
	GENERIC (N: INTEGER :=8);
	PORT (	addn_sub   :	IN			STD_LOGIC;
				a			  :	IN			STD_LOGIC_VECTOR(N-1 DOWNTO 0);--Each bit represents a corrsponding bit for the number
				b			  :	IN			STD_LOGIC_VECTOR(N-1 DOWNTO 0);--Each bit represents a corrsponding bit for the number
				C_out      :	OUT		STD_LOGIC;
				S			  :	OUT		STD_LOGIC_VECTOR(N-1 DOWNTO 0));
	END ENTITY add_sub;
ARCHITECTURE rtl OF add_sub IS
	SIGNAL bxor					: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL add_nsub_vector	: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
BEGIN
	vector_generation: FOR i IN N-1 DOWNTO 0 GENERATE
		add_nsub_vector(i) <= addn_sub;
	END GENERATE;
	bxor <= b XOR add_nsub_vector;
	adder: ENTITY work.N_bit_Adder
	 GENERIC MAP(    N		  =>    N)
    PORT    MAP(    a    	  =>    a,
                    b   	  =>    bxor,
						  C_out    =>    c_out,
						  C_in0    =>    addn_sub,
                    S 		  =>    S); 
END ARCHITECTURE;