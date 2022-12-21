library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity DataOut is
port(
	BAUD	: in STD_LOGIC;		-- Baudios
	RST 	: in STD_LOGIC;		-- Reset maestro 
	BT1		: in STD_LOGIC;		-- Condicion para recibir mensaje.
	BT2		: in STD_LOGIC;
	BT3		: in STD_LOGIC;
	BT4		: in STD_LOGIC;
	BT5		: in STD_LOGIC;
	ENTER   : in STD_LOGIC;		-- Boton para enviar.
	E       : out STD_LOGIC;
	Tx		: out STD_LOGIC;		-- Entrada de secuencia.
	DAT		: out STD_LOGIC_VECTOR(7 downto 0);
	SET     : out std_logic_vector (1 downto 0);	-- Vector de configuracion.
	MOTOR	: out std_logic;
	LEDS	: out STD_LOGIC_VECTOR(7 downto 0):= "00000000" 
);		
end entity DataOut;								


architecture simple of DataOut is
signal Qp, Qn : std_logic_vector(5 downto 0) := (others => '0');
Signal Data1 : Std_logic_vector(7 downto 0) := "01000001"; -- Ascii 'A' : HEX 41.
Signal Data2 : Std_logic_vector(7 downto 0) := "01000010"; -- Ascii 'B' : HEX 42. 
Signal Data3 : Std_logic_vector(7 downto 0) := "01000011"; -- Ascii 'C' : HEX 43. 
signal Tx_s	: std_logic:='1';
signal start : std_logic:='0';
signal parity : std_logic:='0';
signal stop : std_logic:='1';
begin

	Tx <= Tx_s;
	
	secuencial: process	(Qp, ENTER, BT1, BT2, BT3, BT4, BT5) is
	begin
		If (BT1 = '1' AND BT2 = '0' AND BT3 = '0' AND BT4 = '0' AND ENTER = '0') then
		case Qp is
			when "000000"	=> 
				Tx_s <= '1';
				if(BT1 = '1') then
					Qn <= "000001";
				else
					Qn <= Qp;
				end if;
				
			when "000001"	=>	
				Tx_s <= start;
				Qn <= Qp + 1;
			
			when "000010"	=> 
				Tx_s <= Data1(0);
				Qn <= Qp + 1;

			when "000011"	=> 
				Tx_s <= Data1(1);
				Qn <= Qp + 1;
				
			when "000100"	=> 
				Tx_s <= Data1(2);
				Qn <= Qp + 1;
			
			when "000101"	=> 
				Tx_s <= Data1(3);
				Qn <= Qp + 1;
			
			when "000110"	=> 
				Tx_s <= Data1(4);
				Qn <= Qp + 1;
			
			when "000111"	=> 
				Tx_s <= Data1(5);
				Qn <= Qp + 1;
			
			when "001000"	=> 
				Tx_s <= Data1(6);
				Qn <= Qp + 1;
			
			when "001001"	=> 
				Tx_s <= Data1(7);
				Qn <= Qp + 1;
			
			when "001010"	=> 
				Tx_s <= parity;
				Qn <= Qp + 1;
			
			when "001011"	=> 
				Tx_s <= stop;
				Qn <= Qp + 1;
				LEDS <= "00000001"; --led testigo para saber si termino de enviar A
				
			-- Se termina de mandar A.	
			
			
			when "001100"	=>	-- Clear Display.
				DAT <= "00000001"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
				
			when "001101"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;

			when "001110"	=>	-- Ascii 'C' : HEX 43.
				DAT <= "01000011";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
				LEDS <= "00000010"; --segundo estado de leds para saber si se envia la c
				
			when "001111"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "010000"	=> 	-- Ascii 'O' : HEX 4F.
				DAT <= "01001111";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
				LEDS <= "00000011"; --tercer estado de leds para saber si se envia la o
			
			when "010001"	=>  -- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "010010"	=>  -- Ascii 'M' : HEX 4D.
				DAT <= "01001101";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
				LEDS <= "00000100"; --cuarto estado de leds para saber si se envia la m
			
			when "010011"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "010100"	=>	-- Ascii 'U' : HEX 55.
				DAT <= "01010101";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
				LEDS <= "00000101"; --quinto estado de leds para saber si se envia la u
				
			when "010101"	=> 
				E   <= '0';
				Qn <= Qp + 1;
			
			when "010110"	=>	-- Ascii 'N' : HEX 4E.
				DAT <= "01001110";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
				LEDS <= "00000110"; --sexto estado de leds para saber si se envia la n
			
			when "010111"	=> 
				E   <= '0';
				Qn <= Qp + 1;
				
			when "011000"	=>	-- Ascii 'I' : HEX 49.
				DAT <= "01001001";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
				LEDS <= "00000111"; --septimo estado de leds para saber si se envia la i

			when "011001"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "011010"	=>	-- Ascii 'C' : HEX 43.
				DAT <= "01000011";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
				LEDS <= "00001000"; --octavo estado de leds para saber si se envia la c
			
			when "011011"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "011100"	=>	-- Ascii 'A' : HEX 41. 
				DAT <= "01000001";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
				LEDS <= "00001001"; --noveno estado de leds para saber si se envia la a
			
			when "011101"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "011110"	=>	-- Ascii 'N' : HEX 4E.  
				DAT <= "01001110";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
				LEDS <= "00001010"; --decimo estado de leds para saber si se envia la n
			
			when "011111"	=>	-- OFF. 
				E   <= '0';
				Qn <= Qp + 1;
				
			when "100000"	=>	-- Ascii 'D' : HEX 44. 
				DAT <= "01000100";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
				LEDS <= "00001100"; --11 estado de leds para saber si se envia la d
			
			when "100001"	=> 
				E   <= '0';
				Qn <= Qp + 1;
				
			when "100010"	=>	-- Ascii 'O' : HEX 4F. 
				DAT <= "01001111";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
				LEDS <= "00001101"; --12 estado de leds para saber si se envia la o
			
			when "100011"	=> 
				E   <= '0';
				Qn <= Qp + 1;
				LEDS <= "00001111"; --13 estado de leds para termino de enviar palabra "comunicando"
				
			-- Se termina de mandar "COMUNICANDO".
			
			when others	=> 
				Tx_s <= '1';
				if (BT1 = '0') then
					Qn <= (others => '0');
				else
					Qn <= Qp;
				end if;
			end case; 
		end if;
		
		If (BT1 = '0' AND BT2 = '1' AND BT3 = '0' AND BT4 = '0' AND ENTER = '0') then
		case Qp is
			when "000000"	=> 
				Tx_s <= '1';
				if(BT2 = '1') then
					Qn <= "000001";
				else
					Qn <= Qp;
				end if;
				
			when "000001"	=>	
				Tx_s <= start;
				Qn <= Qp + 1;
			
			when "000010"	=> 
				Tx_s <= Data2(0);
				Qn <= Qp + 1;

			when "000011"	=> 
				Tx_s <= Data2(1);
				Qn <= Qp + 1;
				
			when "000100"	=> 
				Tx_s <= Data2(2);
				Qn <= Qp + 1;
			
			when "000101"	=> 
				Tx_s <= Data2(3);
				Qn <= Qp + 1;
			
			when "000110"	=> 
				Tx_s <= Data2(4);
				Qn <= Qp + 1;
			
			when "000111"	=> 
				Tx_s <= Data2(5);
				Qn <= Qp + 1;
			
			when "001000"	=> 
				Tx_s <= Data2(6);
				Qn <= Qp + 1;
			
			when "001001"	=> 
				Tx_s <= Data2(7);
				Qn <= Qp + 1;
			
			when "001010"	=> 
				Tx_s <= parity;
				Qn <= Qp + 1;
			
			when "001011"	=> 
				Tx_s <= stop;
				Qn <= Qp + 1;  
				
			-- Se termina de mandar '2'.	
			
			
			when "001100"	=>	-- Clear Display.
				DAT <= "00000001"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
				
			when "001101"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;

			when "001110"	=>	-- Ascii 'C' : HEX 43.
				DAT <= "01000011";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
				
			when "001111"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "010000"	=> 	-- Ascii 'O' : HEX 4F.
				DAT <= "01001111";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "010001"	=>  -- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "010010"	=>  -- Ascii 'M' : HEX 4D.
				DAT <= "01001101";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "010011"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "010100"	=>	-- Ascii 'U' : HEX 55.
				DAT <= "01010101";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
				
			when "010101"	=> 
				E   <= '0';
				Qn <= Qp + 1;
			
			when "010110"	=>	-- Ascii 'N' : HEX 4E.
				DAT <= "01001110";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "010111"	=> 
				E   <= '0';
				Qn <= Qp + 1;
				
			when "011000"	=>	-- Ascii 'I' : HEX 49.
				DAT <= "01001001";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;

			when "011001"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "011010"	=>	-- Ascii 'C' : HEX 43.
				DAT <= "01000011";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "011011"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "011100"	=>	-- Ascii 'A' : HEX 41. 
				DAT <= "01000001";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "011101"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "011110"	=>	-- Ascii 'N' : HEX 4E.  
				DAT <= "01001110";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "011111"	=>	-- OFF. 
				E   <= '0';
				Qn <= Qp + 1;
				
			when "100000"	=>	-- Ascii 'D' : HEX 44. 
				DAT <= "01000100";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "100001"	=> 
				E   <= '0';
				Qn <= Qp + 1;
				
			when "100010"	=>	-- Ascii 'O' : HEX 4F. 
				DAT <= "01001111";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "100011"	=> 
				E   <= '0';
				Qn <= Qp + 1;
				
			-- Se termina de mandar "COMUNICANDO".
			
			when others	=> 
				Tx_s <= '1';
				if (BT2 = '0') then
					Qn <= (others => '0');
				else
					Qn <= Qp;
				end if;
			end case; 
		end if;
		
		If (BT1 = '0' AND BT2 = '0' AND BT3 = '1' AND BT4 = '0' AND ENTER = '0') then
		case Qp is
			when "000000"	=> 
				Tx_s <= '1';
				if(BT3 = '1') then
					Qn <= "000001";
				else
					Qn <= Qp;
				end if;
				
			when "000001"	=>	
				Tx_s <= start;
				Qn <= Qp + 1;
			
			when "000010"	=> 
				Tx_s <= Data3(0);
				Qn <= Qp + 1;

			when "000011"	=> 
				Tx_s <= Data3(1);
				Qn <= Qp + 1;
				
			when "000100"	=> 
				Tx_s <= Data3(2);
				Qn <= Qp + 1;
			
			when "000101"	=> 
				Tx_s <= Data3(3);
				Qn <= Qp + 1;
			
			when "000110"	=> 
				Tx_s <= Data3(4);
				Qn <= Qp + 1;
			
			when "000111"	=> 
				Tx_s <= Data3(5);
				Qn <= Qp + 1;
			
			when "001000"	=> 
				Tx_s <= Data3(6);
				Qn <= Qp + 1;
			
			when "001001"	=> 
				Tx_s <= Data3(7);
				Qn <= Qp + 1;
			
			when "001010"	=> 
				Tx_s <= parity;
				Qn <= Qp + 1;
			
			when "001011"	=> 
				Tx_s <= stop;
				Qn <= Qp + 1;  
				
			-- Se termina de mandar '3'.	
			
			
			when "001100"	=>	-- Clear Display.
				DAT <= "00000001"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
				
			when "001101"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;

			when "001110"	=>	-- Ascii 'C' : HEX 43.
				DAT <= "01000011";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
				
			when "001111"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "010000"	=> 	-- Ascii 'O' : HEX 4F.
				DAT <= "01001111";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "010001"	=>  -- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "010010"	=>  -- Ascii 'M' : HEX 4D.
				DAT <= "01001101";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "010011"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "010100"	=>	-- Ascii 'U' : HEX 55.
				DAT <= "01010101";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
				
			when "010101"	=> 
				E   <= '0';
				Qn <= Qp + 1;
			
			when "010110"	=>	-- Ascii 'N' : HEX 4E.
				DAT <= "01001110";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "010111"	=> 
				E   <= '0';
				Qn <= Qp + 1;
				
			when "011000"	=>	-- Ascii 'I' : HEX 49.
				DAT <= "01001001";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;

			when "011001"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "011010"	=>	-- Ascii 'C' : HEX 43.
				DAT <= "01000011";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "011011"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "011100"	=>	-- Ascii 'A' : HEX 41. 
				DAT <= "01000001";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "011101"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "011110"	=>	-- Ascii 'N' : HEX 4E.  
				DAT <= "01001110";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "011111"	=>	-- OFF. 
				E   <= '0';
				Qn <= Qp + 1;
				
			when "100000"	=>	-- Ascii 'D' : HEX 44. 
				DAT <= "01000100";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "100001"	=> 
				E   <= '0';
				Qn <= Qp + 1;
				
			when "100010"	=>	-- Ascii 'O' : HEX 4F. 
				DAT <= "01001111";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "100011"	=> 
				E   <= '0';
				Qn <= Qp + 1;
				
			-- Se termina de mandar "COMUNICANDO".
			
			when others	=> 
				Tx_s <= '1';
				if (BT3 = '0') then
					Qn <= (others => '0');
				else
					Qn <= Qp;
				end if;
			end case; 
		end if;
		
		If (BT4 = '1' AND ENTER = '0') then	-- Encendido del motor.
		case Qp is
			when "000000"	=> 
				if(BT4 = '1') then
					Qn <= "000001";
				else
					Qn <= Qp;
				end if;
				
			when "000001"	=>	
				MOTOR <= '1';
				Qn <= Qp + 1;
			
			when "000010"	=>	-- Clear Display. 
				DAT <= "00000001"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;

			when "000011"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "000100"	=>	-- Ascii 'O' : HEX 4F.
				DAT <= "01001111";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "000101"	=>	-- OFF. 
				E   <= '0';
				Qn <= Qp + 1;
			
			when "000110"	=>	-- Ascii 'P' : HEX 50. 
				DAT <= "01010000";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "000111"	=>	-- OFF. 
				E   <= '0';
				Qn <= Qp + 1;
			
			when "001000"	=>	-- Ascii 'E' : HEX 45. 
				DAT <= "01000101";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "001001"	=>	-- OFF. 
				E   <= '0';
				Qn <= Qp + 1;
			
			when "001010"	=>	-- Ascii 'R' : HEX 52. 
				DAT <= "01010010";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "001011"	=>	-- OFF. 
				E   <= '0';
				Qn <= Qp + 1;  
			
			when "001100"	=>	-- Ascii 'A' : HEX 41.
				DAT <= "01000001";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
				
			when "001101"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;

			when "001110"	=>	-- Ascii 'N' : HEX 4E.
				DAT <= "01001110";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
				
			when "001111"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "010000"	=> 	-- Ascii 'D' : HEX 44.
				DAT <= "01000100";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "010001"	=>  -- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "010010"	=>  -- Ascii 'O' : HEX 4F.
				DAT <= "01001111";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "010011"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			-- Se termina de mandar "OPERANDO".
			
			when others	=> 
				if (BT4 = '1') then
					Qn <= (others => '0');
				else
					Qn <= Qp;
				end if;
				
			end case;	
		end if;	
		
		If (BT5 = '1' AND ENTER = '0') then	-- Inicialización y clear display.
		case Qp is
			when "000000"	=> 
				if(BT5 = '1') then
					Qn <= "000001";
				else
					Qn <= Qp;
				end if;
				
			when "000001"	=>	-- Configuración.	
				DAT <= "00111000";	 
				E <= '1';
				SET <= "00"; 
				Qn <= Qp + 1;
				
			
			when "000010"	=>	-- OFF.
				E <= '0';
				Qn <= Qp + 1;

			when "000011"	=>	-- Encender LCD. 
				DAT <= "00001110";	 
				E <= '1';			 
				SET <= "00";			
				Qn <= Qp + 1;
				
			when "000100"	=>	-- OFF.
				E <= '0';
				Qn <= Qp + 1;
			
			when "000101"	=>	-- Clear Display. 
				DAT <= "00000001"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "000110"	=>	-- OFF. 
				E <= '0';
				Qn <= Qp + 1;
				
			-- Se termino de configurar la LCD.
			
			when others	=> 
				if (BT5 = '0') then
					Qn <= (others => '0');
				else
					Qn <= Qp;
				end if;
			end case; 
		end if;
		
		If (BT1 = '0' AND BT2 = '0' AND BT3 = '0' AND BT4 = '0' AND BT5 = '0' AND ENTER = '1') then
		case Qp is
			when "000000"	=> 
				if(BT1 = '1') then
					Qn <= "000001";
				else
					Qn <= Qp;
				end if;
				
			when "000001"	=>	
				MOTOR <= '0';
				Qn <= Qp + 1;
			
			when "000010"	=>	-- Clear Display. 
				DAT <= "00000001"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;

			when "000011"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "000100"	=>	-- Ascii 'E' : HEX 45. 
				DAT <= "01000101";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "000101"	=>	-- OFF. 
				E   <= '0';
				Qn <= Qp + 1;
			
			when "000110"	=>	-- Ascii 'S' : HEX 53. 
				DAT <= "01010011";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "000111"	=>	-- OFF. 
				E   <= '0';
				Qn <= Qp + 1;
			
			when "001000"	=>	-- Ascii 'P' : HEX 50. 
				DAT <= "01010000";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "001001"	=>	-- OFF. 
				E   <= '0';
				Qn <= Qp + 1;
			
			when "001010"	=>	-- Ascii 'E' : HEX 45. 
				DAT <= "01000101";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "001011"	=>	-- OFF. 
				E   <= '0';
				Qn <= Qp + 1;  
			
			when "001100"	=>	-- Ascii 'R' : HEX 52. 
				DAT <= "01010010";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
				
			when "001101"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;

			when "001110"	=>	-- Ascii 'A' : HEX 41.
				DAT <= "01000001";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
				
			when "001111"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "010000"	=>	-- Ascii 'N' : HEX 4E.
				DAT <= "01001110";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "010001"	=>  -- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "010010"	=>	-- Ascii 'D' : HEX 44.
				DAT <= "01000100";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "010011"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1; 
				
			when "010100"	=>  -- Ascii 'O' : HEX 4F.
				DAT <= "01001111";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "010101"	=> 	-- OFF.
				E   <= '0';
				MOTOR <= '0';
				Qn <= Qp + 1;
				
			-- Se termina de mandar "ESPERANDO".
			
			when others	=> 
				if (BT1 = '0' AND BT2 = '0' AND BT3 = '0' AND BT4 = '0' AND BT5 = '0') then
					Qn <= (others => '0');
				else
					Qn <= Qp;
				end if;
			end case; 
		end if;	
		
		
		
		
	end process secuencial;

	
	FF: process(RST, BAUD) is
	begin		   
		if RST = '0' then
			Qp <= (others=>'0');
		elsif  BAUD'event and BAUD = '1' then
			Qp <= Qn;
		end if;
	end process FF;
	
	
end architecture simple;
