library ieee;
use ieee.std_logic_1164.all;

entity MMU_tb is
end MMU_tb;

architecture Simulation of MMU_tb is
	signal A_tb : std_logic_vector(31 downto 0);
	signal DO_tb : std_logic_vector(15 downto 0);
	signal Smar_tb, Smbr_tb, WRin_tb, RDin_tb : std_logic;
	signal AD_tb : std_logic_vector(31 downto 0);
	signal D_tb : std_logic_vector(15 downto 0);
	signal DI_tb : std_logic_vector(15 downto 0);
	signal WR_tb, RD_tb : std_logic;
	
begin
	uut: entity work.MMU port map(
		A => A_tb,
		DO => DO_tb,
		Smar => Smar_tb,
		Smbr => Smbr_tb,
		WRin => WRin_tb,
		RDin => RDin_tb,
		AD => AD_tb,
		D => D_tb,
		DI => DI_tb,
		WR => WR_tb,
		RD => RD_tb);
		
	process
	begin
		A_tb <= X"00000001";
		Smar_tb <= '1';
		Smbr_tb <= '0';
		WRin_tb <= '0';
		RDin_tb <= '1';
		D_tb <= "0010011000000001";
		wait for 20 ns;
		
		A_tb <= X"000003FF";
		DO_tb <= "0010011000000010";
		Smar_tb <= '1';
		Smbr_tb <= '1';
		WRin_tb <= '1';
		RDin_tb <= '0';
		D_tb <= "ZZZZZZZZZZZZZZZZ";
		wait for 20 ns;
		
		wait;
	end process;
end Simulation;