library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterFile is
port(
	clk : in std_logic;
	reset : in std_logic;
	DI : in std_logic_vector(15 downto 0);
	BA : in std_logic_vector(15 downto 0);
	Sa : in std_logic_vector(1 downto 0);
	Sid : in std_logic_vector(2 downto 0);
	Sbb : in std_logic_vector(4 downto 0);
	Sbc : in std_logic_vector(4 downto 0);
	Sba : in std_logic_vector(4 downto 0);
	BB : out std_logic_vector(15 downto 0);
	BC : out std_logic_vector(15 downto 0);
	A : out std_logic_vector(31 downto 0);
	IRout : out std_logic_vector(15 downto 0)
);
end RegisterFile;

architecture rtl of RegisterFile is
begin
	process(clk, reset, Sbb, Sbc, Sid, Sa, DI)
		variable IR, TMP, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16 : signed(15 downto 0) := X"0000";
		variable AD, PC : signed(31 downto 0) := X"00000000";
		variable SP : signed(31 downto 0) := X"000003FF";
		variable ATMP : signed(31 downto 0) := X"000000F7";
	begin
		if reset = '0' then
			IR := X"0000";
			TMP := X"0000";
			
			R1 := X"0000"; R2 := X"0000"; R3 := X"0000"; R4 := X"0000";
			R5 := X"0000"; R6 := X"0000"; R7 := X"0000"; R8 := X"0000";
			R9 := X"0000"; R10 := X"0000"; R11 := X"0000"; R12 := X"0000";
			R13 := X"0000"; R14 := X"0000"; R15 := X"0000"; R16 := X"0000";
		
			AD := X"00000000";
			PC := X"00000000";
			SP := X"000003FF";
			ATMP := X"000000F7";
			
		elsif rising_edge(clk) then
			case Sid is
				when "001" => PC := PC + 1;
				when "010" => SP := SP + 1;
				when "011" => SP := SP - 1;
				when "100" => AD := AD + 1;
				when "101" => AD := AD - 1;
				when others => null;
			end case;
			
			case Sba is
				when "00000" => IR := signed(BA);
				when "00001" => TMP := signed(BA);
				when "00010" => R1 := signed(BA);
				when "00011" => R2 := signed(BA);
				when "00100" => R3 := signed(BA);
				when "00101" => R4 := signed(BA);
				when "00110" => R5 := signed(BA);
				when "00111" => R6 := signed(BA);
				when "01000" => R7 := signed(BA);
				when "01001" => R8 := signed(BA);
				when "01010" => R9 := signed(BA);
				when "01011" => R10 := signed(BA);
				when "01100" => R11 := signed(BA);
				when "01101" => R12 := signed(BA);
				when "01110" => R13 := signed(BA);
				when "01111" => R14 := signed(BA);
				when "10000" => R15 := signed(BA);
				when "10001" => R16 := signed(BA);
				when "10010" => AD(31 downto 16) := signed(BA);
				when "10011" => AD(15 downto 0) := signed(BA);
				when "10100" => PC(31 downto 16) := signed(BA);
				when "10101" => PC(15 downto 0) := signed(BA);
				when "10110" => SP(31 downto 16) := signed(BA);
				when "10111" => SP(15 downto 0) := signed(BA);
				when "11000" => ATMP(31 downto 16) := signed(BA);
				when "11001" => ATMP(15 downto 0) := signed(BA);
				when others => null;
			end case;
		end if;
		
		case Sbb is
			when "00000" => BB <= DI;
			when "00001" => BB <= std_logic_vector(TMP);
			when "00010" => BB <= std_logic_vector(R1);
			when "00011" => BB <= std_logic_vector(R2);
			when "00100" => BB <= std_logic_vector(R3);
			when "00101" => BB <= std_logic_vector(R4);
			when "00110" => BB <= std_logic_vector(R5);
			when "00111" => BB <= std_logic_vector(R6);
			when "01000" => BB <= std_logic_vector(R7);
			when "01001" => BB <= std_logic_vector(R8);
			when "01010" => BB <= std_logic_vector(R9);
			when "01011" => BB <= std_logic_vector(R10);
			when "01100" => BB <= std_logic_vector(R11);
			when "01101" => BB <= std_logic_vector(R12);
			when "01110" => BB <= std_logic_vector(R13);
			when "01111" => BB <= std_logic_vector(R14);
			when "10000" => BB <= std_logic_vector(R15);
			when "10001" => BB <= std_logic_vector(R16);
			when "10010" => BB <= std_logic_vector(AD(31 downto 16));
			when "10011" => BB <= std_logic_vector(AD(15 downto 0));
			when "10100" => BB <= std_logic_vector(PC(31 downto 16));
			when "10101" => BB <= std_logic_vector(PC(15 downto 0));
			when "10110" => BB <= std_logic_vector(SP(31 downto 16));
			when "10111" => BB <= std_logic_vector(SP(15 downto 0));
			when "11000" => BB <= std_logic_vector(ATMP(31 downto 16));
			when "11001" => BB <= std_logic_vector(ATMP(15 downto 0));
			when others => null;
		end case;
		
		case Sbc is
			when "00000" => BC <= DI;
			when "00001" => BC <= std_logic_vector(TMP);
			when "00010" => BC <= std_logic_vector(R1);
			when "00011" => BC <= std_logic_vector(R2);
			when "00100" => BC <= std_logic_vector(R3);
			when "00101" => BC <= std_logic_vector(R4);
			when "00110" => BC <= std_logic_vector(R5);
			when "00111" => BC <= std_logic_vector(R6);
			when "01000" => BC <= std_logic_vector(R7);
			when "01001" => BC <= std_logic_vector(R8);
			when "01010" => BC <= std_logic_vector(R9);
			when "01011" => BC <= std_logic_vector(R10);
			when "01100" => BC <= std_logic_vector(R11);
			when "01101" => BC <= std_logic_vector(R12);
			when "01110" => BC <= std_logic_vector(R13);
			when "01111" => BC <= std_logic_vector(R14);
			when "10000" => BC <= std_logic_vector(R15);
			when "10001" => BC <= std_logic_vector(R16);
			when "10010" => BC <= std_logic_vector(AD(31 downto 16));
			when "10011" => BC <= std_logic_vector(AD(15 downto 0));
			when "10100" => BC <= std_logic_vector(PC(31 downto 16));
			when "10101" => BC <= std_logic_vector(PC(15 downto 0));
			when "10110" => BC <= std_logic_vector(SP(31 downto 16));
			when "10111" => BC <= std_logic_vector(SP(15 downto 0));
			when "11000" => BC <= std_logic_vector(ATMP(31 downto 16));
			when "11001" => BC <= std_logic_vector(ATMP(15 downto 0));
			when others => null;
		end case;
		
		case Sa is
			when "00" => A <= std_logic_vector(AD);
			when "01" => A <= std_logic_vector(PC);
			when "10" => A <= std_logic_vector(SP);
			when "11" => A <= std_logic_vector(ATMP);
			when others => null;
		end case;
		
		IRout <= std_logic_vector(IR);
	end process;
end rtl;