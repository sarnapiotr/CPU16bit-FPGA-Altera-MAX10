library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
port(
	clk : in std_logic;
	A : in std_logic_vector(15 downto 0);	-- BB
	B : in std_logic_vector(15 downto 0);	-- BC
	Salu : in std_logic_vector(4 downto 0);
	LDF : in std_logic;
	Y : out std_logic_vector(15 downto 0); -- BA
	C, Z, S : out std_logic
);
end ALU;

architecture rtl of ALU is
begin
	process(clk, A, B, Salu)
		variable res, AA, BB, CC : signed(16 downto 0);
		variable CF, ZF, SF : std_logic := '0';
	begin
		AA(16) := A(15);
		AA(15 downto 0) := signed(A);
		BB(16) := B(15);
		BB(15 downto 0) := signed(B);
		CC(0) := CF;
		CC(16 downto 1) := "0000000000000000";
		
		case Salu is
			when "00000" => res := AA;						  -- 0 Y = BB
			when "00001" => res := BB;						  -- 1 Y = BC
			when "00010" => res := AA + BB;				  -- 2 Y = BB + BC
			when "00011" => res := AA - BB;				  -- 3 Y = BB - BC
			when "00100" => res := AA or BB;				  -- 4 Y = BB or BC
			when "00101" => res := AA and BB;			  -- 5 Y = BB and BC
			when "00110" => res := AA xor BB;			  -- 6 Y = BB xor BC
			when "00111" => res := AA xnor BB;			  -- 7 Y = BB xnor BC
			when "01000" => res := not AA;				  -- 8 Y = not BB
			when "01001" => res := - AA;					  -- 9 Y = -BB
			when "01010" => res := "00000000000000000"; -- 10 Y = 0
			when "01011" => res := AA + BB + CC;		  -- 11 Y = BB + BC + C
			when "01100" => res := AA - BB - CC;		  -- 12 Y = BB - BC - C
			when "01101" => res := AA + 1;				  -- 13 Y = BB + 1
			when "01110" => res := shift_left(AA, 1);	  -- 14 Y = BB shl 1
			when "01111" => res := shift_right(AA, 1);  -- 15 Y = BB shr 1
			when "10000" => res := AA - 1;				  -- 16 Y = BB - 1
			when "10001" =>									  -- 17 min(BB, BC)
				if AA < BB then res := AA;					  
				else res := BB;
				end if;
			when "10010" => res := AA nor BB;			  -- 18 Y = BB nor BC
			when "10011" => res := AA nand BB;			  -- 19 Y = BB nand BC
			when others => res := "00000000000000000";
		end case;
		
		if rising_edge(clk) then
			if LDF = '1' then
				CF := res(16) xor res(15);
				
				if(res = "00000000000000000") then ZF := '1';
				else ZF := '0';
				end if;
				
				SF := res(15);
			end if;
		end if;
		
		Y <= std_logic_vector(res(15 downto 0));
		C <= CF;
		Z <= ZF;
		S <= SF;
	end process;
end rtl;