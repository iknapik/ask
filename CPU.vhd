library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
use ieee.std_logic_unsigned.all;




entity CPU is 
port (
	X : in signed(2 downto 0)
);
begin
	
	


end entity; 




architecture bhv of CPU is 
	component alu1 is 
		port(
			A : in signed(2 downto 0); 
			B : in signed(2 downto 0); 
			Salu : in bit_vector (2 downto 0); 
			LDF : in bit; 
			Y : out signed(2 downto 0);
			--C (przeniesienie), Z (zero), S (znak), P(parzystość)
			C, Z, S, P : out std_logic
		);
	end component;
begin 
	
end bhv;