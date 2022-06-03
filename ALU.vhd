--------------------------------------------------------
--------------- ALU.VHD (COMPONENT): -------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
--------------------------------------------------------
ENTITY ALU IS
	GENERIC (MAX_WIDTH: INTEGER :=8);
	PORT(    clk		:	IN STD_LOGIC;
		      rst		:  IN STD_LOGIC;
		      busA    	:  IN STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
				busB    	:  IN STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
				selop    :  IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            shamt    :  IN STD_LOGIC_VECTOR (1 DOWNTO 0);
            enaf     :  IN STD_LOGIC;
            busC     :  OUT STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
				C,N,P,Z  :  OUT STD_LOGIC); --Flags);
				
END ENTITY ALU;

----------------------------------------------------------
 ARCHITECTURE rtl OF ALU IS
  SIGNAL cout : STD_LOGIC;
  SIGNAL result : STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
  ----------------------------------------------------------
 BEGIN
	proc_u: ENTITY work.processing_unit
	PORT MAP(	dataa    => busA,
	            datab    => busB,
					selop    => selop,
	            cout     => cout,
					result   => result);
					
   flag_rec: ENTITY work.flag_register
	PORT MAP(	clk    => clk,
	            rst    => rst,
					enaf    => enaf,
	            dataa     => result,
					carry   => cout,
					C   => C,
					N  => N,
					P   => P,
					Z   => Z);

	shift_u: ENTITY work.shift_unit
	PORT MAP(	shamt    => shamt,
	            dataa    => result,
					dataout  => busC);
					
					
END ARCHITECTURE;