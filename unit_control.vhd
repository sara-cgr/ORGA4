LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-----------------------------------------------------
ENTITY unit_control IS
PORT(	clk			:	IN		STD_LOGIC;
		rst			:	IN		STD_LOGIC;
		Z,N,C,P		:	IN		STD_LOGIC;
		int			:	IN		STD_LOGIC;
		opcode		:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);
		UI		: 	OUT 	STD_LOGIC_VECTOR(20 DOWNTO 0));
END ENTITY unit_control;
-----------------------------------------------------
ARCHITECTURE rtl OF unit_control IS
	SIGNAL ena_uPC, clr_uPC, load				: STD_LOGIC;
	SIGNAL offset, jcond, q_PC, d_PC, PC1  : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL uaddr 									: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL r_data						   		: STD_LOGIC_VECTOR(28 DOWNTO 0);
BEGIN
	
	uaddr(2 DOWNTO 0) <= q_PC;
	uaddr(7 DOWNTO 3) <= opcode;
	
	uP_ROM : ENTITY work.uProgramMemory
	PORT MAP (  uaddr	 => uaddr,
					UI		 => r_data);
	UI <= r_data(28 DOWNTO 8);
	uPC  : ENTITY work.nbit_register_sclr
	GENERIC MAP(MAX_WIDTH => 3 )
	PORT MAP (  clk	=>	clk,
					rst	=>	rst,
					ena	=> ena_uPC,
					sclr	=> clr_uPC,	
					d		=> d_PC,	
					q		=> q_PC);
   add_sub : ENTITY work.add_sub
	GENERIC MAP(N => 3 )
	PORT MAP (  addn_sub   => '0',
					a			  => q_PC,
					b			  => "001",
					S			  => PC1);
	-- PC Mux
	WITH load SELECT
		d_PC		<= PC1			WHEN	'0',
						offset		WHEN	OTHERS;
	--JUMP Mux
	WITH jcond	SELECT
		load		<= '0'			WHEN "000",
						'1'			WHEN "001",
						Z				WHEN "010",
						N				WHEN "011",
						C				WHEN "100",
						P				WHEN "101",
						int			WHEN "110",
						'0'			WHEN OTHERS;
						
	ena_uPC <= r_data(7);
	clr_uPC <= r_data(6);
	jcond   <= r_data(5 DOWNTO 3);
	offset  <= r_data(2 DOWNTO 0);
END ARCHITECTURE;
----------------------------------