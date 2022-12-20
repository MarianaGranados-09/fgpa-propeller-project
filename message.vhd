library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity Transmisor is
port(
	BAUD : in STD_LOGIC;		-- Baudios
	RST  : in STD_LOGIC;		-- Reset maestro
	BT1	 : in STD_LOGIC;		-- Manda un carácter.
	BT2  : in STD_LOGIC;
	BT3  : in STD_LOGIC;		-- Manda un flotante.
	SND  : in STD_logic;
	Tx	 : out	std_logic);		-- Salida de secuencia
end entity Transmisor;								


architecture simple of Transmisor is
signal Qp, Qn : std_logic_vector(5 downto 0) := (others => '0');
signal Tx_s	: std_logic:='1';

signal start : std_logic:='0';

Signal Data1 : std_logic_vector(7 downto 0) := "01000001" ; -- Ascii 'A' : Hex 65 
Signal Data2 : std_logic_vector(7 downto 0) := "01000010" ; -- Ascii 'B' : Hex 66
Signal Data3 : std_logic_vector(7 downto 0) := "01000011" ; -- Ascii 'C' : Hex 67  

signal parity : std_logic:='0';
signal stop : std_logic:='1';
begin																		   
	
	Tx <= Tx_s;
	
	
	secuencial: process	(Qp) is
	begin 
		--sw1 enviar A
		If (BT1 = '1' and SND = '1') then
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
				
			when others	=> 
				Tx_s <= '1';
				if (BT1 = '0') then
					Qn <= (others => '0');
				else
					Qn <= Qp;
				end if;
		end case;
		end if;
		
		--sw2 enviar B
		If (BT2 = '1' and SND = '1') then
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
				
			when others	=> 
				Tx_s <= '1';
				if (BT2 = '0') then
					Qn <= (others => '0');
				else
					Qn <= Qp;
				end if;
		end case;
		end if;
		
		--sw3 enviar C
		If (BT3 = '1' and SND = '1') then
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
				
			when others	=> 
				Tx_s <= '1';
				if (BT3 = '0') then
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
