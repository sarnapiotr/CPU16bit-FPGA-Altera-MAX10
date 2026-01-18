library ieee;
use ieee.std_logic_1164.all;

entity HEX2bit is
port(
	i : in std_logic_vector(1 downto 0);
	o : out std_logic_vector(6 downto 0)
);
end HEX2bit;

architecture rtl of HEX2bit is
begin
	with i select
		o <= "1000000" when "00",
			  "1111001" when "01",
			  "0100100" when "10",
			  "0110000" when "11",
			  "1111111" when others;
end rtl;