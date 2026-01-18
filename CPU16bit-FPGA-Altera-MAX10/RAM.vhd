library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM is
port(
	clk : in std_logic;
	AD : in std_logic_vector(31 downto 0);
	D : inout std_logic_vector(15 downto 0);
	WR, RD : in std_logic
);
end RAM;

architecture rtl of RAM is
	type memory is array (0 to 1023) of std_logic_vector(15 downto 0);
	signal ram : memory;
	
	attribute ram_init_file : string;
	attribute ram_init_file of ram : signal is "ram_init_file.mif";
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if WR = '1' then
				ram(to_integer(unsigned(AD(9 downto 0)))) <= D;
			end if;
		end if;
	end process;
	
	D <= ram(to_integer(unsigned(AD(9 downto 0)))) when RD = '1' else "ZZZZZZZZZZZZZZZZ";
end rtl;