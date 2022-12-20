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
	MOTOR	: out std_logic
);		
end entity DataOut;								


architecture simple of DataOut is
signal Qp, Qn : std_logic_vector(6 downto 0) := (others => '0');
Signal Data1 : Std_logic_vector(7 downto 0) := "01000001"; -- Ascii 'A' : HEX 41.
Signal Data2 : Std_logic_vector(7 downto 0) := "01000010"; -- Ascii 'B' : HEX 42. 
Signal Data3 : Std_logic_vector(7 downto 0) := "01000011"; -- Ascii 'C' : HEX 43. 
signal Tx_s	: std_logic:='1';
signal start : std_logic:='0';
signal parity : std_logic:='1';
signal stop : std_logic:='1';
begin

	Tx <= Tx_s;
	
	secuencial: process	(Qp, ENTER, BT1, BT2, BT3, BT4, BT5) is
	begin
		If (BT1 = '1' AND BT2 = '0' AND BT3 = '0' AND BT4 = '0' AND ENTER = '0') then
		case Qp is
			when "0000000"	=> 
				Tx_s <= '1';
				if(BT1 = '1') then
					Qn <= "0000001";
					DAT <= "00000001";	-- Clear. 
					E <= '1'; 
					SET <= "00";
				else
					Qn <= Qp;
				end if;
				
			when "0000001"	=>	
				Tx_s <= start;
				E <= '0';
				Qn <= Qp + 1;
			
			when "0000010"	=> 
				Tx_s <= Data1(0);
				Qn <= Qp + 1;

			when "0000011"	=> 
				Tx_s <= Data1(1);
				Qn <= Qp + 1;
				
			when "0000100"	=> 
				Tx_s <= Data1(2);
				Qn <= Qp + 1;
			
			when "0000101"	=> 
				Tx_s <= Data1(3);
				Qn <= Qp + 1;
			
			when "0000110"	=> 
				Tx_s <= Data1(4);
				Qn <= Qp + 1;
			
			when "0000111"	=> 
				Tx_s <= Data1(5);
				Qn <= Qp + 1;
			
			when "0001000"	=> 
				Tx_s <= Data1(6);
				Qn <= Qp + 1;
			
			when "0001001"	=> 
				Tx_s <= Data1(7);
				Qn <= Qp + 1;
			
			when "0001010"	=> 
				Tx_s <= parity;
				Qn <= Qp + 1;
			
			when "0001011"	=> 
				Tx_s <= stop;
				Qn <= Qp + 1;  
				
			-- Se termina de mandar 1.	
			
			
			when "0001100"	=>	--	Posición 80H.
				DAT <= "10000000"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
								
			when "0001101"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;

			when "0001110"	=>	-- Ascii 'D' : HEX 44. 
				DAT <= "01000100";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
				
			when "0001111"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0010000"	=>	--	Posición 81H.
				DAT <= "10000001"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
				
			when "0010001"	=>  -- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0010010"	=>	-- Ascii 'A' : HEX 41. 
				DAT <= "01000001";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "0010011"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0010100"	=>	--	Posición 82H.
				DAT <= "10000010"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1; 
				
			when "0010101"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0010110"	=>	-- Ascii 'T' : HEX 54.  
				DAT <= "10000100";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;				
			
			when "0010111"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0011000"	=>	--	Posición 83H.
				DAT <= "10000011"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;

			when "0011001"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0011010"	=>	-- Ascii 'A' : HEX 41. 
				DAT <= "01000001";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "0011011"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0011100"	=>	-- Posición 84H.	 
				DAT <= "10000100"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0011101"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0011110"	=>	-- Ascii 'O' : HEX 4F.   
				DAT <= "01001111";
				E <= '1';	
				SET <= "01";	  	
				Qn <= Qp + 1;
			
			when "0011111"	=>	-- OFF. 
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0100000"	=>	-- Posición 85H.
				DAT <= "10000101"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0100001"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0100010"	=>	-- Ascii 'U' : HEX 55.
				DAT <= "01010101";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "0100011"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1; 
				
			when "0100100"	=>	-- Posición 86H.
				DAT <= "10000110"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0100101"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0100110"	=>	-- Ascii 'T' : HEX 54.
				DAT <= "10000100";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "0100111"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			-- Se termina de mandar "DATAOUT".
			
			when "0101000"	=>	-- Posición C0H.
				DAT <= "11000000"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0101001"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0101010"	=>	-- Ascii 'C' : HEX 43.
				DAT <= "01000011";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "0101011"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0101100"	=>	-- Posición C1H.
				DAT <= "11000001"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0101101"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0101110"	=>	-- Ascii 'O' : HEX 4F.
				DAT <= "01001111";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "0101111"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0110000"	=>	-- Posición C2H.
				DAT <= "11000010"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0110001"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0110010"	=>	-- Ascii 'M' : HEX 4D.
				DAT <= "01001101";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "0110011"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0110100"	=>	-- Movimiento del display.
				DAT <= "00011100"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
				
			when "0110101"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when others	=> 
				Tx_s <= '1';
				if (BT1 = '0') then
					Qn <= (others => '0');
				else
					Qn <= "0110100";
				end if;
			end case; 
		end if;
		
		If (BT1 = '0' AND BT2 = '1' AND BT3 = '0' AND BT4 = '0' AND ENTER = '0') then
		case Qp is
			when "0000000"	=> 
				Tx_s <= '1';
				if(BT2 = '1') then
					Qn <= "0000001";
					DAT <= "00000001";	-- Clear. 
					E <= '1'; 
					SET <= "00";
				else
					Qn <= Qp;
				end if;
				
			when "0000001"	=>	
				Tx_s <= start;
				E <= '1'; 
				Qn <= Qp + 1;
			
			when "0000010"	=> 
				Tx_s <= Data2(0);
				Qn <= Qp + 1;

			when "0000011"	=> 
				Tx_s <= Data2(1);
				Qn <= Qp + 1;
				
			when "0000100"	=> 
				Tx_s <= Data2(2);
				Qn <= Qp + 1;
			
			when "0000101"	=> 
				Tx_s <= Data2(3);
				Qn <= Qp + 1;
			
			when "0000110"	=> 
				Tx_s <= Data2(4);
				Qn <= Qp + 1;
			
			when "0000111"	=> 
				Tx_s <= Data2(5);
				Qn <= Qp + 1;
			
			when "0001000"	=> 
				Tx_s <= Data2(6);
				Qn <= Qp + 1;
			
			when "0001001"	=> 
				Tx_s <= Data2(7);
				Qn <= Qp + 1;
			
			when "0001010"	=> 
				Tx_s <= parity;
				Qn <= Qp + 1;
			
			when "0001011"	=> 
				Tx_s <= stop;
				Qn <= Qp + 1;  
				
			-- Se termina de mandar 1.	
			
			
			when "0001100"	=>	--	Posición 80H.
				DAT <= "10000000"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
								
			when "0001101"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;

			when "0001110"	=>	-- Ascii 'D' : HEX 44. 
				DAT <= "01000100";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
				
			when "0001111"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0010000"	=>	--	Posición 81H.
				DAT <= "10000001"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
				
			when "0010001"	=>  -- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0010010"	=>	-- Ascii 'A' : HEX 41. 
				DAT <= "01000001";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "0010011"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0010100"	=>	--	Posición 82H.
				DAT <= "10000010"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1; 
				
			when "0010101"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0010110"	=>	-- Ascii 'T' : HEX 54.  
				DAT <= "10000100";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;				
			
			when "0010111"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0011000"	=>	--	Posición 83H.
				DAT <= "10000011"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;

			when "0011001"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0011010"	=>	-- Ascii 'A' : HEX 41. 
				DAT <= "01000001";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "0011011"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0011100"	=>	-- Posición 84H.	 
				DAT <= "10000100"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0011101"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0011110"	=>	-- Ascii 'O' : HEX 4F.   
				DAT <= "01001111";
				E <= '1';	
				SET <= "01";	  	
				Qn <= Qp + 1;
			
			when "0011111"	=>	-- OFF. 
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0100000"	=>	-- Posición 85H.
				DAT <= "10000101"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0100001"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0100010"	=>	-- Ascii 'U' : HEX 55.
				DAT <= "01010101";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "0100011"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1; 
				
			when "0100100"	=>	-- Posición 86H.
				DAT <= "10000110"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0100101"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0100110"	=>	-- Ascii 'T' : HEX 54.
				DAT <= "10000100";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "0100111"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			-- Se termina de mandar "DATAOUT".
			
			when "0101000"	=>	-- Posición C0H.
				DAT <= "11000000"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0101001"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0101010"	=>	-- Ascii 'S' : HEX 53.
				DAT <= "01010011";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "0101011"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0101100"	=>	-- Posición C1H.
				DAT <= "11000001"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0101101"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0101110"	=>	-- Ascii 'E' : HEX 45.
				DAT <= "01000101";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "0101111"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0110000"	=>	-- Posición C2H.
				DAT <= "11000010"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0110001"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0110010"	=>	-- Ascii 'R' : HEX 52.
				DAT <= "01010010";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "0110011"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0110100"	=>	-- Posición C3H.
				DAT <= "11000011"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0110101"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0110110"	=>	-- Ascii 'I' : HEX 49.
				DAT <= "01001001";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "0110111"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0111000"	=>	-- Posición C4H.
				DAT <= "11000100"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0111001"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0111010"	=>	-- Ascii 'A' : HEX 41.
				DAT <= "01000001";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "0111011"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0111100"	=>	-- Posición C5H.
				DAT <= "11000101"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0111101"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0111110"	=>	-- Ascii 'L' : HEX 4C.
				DAT <= "01001100";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "0111111"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "1000000"	=>	-- Movimiento del display.
				DAT <= "00011100"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
				
			when "1000001"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when others	=> 
				Tx_s <= '1';
				if (BT2 = '0') then
					Qn <= (others => '0');
				else
					Qn <= "1000000";
				end if;
			end case;  
		end if;
		
		If (BT1 = '0' AND BT2 = '0' AND BT3 = '1' AND BT4 = '0' AND ENTER = '0') then
		case Qp is
			when "0000000"	=> 
				Tx_s <= '1';
				if(BT3 = '1') then
					Qn <= "0000001";
					DAT <= "00000001";	-- Clear. 
					E <= '1'; 
					SET <= "00";
				else
					Qn <= Qp;
				end if;
				
			when "0000001"	=>	
				Tx_s <= start;
				E <= '0'; 
				Qn <= Qp + 1;
			
			when "0000010"	=> 
				Tx_s <= Data3(0);
				Qn <= Qp + 1;

			when "0000011"	=> 
				Tx_s <= Data3(1);
				Qn <= Qp + 1;
				
			when "0000100"	=> 
				Tx_s <= Data3(2);
				Qn <= Qp + 1;
			
			when "0000101"	=> 
				Tx_s <= Data3(3);
				Qn <= Qp + 1;
			
			when "0000110"	=> 
				Tx_s <= Data3(4);
				Qn <= Qp + 1;
			
			when "0000111"	=> 
				Tx_s <= Data3(5);
				Qn <= Qp + 1;
			
			when "0001000"	=> 
				Tx_s <= Data3(6);
				Qn <= Qp + 1;
			
			when "0001001"	=> 
				Tx_s <= Data3(7);
				Qn <= Qp + 1;
			
			when "0001010"	=> 
				Tx_s <= parity;
				Qn <= Qp + 1;
			
			when "0001011"	=> 
				Tx_s <= stop;
				Qn <= Qp + 1;  
				
			-- Se termina de mandar 1.	
			
			
			when "0001100"	=>	--	Posición 80H.
				DAT <= "10000000"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
								
			when "0001101"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;

			when "0001110"	=>	-- Ascii 'D' : HEX 44. 
				DAT <= "01000100";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
				
			when "0001111"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0010000"	=>	--	Posición 81H.
				DAT <= "10000001"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
				
			when "0010001"	=>  -- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0010010"	=>	-- Ascii 'A' : HEX 41. 
				DAT <= "01000001";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "0010011"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0010100"	=>	--	Posición 82H.
				DAT <= "10000010"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1; 
				
			when "0010101"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0010110"	=>	-- Ascii 'T' : HEX 54.  
				DAT <= "10000100";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;				
			
			when "0010111"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0011000"	=>	--	Posición 83H.
				DAT <= "10000011"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;

			when "0011001"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0011010"	=>	-- Ascii 'A' : HEX 41. 
				DAT <= "01000001";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "0011011"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0011100"	=>	-- Posición 84H.	 
				DAT <= "10000100"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0011101"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0011110"	=>	-- Ascii 'O' : HEX 4F.   
				DAT <= "01001111";
				E <= '1';	
				SET <= "01";	  	
				Qn <= Qp + 1;
			
			when "0011111"	=>	-- OFF. 
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0100000"	=>	-- Posición 85H.
				DAT <= "10000101"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0100001"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0100010"	=>	-- Ascii 'U' : HEX 55.
				DAT <= "01010101";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "0100011"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1; 
				
			when "0100100"	=>	-- Posición 86H.
				DAT <= "10000110"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0100101"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0100110"	=>	-- Ascii 'T' : HEX 54.
				DAT <= "10000100";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "0100111"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			-- Se termina de mandar "DATAOUT".
			
			when "0101000"	=>	-- Posición C0H.
				DAT <= "11000000"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0101001"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0101010"	=>	-- Ascii 'M' : HEX 4D.
				DAT <= "01001101";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "0101011"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0101100"	=>	-- Posición C1H.
				DAT <= "11000001"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0101101"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0101110"	=>	-- Ascii 'G' : HEX 47.
				DAT <= "01000111";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "0101111"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0110000"	=>	-- Posición C2H.
				DAT <= "11000010"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0110001"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0110010"	=>	-- Ascii 'X' : HEX 58.
				DAT <= "01011000";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "0110011"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0110100"	=>	-- Posición C3H.
				DAT <= "11000011"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0110101"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0110110"	=>	-- Ascii 'M' : HEX 4D.
				DAT <= "01001101";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "0110111"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0111000"	=>	-- Posición C4H.
				DAT <= "11000100"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0111001"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0111010"	=>	-- Ascii 'V' : HEX 56.
				DAT <= "01010110";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "0111011"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
				
			when "0111100"	=>	-- Movimiento del display.
				DAT <= "00011100"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
				
			when "0111101"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when others	=> 
				Tx_s <= '1';
				if (BT3 = '0') then
					Qn <= (others => '0');
				else
					Qn <= "0111100";
				end if;
			end case;  
		end if;
		
		If (BT4 = '1' AND ENTER = '0') then	-- Encendido del motor.
		case Qp is
			when "0000000"	=> 
				if(BT4 = '1') then
					Qn <= "0000001";
					DAT <= "00000001";	-- Clear. 
					E <= '1'; 
					SET <= "00";
				else
					Qn <= Qp;
				end if;
				
			when "0000001"	=>	
				MOTOR <= '1';
				E <= '0'; 
				Qn <= Qp + 1;
			
			when "0000010"	=>	--	Posición 80H. 
				DAT <= "10000000"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;

			when "0000011"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0000100"	=>	-- Ascii 'R' : HEX 52.
				DAT <= "01010010";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "0000101"	=>	-- OFF. 
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0000110"	=>	--	Posición 81H. 
				DAT <= "10000001"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0000111"	=>	-- OFF. 
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0001000"	=>	-- Ascii 'U' : HEX 55. 
				DAT <= "01010101";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1; 
			
			when "0001001"	=>	-- OFF. 
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0001010"	=>	--	Posición 82H. 
				DAT <= "10000010"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1; 
			
			when "0001011"	=>	-- OFF. 
				E   <= '0';
				Qn <= Qp + 1;  
			
			when "0001100"	=>	-- Ascii 'N' : HEX 4E.
				DAT <= "01001110";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
				
			when "0001101"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;

				
			-- Se termina de mandar "RUN".
			
			when others	=> 
				if (BT4 = '0') then
					Qn <= (others => '0');
				else
					Qn <= Qp;
				end if;
				
			end case;	
		end if;	
		
		If (BT5 = '1' AND ENTER = '0') then	-- Inicialización y clear display.
		case Qp is
			when "0000000"	=> 
				if(BT5 = '1') then
					Qn <= "0000001";
				else
					Qn <= Qp;
				end if;
				
			when "0000001"	=>	-- Configuración.	
				DAT <= "00111000";	 
				E <= '1';
				SET <= "00"; 
				Qn <= Qp + 1;
				
			
			when "0000010"	=>	-- OFF.
				E <= '0';
				Qn <= Qp + 1;

			when "0000011"	=>	-- Encender LCD. 
				DAT <= "00001110";	 
				E <= '1';			 
				SET <= "00";			
				Qn <= Qp + 1;
				
			when "0000100"	=>	-- OFF.
				E <= '0';
				Qn <= Qp + 1;
			
			when "0000101"	=>	-- Dato fijo.
				DAT <= "00000100"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0000110"	=>	-- OFF. 
				E <= '0';
				Qn <= Qp + 1;
				
			when "0000111"	=>	-- Clear.
				DAT <= "00000001"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0001000"	=>	-- OFF. 
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
			when "0000000"	=> 
				if(BT1 = '0' AND BT2 = '0' AND BT3 = '0' AND BT4 = '0' AND BT5 = '0' AND ENTER = '1') then
					Qn <= "0000001";
					DAT <= "00000001";	-- Clear. 
					E <= '1'; 
					SET <= "00";
				else
					Qn <= Qp;
				end if;
				
			when "0000001"	=>	
				MOTOR <= '0';
				E <= '0';
				Qn <= Qp + 1;
			
			when "0000010"	=>	--	Posición 80H.
				DAT <= "10000000"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;

			when "0000011"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			when "0000100"	=>	-- Ascii 'W' : HEX 57. 
				DAT <= "01010111";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "0000101"	=>	-- OFF. 
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0000110"	=>	--	Posición 81H.
				DAT <= "10000001"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0000111"	=>	-- OFF. 
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0001000"	=>	-- Ascii 'A' : HEX 41. 
				DAT <= "01000001";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "0001001"	=>	-- OFF. 
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0001010"	=>	--	Posición 82H. 
				DAT <= "10000010"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1;
			
			when "0001011"	=>	-- OFF. 
				E   <= '0';
				Qn <= Qp + 1;  
			
			when "0001100"	=>	-- Ascii 'I' : HEX 49. 
				DAT <= "01001001";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
				
			when "0001101"	=>	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;

			when "0001110"	=>	--	Posición 83H.
				DAT <= "10000011"; 
				E <= '1'; 
				SET <= "00";
				Qn <= Qp + 1; 
				
			when "0001111"	=> 	-- OFF.
				E   <= '0';
				Qn <= Qp + 1;
			
			when "0010000"	=>	-- Ascii 'T' : HEX 54.  
				DAT <= "10000100";
				E <= '1';	
				SET <= "01";		
				Qn <= Qp + 1;
			
			when "0010001"	=>  -- OFF.
				E   <= '0';
				Qn <= Qp + 1;
				
			-- Se termina de mandar "WAIT".
			
			when others	=> 
				if (BT1 = '0' AND BT2 = '0' AND BT3 = '0' AND BT4 = '0' AND BT5 = '0' AND ENTER = '1') then
					Qn <= Qp;
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
