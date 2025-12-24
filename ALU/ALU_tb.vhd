library ieee;
use ieee.std_logic_1164.all;

entity ALU_tb is
end ALU_tb;

architecture Simulation of ALU_tb is
	signal clk_tb : std_logic;
	signal A_tb : std_logic_vector(15 downto 0);
	signal B_tb : std_logic_vector(15 downto 0);
	signal Salu_tb : std_logic_vector(4 downto 0);
	signal LDF_tb : std_logic;
	signal Y_tb : std_logic_vector(15 downto 0);
	signal C_tb, Z_tb, S_tb : std_logic;
	
begin
	uut: entity work.ALU port map(
		clk => clk_tb,
		A => A_tb,
		B => B_tb,
		Salu => Salu_tb,
		LDF => LDF_tb,
		Y => Y_tb,
		C => C_tb,
		Z => Z_tb,
		S => S_tb);
	 
	 process
	 begin	 
		LDF_tb <= '1';
	 
		clk_tb <= '1';
		A_tb <= X"0ABC";
		B_tb <= X"0DEF";
		Salu_tb <= "00000";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		  
		clk_tb <= '1';
		Salu_tb <= "00001";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		  
		clk_tb <= '1';
		Salu_tb <= "00010";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		
		clk_tb <= '1';
		Salu_tb <= "00011";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;

		clk_tb <= '1';
		Salu_tb <= "01001";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		  
		clk_tb <= '1';
		Salu_tb <= "01010";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		  
		clk_tb <= '1';
		Salu_tb <= "01101";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		  
		clk_tb <= '1';
		Salu_tb <= "10000";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		
		clk_tb <= '1';
		A_tb <= "0111111111111111";
		B_tb <= "0000000000000001";
		Salu_tb <= "00010";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
	 
		clk_tb <= '1';
		A_tb <= "0000000000000011";
		B_tb <= "0000000000000001";
		Salu_tb <= "01011";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
	 
		clk_tb <= '1';
		A_tb <= "0101010101010101";
		B_tb <= "1010101010101010";
		Salu_tb <= "00100";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		
		clk_tb <= '1';
		A_tb <= "0101010101010101";
		B_tb <= "1010101010101010";
		Salu_tb <= "00101";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		
		clk_tb <= '1';
		A_tb <= "0101010101010101";
		B_tb <= "1010101010101010";
		Salu_tb <= "00110";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		
		
		clk_tb <= '1';
		A_tb <= "0101010101010101";
		B_tb <= "1010101010101010";
		Salu_tb <= "00111";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		
		
		clk_tb <= '1';
		A_tb <= "0101010101010101";
		B_tb <= "1010101010101010";
		Salu_tb <= "01000";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		
		
		clk_tb <= '1';
		A_tb <= "0101010101010101";
		B_tb <= "1010101010101010";
		Salu_tb <= "01110";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		
		
		clk_tb <= '1';
		A_tb <= "0101010101010101";
		B_tb <= "1010101010101010";
		Salu_tb <= "01111";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		
		
		clk_tb <= '1';
		A_tb <= "0101010101010101";
		B_tb <= "1010101010101010";
		Salu_tb <= "10010";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		
		
		clk_tb <= '1';
		A_tb <= "0101010101010101";
		B_tb <= "1010101010101010";
		Salu_tb <= "10011";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		
		wait;
	end process;
end Simulation;