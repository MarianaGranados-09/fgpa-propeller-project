library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

Entity Comparacion is
	Port(
		ENCODER : in std_logic;	-- Pin del encoder.
		CLK		: in std_logic;	-- Reloj de la FPGA.
		RST : in std_logic;
		H : in std_logic;
		Frequency  : out std_logic;
		Pulso1  : in std_logic;
		Pulso2  : in std_logic
		);
end Comparacion;
Architecture Simple of Comparacion is
signal Qn, Qp : std_logic_vector(3 downto 0):= (others => '0');
signal Rn, Rp : std_logic_vector(6 downto 0):= (others => '0');
Begin
	
	Mux : Process(Qp) is
	Begin
		Case Qp is
			When "0000" => 
				Qn <= Qp + 1; -- Hace el cambio de estado en un segundo.
				Rn <= Rp + 1;	-- Va a aumentar 62 veces cuando pase un segundo. 
				
			When "0001" => 
				if Rn = "111110" then -- "111110" Representa 62 en binario.
					Frequency <= pulso2; -- Si las revolucines son 62, manda velocidad normal '0'.
				end if;
				
				if Rn < "111110" then --si Rn (las rev del motor) son menor a 62, entonces aumenta la freq.
					Frequency <= pulso1;  -- Si las revolucines son menores a 62, manda velocidad alta '1'.
				end if;
				
				if Rn > "111110" then -- "111110" Representa 62 en binario.
					Frequency <= pulso2; -- Si las revolucines son mayor a 62, manda velocidad normal '0'.
				end if;
			Qn <= Qp + 1;
			Rn <= Rp + 1;
					
			
			When others => 
			Qp <= (others => '0');
			Rp <= (others => '0');
		end case;
	end process Mux;
	
end architecture Simple;
		