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
	type state_type is (m0, m1, m10, m11, m12, m13, m14, m15, m16, m17,
							  m20, m21, m22, m23, m24, m25, m26, m27, m28, m29, m30, m31, m32, m33, m34, m35, m36, m40, m41);
	signal state : state_type;
begin
	process(clk, reset)
	begin
		if reset = '1' then
			state <= m0;
			
		elsif rising_edge(clk) then
			case state is
				when m0 => state <= m1;
					
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
							case IR(12 downto 9) is
								when "0000" => state <= m20;
								
								when "0001" => state <= m21;
								
								when "0010" => state <= m23;
								
								when "0011" => state <= m24;
								
								when "0100" => state <= m25;
								
								when "0101" => state <= m26;
								
								when "0110" => state <= m27;
								
								when "0111" => state <= m28;
								
								when "1000" => state <= m29;
								
								when "1001" => state <= m30;
								
								when "1010" => state <= m31;
								
								when "1011" => state <= m32;
								
								when "1100" => state <= m33;
								
								when "1101" => state <= m34;
								
								when "1110" => state <= m35;
								
								when "1111" => state <= m36;
								
								when others =>
									if INT = '0' then state <= m0;
									else state <= m11;
									end if;
							end case;
							
						when "010" => state <= m40;
						
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
				
				when m15 => state <= m16;
				
				when m16 => state <= m17;
				
				when m21 => state <= m22;
				
				when m40 =>
					if IR(12 downto 11) = "00" then state <= m41;
						
					elsif IR(12 downto 11) = "01" and C = '1' then state <= m41;
					
					elsif IR(12 downto 11) = "10" and Z = '1' then state <= m41;
					
					elsif IR(12 downto 11) = "11" and S = '1' then state <= m41;
					
					else
						if INT = '0' then state <= m0;
						else state <= m11;
						end if;
					end if;
				
				when m14 | m17 | m20 | m22 | m23 | m24 | m25 | m26 | m27 | m28 | m29 | m30 | m31 | m32 | m33 | m34 | m35 | m36 | m41 =>
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
				
			-- Group 000
				
			when m10 => -- Wait
				Sa <= "00"; Sid <= "000"; Sbb <= "00000"; Sbc <= "00000"; Sba <= "00000"; Salu <= "00000"; LDF <= '0';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '0';
				
			when m11 => -- PCl to stack
				Sa <= "10"; Sid <= "011"; Sbb <= "10101"; Sbc <= "00000"; Sba <= "00000"; Salu <= "00000"; LDF <= '0';
				Smar <= '1'; Smbr <= '1'; WR <= '1'; RD <= '0'; INTout <= '1';
				
			when m12 => -- PCh to stack
				Sa <= "10"; Sid <= "011"; Sbb <= "10100"; Sbc <= "00000"; Sba <= "00000"; Salu <= "00000"; LDF <= '0';
				Smar <= '1'; Smbr <= '1'; WR <= '1'; RD <= '0'; INTout <= '1';
				
			when m13 => -- ATMPl to PCl
				Sa <= "00"; Sid <= "000"; Sbb <= "11001"; Sbc <= "00000"; Sba <= "10101"; Salu <= "00000"; LDF <= '0';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '1';
				
			when m14 => -- ATMPh to PCh
				Sa <= "00"; Sid <= "000"; Sbb <= "11000"; Sbc <= "00000"; Sba <= "10100"; Salu <= "00000"; LDF <= '0';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '1';
				
			when m15 => -- SP++
				Sa <= "00"; Sid <= "010"; Sbb <= "00000"; Sbc <= "00000"; Sba <= "00000"; Salu <= "00000"; LDF <= '0';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '0';
				
			when m16 => -- stack to PCh SP++
				Sa <= "10"; Sid <= "010"; Sbb <= "00000"; Sbc <= "00000"; Sba <= "10100"; Salu <= "00000"; LDF <= '0';
				Smar <= '1'; Smbr <= '0'; WR <= '0'; RD <= '1'; INTout <= '0';
				
			when m17 => -- stack to PCl
				Sa <= "10"; Sid <= "000"; Sbb <= "00000"; Sbc <= "00000"; Sba <= "10101"; Salu <= "00000"; LDF <= '0';
				Smar <= '1'; Smbr <= '0'; WR <= '0'; RD <= '1'; INTout <= '0';
				
			-- Group 001
			
			when m20 => -- R to stack
				Sa <= "10"; Sid <= "011"; Sbb <= IR(4 downto 0); Sbc <= "00000"; Sba <= "00000"; Salu <= "00000"; LDF <= '0';
				Smar <= '1'; Smbr <= '1'; WR <= '1'; RD <= '0'; INTout <= '0';
				
			when m21 => -- SP++
				Sa <= "00"; Sid <= "010"; Sbb <= "00000"; Sbc <= "00000"; Sba <= "00000"; Salu <= "00000"; LDF <= '0';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '0';
				
			when m22 => -- stack to R
				Sa <= "10"; Sid <= "000"; Sbb <= "00000"; Sbc <= "00000"; Sba <= IR(4 downto 0); Salu <= "00000"; LDF <= '0';
				Smar <= '1'; Smbr <= '0'; WR <= '0'; RD <= '1'; INTout <= '0';
			
			when m23 => -- -R
				Sa <= "00"; Sid <= "000"; Sbb <= IR(4 downto 0); Sbc <= "00000"; Sba <= IR(4 downto 0); Salu <= "01001"; LDF <= '1';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '0';
				
			when m24 => -- R++
				Sa <= "00"; Sid <= "000"; Sbb <= IR(4 downto 0); Sbc <= "00000"; Sba <= IR(4 downto 0); Salu <= "01101"; LDF <= '1';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '0';
				
			when m25 => -- R--
				Sa <= "00"; Sid <= "000"; Sbb <= IR(4 downto 0); Sbc <= "00000"; Sba <= IR(4 downto 0); Salu <= "10000"; LDF <= '1';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '0';
				
			when m26 => -- not R
				Sa <= "00"; Sid <= "000"; Sbb <= IR(4 downto 0); Sbc <= "00000"; Sba <= IR(4 downto 0); Salu <= "01000"; LDF <= '1';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '0';
				
			when m27 => -- shr R
				Sa <= "00"; Sid <= "000"; Sbb <= IR(4 downto 0); Sbc <= "00000"; Sba <= IR(4 downto 0); Salu <= "01111"; LDF <= '1';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '0';
				
			when m28 => -- shl R
				Sa <= "00"; Sid <= "000"; Sbb <= IR(4 downto 0); Sbc <= "00000"; Sba <= IR(4 downto 0); Salu <= "01110"; LDF <= '1';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '0';
				
			when m29 => -- RAM to R
				Sa <= "00"; Sid <= "000"; Sbb <= "00000"; Sbc <= "00000"; Sba <= IR(4 downto 0); Salu <= "00000"; LDF <= '0';
				Smar <= '1'; Smbr <= '0'; WR <= '0'; RD <= '1'; INTout <= '0';
				
			when m30 => -- R to RAM
				Sa <= "00"; Sid <= "000"; Sbb <= IR(4 downto 0); Sbc <= "00000"; Sba <= "00000"; Salu <= "00000"; LDF <= '0';
				Smar <= '1'; Smbr <= '1'; WR <= '1'; RD <= '0'; INTout <= '0';
				
			when m31 => -- R = R + TMP
				Sa <= "00"; Sid <= "000"; Sbb <= IR(4 downto 0); Sbc <= "00001"; Sba <= IR(4 downto 0); Salu <= "00010"; LDF <= '1';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '0';
				
			when m32 => -- R = R - TMP
				Sa <= "00"; Sid <= "000"; Sbb <= IR(4 downto 0); Sbc <= "00001"; Sba <= IR(4 downto 0); Salu <= "00011"; LDF <= '1';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '0';
				
			when m33 => -- CMP(TMP, R)
				Sa <= "00"; Sid <= "000"; Sbb <= IR(4 downto 0); Sbc <= "00001"; Sba <= "00000"; Salu <= "00011"; LDF <= '1';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '0';
				
			when m34 => -- R = R and TMP
				Sa <= "00"; Sid <= "000"; Sbb <= IR(4 downto 0); Sbc <= "00001"; Sba <= IR(4 downto 0); Salu <= "00101"; LDF <= '1';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '0';
				
			when m35 => -- R = TMP or R
				Sa <= "00"; Sid <= "000"; Sbb <= IR(4 downto 0); Sbc <= "00001"; Sba <= IR(4 downto 0); Salu <= "00100"; LDF <= '1';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '0';
				
			when m36 => -- R = TMP xor R
				Sa <= "00"; Sid <= "000"; Sbb <= IR(4 downto 0); Sbc <= "00001"; Sba <= IR(4 downto 0); Salu <= "00110"; LDF <= '1';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '0';
			
			-- Group 011
			
			when m40 => -- Fetch ST16
				Sa <= "01"; Sid <= "001"; Sbb <= "00000"; Sbc <= "00000"; Sba <= "00000"; Salu <= "00000"; LDF <= '0';
				Smar <= '1'; Smbr <= '0'; WR <= '0'; RD <= '1'; INTout <= '0';
				
			when m41 => -- IR to PCl
				Sa <= "00"; Sid <= "000"; Sbb <= "00000"; Sbc <= "00000"; Sba <= "10101"; Salu <= "00000"; LDF <= '0';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '0';
				
			when others =>
				Sa <= "00"; Sid <= "000"; Sbb <= "00000"; Sbc <= "00000"; Sba <= "00000"; Salu <= "00000"; LDF <= '0';
				Smar <= '0'; Smbr <= '0'; WR <= '0'; RD <= '0'; INTout <= '0';
		end case;
	end process;
end rtl;
