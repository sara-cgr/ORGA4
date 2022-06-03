 LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
----------------------------------------------------------------------------
ENTITY memory_PDUA IS 
	GENERIC (DATA_WIDTH			:	INTEGER := 8 ;
				ADDR_WIDTH  		:  INTEGER := 3; 
				PCINIT   : INTEGER := 0;
				SPINIT   : INTEGER := 255;
	         DPTRINIT : INTEGER := 0;
				AINIT    : INTEGER := 0;
				AVIINIT 	: INTEGER := 1;
				TEMPINIT : INTEGER := 0;
				CTE1INIT : INTEGER := 255;
				ACCINIT  : INTEGER := 0);
	PORT (	clk	  		 		:	 IN	STD_LOGIC;
				rst			 		:	 IN   STD_LOGIC;
				INT					:   IN   STD_LOGIC;		
				PHER1					: 	 OUT	STD_LOGIC;
				PHER2					: 	 OUT	STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
				PHER3					:   OUT  STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
				PHER_IN				: 	 IN	STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0));
END ENTITY memory_PDUA;
----------------------------------------------------------------------------
ARCHITECTURE rtl OF memory_PDUA IS
	SIGNAL ADDR_BUS 			    : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL BusA, BusB, BusC     : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL s_units, s_tenths	 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL q_data, BUS_DATA_OUT : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL bus_alu, BUS_DATA_IN : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL ir_clr					 : STD_LOGIC;
	SIGNAL C,N,P,Z					 : STD_LOGIC;
	SIGNAL mdr_alu_n	 			 : STD_LOGIC;
	SIGNAL mdr_en		 			 : STD_LOGIC;
	SIGNAL ir_en		    		 : STD_LOGIC;
	SIGNAL mar_en		 			 : STD_LOGIC;
	SIGNAL wr_rdn  		 		 : STD_LOGIC;
	SIGNAL bank_wr_en	 			 : STD_LOGIC;
	SIGNAL BusC_addr    			 : STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
	SIGNAL BusB_addr    			 : STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
	SIGNAL selop    	 			 : STD_LOGIC_VECTOR (2 DOWNTO 0);
   SIGNAL shamt   	    		 : STD_LOGIC_VECTOR (1 DOWNTO 0);
   SIGNAL enaf         			 : STD_LOGIC;
	SIGNAL iom						 : STD_LOGIC;
	SIGNAL int_clr					 : STD_LOGIC;
	SIGNAL INT_reg					 : STD_LOGIC;
	SIGNAL UI						 : STD_LOGIC_VECTOR (20 DOWNTO 0);
	SIGNAL ADDR_BUS_DM 			 : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL BUS_DATA_OUT_DM		 : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL BUS_DATA_IN_M			 : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL WR_RDN_DM				 : STD_LOGIC;
	
BEGIN
	REG_INT: ENTITY work.my_dff_v2
	PORT MAP (  clk	  => clk,
					rst	  => rst,
					ena	  => INT,
					d	  	  => '1',
					sclr    => int_clr,
					q		  => INT_reg);
	MAR : ENTITY work.my_reg_8
	PORT MAP (  clk	  => clk,
					rst	  => rst,
					ena	  => mar_en,
					d	  	  => BusC,
					q		  => ADDR_BUS);
	IR  : ENTITY work.nbit_register_sclr
	GENERIC MAP(MAX_WIDTH => 8 )
	PORT MAP (  clk	  => clk,
					rst	  => rst,
					ena	  => ir_en,
					d	  	  => BusC,
					sclr    => ir_clr,
					q		  => q_data);
   MDR : ENTITY work.mdr_register
	PORT MAP (  clk	  		 =>  clk,
					rst			 =>  rst,
					mdr_alu_n	 =>  mdr_alu_n, 
					mdr_en		 =>  mdr_en,
					BUS_DATA_IN  =>  BUS_DATA_IN_M,
					bus_alu	    =>  bus_alu,
					busC			 =>  BusC,
					BUS_DATA_OUT =>  BUS_DATA_OUT);
	REGISTER_BANK : ENTITY work.register_file
	GENERIC MAP(PCINIT => PCINIT,
					SPINIT => SPINIT,
					DPTRINIT => DPTRINIT,
					AINIT => AINIT,
					AVIINIT => AVIINIT,
					TEMPINIT => TEMPINIT,
					CTE1INIT => CTE1INIT, 
					ACCINIT => ACCINIT )
	PORT MAP (  clk	  => clk,
					rst     => rst,
					wr_en	  => bank_wr_en,
					w_addr  => BusC_addr,
					r_addr  => BusB_addr,
					w_data  => BusC,
					Bus_A   => BusA,
					Bus_B   => BusB);
	ALU : ENTITY work.ALU
	PORT MAP(	busA    => BusA,
	            busB    => BusB,
					selop   => selop,
					clk     => clk,
	            rst     => rst,
					enaf    => enaf,
					C       => C,
					N       => N,
					P       => P,
					Z       => Z,
					shamt   => shamt,
					busC    => bus_alu);
	RAM : ENTITY work.my_SPRAM
	PORT MAP (  clk	  => clk,
					wr_rdn  => WR_RDN_DM,
					addr	  => ADDR_BUS_DM,
					w_data  => BUS_DATA_OUT_DM,
					r_data  => BUS_DATA_IN);
	CONTROL_UNIT: ENTITY work.unit_control
	PORT MAP (  clk	  => clk,
					rst     => rst,
					P		  => P,
					C       => C,
					N		  => N,
					Z		  => Z,
					int     => INT_reg,
					opcode  => q_data(7 DOWNTO 3),
					UI		  => UI);
	ir_clr <= UI(0);
	ir_en <= UI(1);
	wr_rdn <= UI(2);
	iom    <= UI(3);
	int_clr <= UI(4);
	mdr_alu_n <= UI(5);
	mdr_en <=UI(6);
	mar_en <= UI(7);
	bank_wr_en <= UI(8);
	busC_addr  <= UI(11 DOWNTO 9);
	busB_addr  <= UI(14 DOWNTO 12);
	shamt      <= UI(16 DOWNTO 15);
	selop      <= UI(19 DOWNTO 17);
	enaf       <= UI(20);
--EXTERNAL BUS	
	-- WR_RDN demux
		WR_RDN_DM	<= wr_rdn	WHEN	iom = '0' ELSE '0';
		PHER1		<= wr_rdn   WHEN  iom = '1' ELSE '0';
	
	-- AD_BUS demux
		ADDR_BUS_DM	<= ADDR_BUS	WHEN	iom = '0' ELSE "00000000";
		PHER2		<= ADDR_BUS   WHEN  iom = '1' ELSE "00000000";
		
	-- B_DATA demux
		BUS_DATA_OUT_DM	<= BUS_DATA_OUT	WHEN	iom = '0' ELSE "00000000";
		PHER3		<= BUS_DATA_OUT   WHEN  iom = '1' ELSE "00000000";
		

	WITH iom SELECT
		BUS_DATA_IN_M		<= BUS_DATA_IN		WHEN	'0',
								  PHER_IN 			WHEN	OTHERS;
	
					
END ARCHITECTURE;
-------------------------------------------------------------
	
					