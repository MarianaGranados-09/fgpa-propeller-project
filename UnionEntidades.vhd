library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity UnionEntidades is
	port(
		CLK		: in std_logic;  -- Señal de reloj (FPGA).
		ENCODER	: in std_logic;	 -- Señal del encoder.
		H 		: in std_logic;	 -- Habilitador. 
		RST		: in std_logic;  -- Reset. 
		Frequency	: out std_logic  -- Pin del medición.
	);
end entity UnionEntidades;



architecture FSM of UnionEntidades is
signal Segundos : std_logic;
signal Revoluciones : std_logic;
signal OSCILOSCOPIO : std_logic;
signal pulso1 : std_logic;
signal pulso2 : std_logic;

begin	
	
	C1 : entity work.BaseDeTiempoEncoder generic map(16,6)port map(ENCODER, RST, H, Revoluciones);
	C2 : entity work.BaseDeTiempo generic map(50000000,27)port map(CLK, RST, H, Segundos);
	C3 : entity work.Comparacion port map (Revoluciones, Segundos, RST, H, Frequency, pulso1, pulso2);
	C4 : entity work.BaseDeTiempoMod generic map(10000000 ,25)port map(CLK, RST, H, pulso1);
	C5 : entity work.BaseDeTiempoMod generic map(20000000 ,26)port map(CLK, RST, H, pulso2);
			
end architecture FSM;  

