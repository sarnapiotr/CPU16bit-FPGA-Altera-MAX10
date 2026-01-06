library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ControlUnit is
port(
	clk : in std_logic;
	reset, C, Z, S, INT : in std_logic;
	IR : in std_logic_vector(15 downto 0);
	Sa : out std_logic_vector(1 downto 0);
	Sid : out std_logic_vector(2 downto 0);
	Salu, Sbb, Sbc, Sba : out std_logic_vector(4 downto 0);
	LDF, Smar, Smbr, WR, RD, INTout : out std_logic;
);
end ControlUnit;

architecture rtl of ControlUnit is
	type state_type is (m0, m1, m9, m10);
	signal state : state_type;
begin
	process(clk, reset)
	begin
		if reset = '1' then
			state <= m0;
			
		elsif rising_edge(clk) then
			case state is
				when m0 =>
					state <= m1;
				when m1 =>
					case IR(15 downto 13) is
						when "000" =>
						
						when "001" =>
						
						when "010" =>
						
						when "011" =>
						
						when "100" =>
						
						when "101" =>
						
					end case;
			end case;
		end if;
	end process;
	
	process(state)
	begin
		case state is
			when m0 =>
				Sa <= "01"; Sid <= "001"; Sbb <= "00000"; Sbc <= "00000"; Sba <= "00000"; Salu <= "00000"; LDF <= '0';
				Smar <= '1'; Smbr <= '0'; WR <= '0'; RD <= '1';  INTout <= '0';
			when m1 =>
				Sa <= "00"; Sid <= "000"; Sbb <= "00000"; Sbc <= "00000"; Sba <= "00000"; Salu <= "00000"; LDF <= '0';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '0';
		end case;
	end process;
end rtl;
