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
	LDF, Smar, Smbr, WR, RD, INTout : out std_logic
);
end ControlUnit;

architecture rtl of ControlUnit is
	type state_type is (m0, m1, m10, m11, m12, m13m, m14, m15);
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
							case IR(12 downto 11) is
								when "00" =>
									if INT = '0' then state <= m0;
									else state <= m11;
									end if;
									
								when "01" => state <= m10;		
								
								when "10" => state <= m11;
								
								when "11" => state <= m15;
								
								when others =>
									if INT = '0' then state <= m0;
									else state <= m11;
									end if;
							end case;
							
						when "001" =>
						
						when "010" =>
						
						when "011" =>
						
						when "100" =>
						
						when "101" =>
						
						when others =>
							if INT = '0' then state <= m0;
							else state <= m11;
							end if;
					end case;
				
				when m10 =>
					if INT = '1' then state <= m11;
					else state <= m10;
					end if;
					
				when m11 => state <= m12;
				
				when m12 => state <= m13;
				
				when m13 => state <= m14;
				
				when m14 =>
					if INT = '0' then state <= m0;
					else state <= m11;
					end if;
				
				when others =>
					if INT = '0' then state <= m0;
					else state <= m11;
					end if;
			end case;
		end if;
	end process;
	
	process(state)
	begin
		case state is
			when m0 => -- Fetch
				Sa <= "01"; Sid <= "001"; Sbb <= "00000"; Sbc <= "00000"; Sba <= "00000"; Salu <= "00000"; LDF <= '0';
				Smar <= '1'; Smbr <= '0'; WR <= '0'; RD <= '1';  INTout <= '0';
				
			when m1 => -- Decode
				Sa <= "00"; Sid <= "000"; Sbb <= "00000"; Sbc <= "00000"; Sba <= "00000"; Salu <= "00000"; LDF <= '0';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '0';
				
			when m10 => -- Wait
				Sa <= "00"; Sid <= "000"; Sbb <= "00000"; Sbc <= "00000"; Sba <= "00000"; Salu <= "00000"; LDF <= '0';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '0';
				
			when m11 => -- PCl to stack
				Sa <= "10"; Sid <= "011"; Sbb <= "10101"; Sbc <= "00000"; Sba <= "00000"; Salu <= "00000"; LDF <= '0';
				Smar <= '1'; Smbr <= '1'; WR <= '0'; RD <= '0'; INTout <= '1';
				
			when m12 => -- PCh to stack
				Sa <= "10"; Sid <= "011"; Sbb <= "10100"; Sbc <= "00000"; Sba <= "00000"; Salu <= "00000"; LDF <= '0';
				Smar <= '1'; Smbr <= '1'; WR <= '1'; RD <= '0'; INTout <= '1';
				
			when m13 => -- ATMPl to PCl
				Sa <= "00"; Sid <= "000"; Sbb <= "11001"; Sbc <= "00000"; Sba <= "10101"; Salu <= "00000"; LDF <= '0';
				Smar <= '0'; Smbr <= '0'; WR <= '1'; RD <= '0'; INTout <= '1';
				
			when m14 => -- ATMPh to PCh
				Sa <= "00"; Sid <= "000"; Sbb <= "11000"; Sbc <= "00000"; Sba <= "10100"; Salu <= "00000"; LDF <= '0';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '1';
			
			when others =>
				Sa <= "00"; Sid <= "000"; Sbb <= "00000"; Sbc <= "00000"; Sba <= "00000"; Salu <= "00000"; LDF <= '0';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '0';
		end case;
	end process;
end rtl;
