library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity reg is
port(
	BA, DI : in std_logic_vector(15 downto 0);
	BB, BC, A : out std_logic_vector(15 downto 0);
	S_BB, S_BC, S_BA : in std_logic_vector(3 downto 0);
	S_ID, S_A : in std_logic_vector(2 downto 0)
);
end reg;

architecture behaviour of reg is 
	signal REG_IR, REG_TMP, REG_A, REG_B,REG_C, REG_D, REG_E, REG_F, REG_PC, REG_SP, REG_ATMP, REG_AD_H, REG_AD_L : std_logic_vector(15 downto 0);
	
	begin
	
					with S_BB select
				BB <=		DI when "0000",
							REG_IR when "0001",
							REG_TMP when "0010",
							REG_A when "0011",
							REG_B when "0100",
							REG_C when "0101",
							REG_D when "0110",
							REG_E when "0111",
							REG_F when "1000",
							REG_AD_H when "1001",
							REG_AD_L when "1010",
							REG_PC when "1011",
							REG_SP when "1100",
							REG_ATMP when "1101",
							"0000000000000000" when others;
							
			with S_BC select
				BC <=		DI when "0000",
							REG_IR when "0001",
							REG_TMP when "0010",
							REG_A when "0011",
							REG_B when "0100",
							REG_C when "0101",
							REG_D when "0110",
							REG_E when "0111",
							REG_F when "1000",
							REG_AD_H when "1001",
							REG_AD_L when "1010",
							REG_PC when "1011",
							REG_SP when "1100",
							REG_ATMP when "1101",
							"0000000000000000" when others;
							
			with S_A select
				A <=		REG_IR when "001",
							REG_TMP when "010",
							REG_AD_H when "011",
							REG_AD_L when "100",
							REG_PC when "101",
							REG_SP when "110",
							REG_ATMP when "111",
							"0000000000000000" when others;
	
		process(BA, DI, S_BB, S_BC, S_BA, S_A, S_ID) is
		variable tmp_one : std_logic_vector(15 downto 0) := "0000000000000001";
		
		begin
							
			case S_ID is
						when "000" =>

						when "001" =>
								REG_PC <= std_logic_vector(unsigned(REG_PC) + unsigned(tmp_one));

						when "010" =>
								REG_SP <= std_logic_vector(unsigned(REG_SP) + unsigned(tmp_one));

						when "011" =>
								REG_SP <= std_logic_vector(unsigned(REG_SP) - unsigned(tmp_one));

						when "100" =>
								REG_AD_L <= std_logic_vector(unsigned(REG_AD_L) + unsigned(tmp_one));

						when "101" =>
								REG_AD_L <= std_logic_vector(unsigned(REG_AD_L) - unsigned(tmp_one));

						when others =>

				end case;
				
				
			case S_BA is
						when "0000" =>
								REG_IR <= BA;

						when "0001" =>
								REG_TMP <= BA;

						when "0010" =>
								REG_A <= BA;

						when "0011" =>
								REG_B <= BA;

						when "0100" =>
								REG_C <= BA;

						when "0101" =>
								REG_D <= BA;
								
						when "0110" =>
								REG_E <= BA;
								
						when "0111" =>
								REG_F <= BA;
								
						when "1000" =>
								REG_AD_H <= (BA(15 downto 0) & "00000000");
								
						when "1001" =>
								REG_AD_L <= ( "00000000" & BA(7 downto 0));
								
						when "1010" =>
								REG_PC <= BA;
								
						when "1011" =>
								REG_SP <= BA;
						
						when "1100" =>
								REG_ATMP <= BA;


						when others =>

				end case;
				
			
		end process;
	
	end behaviour;