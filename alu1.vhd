library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
--use ieee.std_logic_unsigned.all;

entity alu1 is 
	port (    
	A : in signed(2 downto 0); 
		B : in signed(2 downto 0); 
		Salu : in bit_vector (2 downto 0); 
		LDF : in bit; 
		Y : out signed(2 downto 0);
		--C (przeniesienie), Z (zero), S (znak), P(parzystość)
		C, Z, S, P : out std_logic
); 
end entity; 

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
use ieee.std_logic_unsigned.all;

architecture bhv of alu1 is 
	signal sum : std_logic_vector(3 downto 0);
begin 
	process (Salu, A, B) 
	
		variable AA : signed(2 downto 0);
		variable BB : signed (2 downto 0);
		variable tmp : signed (2 downto 0);
		
		variable ZF : std_logic; 
		variable SF : std_logic;
		variable CF : std_logic;
		variable PF : std_logic;
		
		
			
	begin 
		
		tmp := "000";
		
		
		AA(2 downto 0) := A; 
		
		
		
		BB(2 downto 0) := B; 
		
		CF := '0';
	
		case Salu is  
			when "000" => tmp := AA;
			when "001" => tmp := AA + BB;
			

			 sum <= std_logic_vector(('0' & AA) OR ('0' & BB));

				if( sum(3) = '1' ) then
					CF := '1';
				end if;
				
			when "010" => tmp := ('0' & AA) - (BB);
			
			   sum <=  std_logic_vector(('0' & AA) - ('0' & BB));
				if( sum(3) = '1' ) then
					CF := '1';
				end if;
				
			when "011" => tmp := AA;
			when "100" => tmp := AA;
			when "101" => tmp := AA;

			when others => null;
			
		end case; 
		
			
			
		
  
  if ( tmp = 0) then
		PF := '0';
	else
		PF := '1';
					-- zmienna lokalna
	  for J in tmp'range loop
		 PF := PF xor tmp(J);
	  end loop;
  end if;

  
	if (tmp = 0) then
		ZF := '1';
	else
		ZF := '0';
  end if;
  
	if (tmp(2) = '1') then
		SF := '1';
		else
		SF := '0';
  end if;

		Y <= tmp(2 downto 0); 
		P <= PF;		-- P (parzystość)
		C <= CF; -- C (przeniesienie)
		Z <= ZF; -- Z (zero)
		S <= SF; -- S (znak),
		
		
		
	end process; 
end bhv;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
	--use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
 
--HEX---------------------------------------------------
entity HEXs is
	port(Y: in std_logic_vector (15 downto 0);
	LDF: in bit;
	h0, h1, h2, h3, h4, h5, h6, h7: out std_logic_vector(6 downto 0)); --wyświetlacz siedmio segmentowy
end HEXs;
 
architecture hex_bhv of HEXs is
procedure dekoder(
	A : unsigned(6 downto 0);
	h: out std_logic_vector(6 downto 0)) is
	begin
		case A is
			when "0000000" => h := "1000000";
			when "0000001" => h := "1111001";
			when "0000010" => h := "0100100";
			when "0000011" => h := "0110000";
			when "0000100" => h := "0011001";
			when "0000101" => h := "0010010";
			when "0000110" => h := "0000011";
			when "0000111" => h := "1111000";
			when "0001000" => h := "0000000";
			when "0001001" => h := "0011000";
			when "0010000" => h := "1111111";
			when others => h := "0111111";
		end case;
	end dekoder;
begin
	process(Y)
	variable Hh0, Hh1, Hh2, Hh3, Hh4, Hh5, Hh6, Hh7: std_logic_vector(6 downto 0);
	variable tmpHex, reszta, kiedy: integer;
	variable potega: integer;
	variable str: std_logic_vector(15 downto 0);
	variable bb: boolean;
	begin
			if(LDF = '1') then
				--ustawienie wyświetlacza HEX
				if(Y(15) = '0') then
					bb := false;
					tmpHex:= to_integer(unsigned(Y));
				else
					str := "1000000000000000";
					tmpHex := to_integer(unsigned(str)) - to_integer(unsigned(Y(14 downto 0)));
					bb := true;
					--dekoder("1110000", Hh7);
				end if;
				kiedy := 0;
				for i in 7 downto 0 loop
					potega := 1;
					for j in 1 to 8 loop
						if(j > i) then 
						exit;
					end if;
					potega := potega * 10;
				end loop;
				reszta := tmpHex / potega;
				tmpHex := tmpHex mod potega;
				--zmienna kiedy wskazuje na którym segmencie wyświetlić znak "-"
				if(reszta >= 1 or kiedy > i) then --or kiedy > i
					if(kiedy = 0) then
						kiedy := i;
					end if;
					case i is
						when 0 => dekoder(to_unsigned(reszta, 7), Hh0);
						when 1 => dekoder(to_unsigned(reszta, 7), Hh1);
						when 2 => dekoder(to_unsigned(reszta, 7), Hh2);
						when 3 => dekoder(to_unsigned(reszta, 7), Hh3);
						when 4 => dekoder(to_unsigned(reszta, 7), Hh4);
						when 5 => dekoder(to_unsigned(reszta, 7), Hh5);
						when 6 => dekoder(to_unsigned(reszta, 7), Hh6);
						when 7 => dekoder(to_unsigned(reszta, 7), Hh7);
						when others => dekoder("1000000", Hh7);
					end case;
				else
					case i is
						when 0 => dekoder("0010000", Hh0);
						when 1 => dekoder("0010000", Hh1);
						when 2 => dekoder("0010000", Hh2);
						when 3 => dekoder("0010000", Hh3);
						when 4 => dekoder("0010000", Hh4);
						when 5 => dekoder("0010000", Hh5);
						when 6 => dekoder("0010000", Hh6);
						when 7 => dekoder("0010000", Hh7);
						when others => dekoder("1000000", Hh7);
					end case;
				end if;
			end loop;
			if(bb = true) then
				kiedy := kiedy + 1;
				case kiedy is
					when 0 => dekoder("1110000", Hh0);
					when 1 => dekoder("1110000", Hh1);
					when 2 => dekoder("1110000", Hh2);
					when 3 => dekoder("1110000", Hh3);
					when 4 => dekoder("1110000", Hh4);
					when 5 => dekoder("1110000", Hh5);
					when 6 => dekoder("1110000", Hh6);
					when 7 => dekoder("1110000", Hh7);
					when others => dekoder("1110000", Hh7);
				end case;
			end if;
			else
				Hh0 := "1111111";
				Hh1 := "1111111";
				Hh2 := "1111111";
				Hh3 := "1111111";
				Hh4 := "1111111";
				Hh5 := "1111111";
				Hh6 := "1111111";
				Hh7 := "1111111";
			end if;
		h0 <= Hh0;
		h1 <= Hh1;
		h2 <= Hh2;
		h3 <= Hh3;
		h4 <= Hh4;
		h5 <= Hh5;
		h6 <= Hh6;
		h7 <= Hh7;
	end process;
end hex_bhv;