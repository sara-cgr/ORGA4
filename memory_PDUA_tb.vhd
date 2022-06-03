LIBRARY IEEE; -- IEEE library is included
USE IEEE.STD_LOGIC_1164.ALL; -- the std_logic_1164 package from the IEEE library is used
--------------------------------------------------------
ENTITY memory_PDUA_tb IS 
END ENTITY memory_PDUA_tb; 
--------------------------------------------------------
ARCHITECTURE testbench_memory_PDUA OF memory_PDUA_tb IS 
    --SIGNALS
    SIGNAL clk_tb	        :	 STD_LOGIC:='1';
    SIGNAL rst_tb	        :    STD_LOGIC:='1';
	 SIGNAL INT_tb	        :    STD_LOGIC:='0';
	 SIGNAL PHER_IN_tb	        :    STD_LOGIC_VECTOR(7 DOWNTO 0);
	 SIGNAL PHER2_tb	        :    STD_LOGIC_VECTOR(7 DOWNTO 0);
	 SIGNAL PHER3_tb	        :    STD_LOGIC_VECTOR(7 DOWNTO 0);
	 SIGNAL PHER1_tb	        :    STD_LOGIC:='0';
				
BEGIN
    ----CLOCK GENERATION----
	 clk_tb <= NOT clk_tb AFTER 10ns; 
	 
	 ----RESET GENERATION----
	 rst_tb        <='0'    AFTER 10ns;
	 
	 --test vectors
	 PHER_IN_tb <= "00000000" AFTER 10ns;--Primer ciclo
	 INT_tb      <= '0' AFTER 10ns;--Primer ciclo
							
    DUT: ENTITY work.memory_PDUA
	 GENERIC MAP(PCINIT => 0,
					SPINIT => 255,
					DPTRINIT => 0,
					AINIT => 0,
					AVIINIT => 128,
					TEMPINIT => 0,
					CTE1INIT => 255, 
					ACCINIT => 0 )
    PORT    MAP(    clk    	      => clk_tb,
				        rst	            => rst_tb,
				        INT					=> INT_tb,
						  PHER_IN			=> PHER_IN_tb,
						  PHER1				=> PHER1_tb,
						  PHER2				=> PHER2_tb,
						  PHER3				=> PHER3_tb);
 
END ARCHITECTURE testbench_memory_PDUA;