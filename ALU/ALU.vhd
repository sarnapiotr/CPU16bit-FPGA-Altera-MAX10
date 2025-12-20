library ieee;
use ieee.std_logic_1164.all;

entity ALU is
port(
	clk : in std_logic;
	A : in std_logic_vector(15 downto 0);
	B : in std_logic_vector(15 downto 0);
	Salu : in std_logic_vector(4 downto 0);
	Sf : in std_logic;
	Y : out std_logic_vector(15 downto 0);
	C, Z, S, P : out std_logic
);
end ALU;

architecture rtl of ALU is
begin
	process(Salu, A, B, clk)
	
		variable res, AA, BB, CC : signed(16 downto 0);
		variable CF, ZF, SF, PF : std_logic;
		
		begin
			AA(16) := A(15);
			AA(15 downto 0) := A;
			BB(16) := B(15);
			BB(15 downto 0) := B;
			CC(0) := CF;
			CC(16 downto 1) := "0000000000000000";
			
			case Salu is
				when "00000" => res := AA;						 -- 0
				when "00001" => res := BB;						 -- 1
				when "00010" => res := AA + BB;				 -- 2
				when "00011" => res := AA - BB;				 -- 3
				when "00100" => res := AA or BB;				 -- 4
				when "00101" => res := AA and BB;			 -- 5
				when "00110" => res := AA xor BB;			 -- 6
				when "00111" => res := AA xnor BB;			 -- 7
				when "01000" => res := not AA;				 -- 8
				when "01001" => res := - AA;					 -- 9
				when "01010" => res := 0;						 -- 10
				when "01011" => res := AA + BB + CC;		 -- 11
				when "01100" => res := AA - BB - CC;		 -- 12
				when "01101" => res := AA + 1;				 -- 13
				when "01110" => res := shift_left(AA, 1);  -- 14
				when "01111" => res := shift_right(AA, 1); -- 15
				
				when "10000" => res 0;
				when "10001" => res 0;
				when "10010" => res 0;
				when "10011" => res 0;
	
	end process;
end rtl;