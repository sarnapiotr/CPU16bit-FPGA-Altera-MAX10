library ieee;
use ieee.std_logic_1164.all;

entity RegisterFile_tb is
end RegisterFile_tb;

architecture Simulation of RegisterFile_tb is
	signal clk_tb : std_logic;
	signal reset_tb : std_logic;
	signal DI_tb : std_logic_vector(15 downto 0);
	signal BA_tb : std_logic_vector(15 downto 0);
	signal Sbb_tb : std_logic_vector(4 downto 0);
	signal Sbc_tb : std_logic_vector(4 downto 0);
	signal Sba_tb : std_logic_vector(4 downto 0);
	signal Sid_tb : std_logic_vector(2 downto 0);
	signal Sa_tb : std_logic_vector(1 downto 0);
	signal BB_tb : std_logic_vector(15 downto 0);
	signal BC_tb : std_logic_vector(15 downto 0);
	signal A_tb : std_logic_vector(31 downto 0);
	signal IRout_tb : std_logic_vector(15 downto 0);
	
begin
	uut: entity work.RegisterFile port map(
		clk => clk_tb,
		reset => reset_tb,
		DI => DI_tb,
		BA => BA_tb,
		Sbb => Sbb_tb,
		Sbc => Sbc_tb,
		Sba => Sba_tb,
		Sid => Sid_tb,
		Sa => Sa_tb,
		BB => BB_tb,
		BC => BC_tb,
		A => A_tb,
		IRout => IRout_tb);
		
	process
	begin
		clk_tb <= '1';
		reset_tb <= '0';
		DI_tb <= "0010011000000001";
		Sbb_tb <= "00000";
		Sbc_tb <= "00001";
		Sid_tb <= "000";
		Sa_tb <= "00";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		
		clk_tb <= '1';
		BA_tb <= "0010011000000001";
		Sba_tb <= "00000";
		Sbb_tb <= "00010";
		Sbc_tb <= "00011";
		Sa_tb <= "01";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		
		clk_tb <= '1';
		Sa_tb <= "10";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		
		clk_tb <= '1';
		Sa_tb <= "11";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		
		clk_tb <= '1';
		Sid_tb <= "001";
		Sa_tb <= "01";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		
		clk_tb <= '1';
		Sid_tb <= "011";
		Sa_tb <= "10";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		
		clk_tb <= '1';
		Sid_tb <= "010";
		Sa_tb <= "10";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		
		clk_tb <= '1';
		Sid_tb <= "100";
		Sa_tb <= "00";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		
		clk_tb <= '1';
		Sid_tb <= "101";
		Sa_tb <= "00";
		wait for 20 ns;
		clk_tb <= '0';
		wait for 20 ns;
		
		wait;
	end process;
end Simulation; 