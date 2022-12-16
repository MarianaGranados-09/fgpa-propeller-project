library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity Propeller is
	port(
		CLK		: in std_logic;  -- Seï¿½al de reloj (Baudios).
		RST		: in std_logic;	 -- Reset.
		H 		: in std_logic;	 -- Habilitador. 
		BT1		: in std_logic;  -- TX: envia un 1. 
		BT2		: in std_logic;  -- TX: envia un 2. 
		BT3		: in std_logic;  -- TX: envia un 3. 
		SND		: in std_logic;	 -- TX: Botï¿½n enviar.
		Tx		: out std_logic -- PIN del transmisor.
	);
end entity Propeller;


architecture FSM of Propeller is
signal baud : std_logic;

begin	
	C1 : entity work.BaseDeTiempo generic map(5209,13)port map(CLK, RST, H, baud);
	C2 : entity work.Transmisor port map(baud, RST, BT1, BT2, BT3, SND, Tx);
End architecture FSM;
