LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY lcd_example IS
  PORT(
  	  H 		: IN STD_logic;
      RST 		: IN STD_logic;
	  MOTOR		: OUT STD_logic;
  	  SW1 		: IN STD_logic;
  	  SW2 		: IN STD_logic;
	  SW3		: IN STD_logic;
	  SW4		: IN STD_logic;
  	  SEND 		: IN STD_logic;
	  Tx		: OUT STd_logic;
	  SWCLEAR	: IN STD_logic;
      clk       : IN  STD_LOGIC;  --system clock
      rw, rs, e : OUT STD_LOGIC;  --read/write, setup/data, and enable for lcd
      lcd_data  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); --data signals for lcd
END lcd_example;

ARCHITECTURE behavior OF lcd_example IS
  SIGNAL Qp, Qn : std_logic_vector(5 downto 0) := (others => '0');
  --SIGNAL flag   : std_logic:='0';
  --SIGNAL DataA : std_logic_vector(7 downto 0):="01000001";
  SIGNAL   lcd_enable : STD_LOGIC;
  SIGNAL   lcd_bus    : STD_LOGIC_VECTOR(9 DOWNTO 0);
  SIGNAL   lcd_busy   : STD_LOGIC;
  SIgnal   baud : STD_logic;
  COMPONENT lcd_controller IS
    PORT(
       clk        : IN  STD_LOGIC; --system clock
       reset_n    : IN  STD_LOGIC; --active low reinitializes lcd
       lcd_enable : IN  STD_LOGIC; --latches data into lcd controller
       lcd_bus    : IN  STD_LOGIC_VECTOR(9 DOWNTO 0); --data and control signals
       busy       : OUT STD_LOGIC; --lcd controller busy/idle feedback
       rw, rs, e  : OUT STD_LOGIC; --read/write, setup/data, and enable for lcd
       lcd_data   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) --data signals for lcd
	   ); 
  END COMPONENT;
BEGIN
	
	C1 : entity work.BaseDeTiempo generic map(5209,13)port map(clk, RST, H, baud);
	C2 : entity work.Transmisor port map(baud, RST, SW1, SW2, SW3, SEND, Tx);

  --instantiate the lcd controller
  dut: lcd_controller
    PORT MAP(clk => clk, reset_n => '1', lcd_enable => lcd_enable, lcd_bus => lcd_bus, 
	busy => lcd_busy, rw => rw, rs => rs, e => e, lcd_data => lcd_data);
	
	
  
 PROCESS(clk)
    VARIABLE char  :  INTEGER RANGE 0 TO 40 := 0;
  BEGIN
	
    IF(clk'EVENT AND clk = '1') THEN
		if(SW1='0' AND SW2='0' AND SW3='0' AND SW4='0' AND SEND='1') then
				  MOTOR <= '0';
			      IF(lcd_busy = '0' AND lcd_enable = '0') THEN
			        lcd_enable <= '1';
			        IF(char < 17) THEN
			          char := char + 1;
			        END IF;
			        CASE char IS
					  WHEN 1 => lcd_bus <= "1001000101"; --E
			          WHEN 2 => lcd_bus <= "1001010011"; --S
			          WHEN 3 => lcd_bus <= "1001010000"; --P
			          WHEN 4 => lcd_bus <= "1001000101"; --E
			          WHEN 5 => lcd_bus <= "1001010010"; --R
			          WHEN 6 => lcd_bus <= "1001000001"; --A
			          WHEN 7 => lcd_bus <= "1001001110"; --N
			          WHEN 8 => lcd_bus <= "1001000100"; --D
			          WHEN 9 => lcd_bus <= "1001001111"; --O
					  WHEN 10 => lcd_bus <= "1000100000"; --esp
					  WHEN 11 => lcd_bus <= "1000100000"; --esp
					  WHEN 12 => lcd_bus <= "1000100000"; --esp
					  WHEN 13 => lcd_bus <= "1000100000"; --esp
					  WHEN 14 => lcd_bus <= "1000100000"; --esp
					  WHEN 15 => lcd_bus <= "1000100000"; --esp
					  
			          WHEN OTHERS => lcd_enable <= '0';
			        END CASE;
					IF(char = 15) THEN
			          char := 0;
					end IF;
			      ELSE
			        lcd_enable <= '0';
			      END IF;
    		END IF;
			
			if(SW1='1' AND SW2='0' AND SW3='0' AND SEND='0') then --COM
				
			      IF(lcd_busy = '0' AND lcd_enable = '0') THEN
			        lcd_enable <= '1';
			        IF(char < 32) THEN
			          char := char + 1;
			        END IF;
			        CASE char IS
					  WHEN 1 => lcd_bus <= "1001000011"; --C
			          WHEN 2 => lcd_bus <= "1001001111"; --O
			          WHEN 3 => lcd_bus <= "1001001101"; --M
			          WHEN 4 => lcd_bus <= "1001010101"; --U
			          WHEN 5 => lcd_bus <= "1001001110"; --N
			          WHEN 6 => lcd_bus <= "1001001001"; --I
			          WHEN 7 => lcd_bus <= "1001000011"; --C
			          WHEN 8 => lcd_bus <= "1001000001"; --A
			          WHEN 9 => lcd_bus <= "1001001110"; --N
					  WHEN 10 => lcd_bus <= "1001000100"; --D
			          WHEN 11 => lcd_bus <= "1001001111"; --O
					  WHEN 12 => lcd_bus <= "1000100000"; --esp
					  WHEN 13 => lcd_bus <= "1000100000"; --esp
					  WHEN 14 => lcd_bus <= "1000100000"; --esp
					  WHEN 15 => lcd_bus <= "1000100000"; --esp
					  WHEN 16 => lcd_bus <= "1001000011"; --C
			          WHEN 17 => lcd_bus <= "1001001111"; --O
			          WHEN 18 => lcd_bus <= "1001001101"; --M
			          WHEN 19 => lcd_bus <= "1000100000"; --esp
			          WHEN 20 => lcd_bus <= "1000100000"; --esp
			          WHEN 21 => lcd_bus <= "1000100000"; --esp
			          WHEN 22 => lcd_bus <= "1000100000"; --esp
			          WHEN 23 => lcd_bus <= "1000100000"; --esp
			          WHEN 24 => lcd_bus <= "1000100000"; --esp
					  WHEN 25 => lcd_bus <= "1000100000"; --esp
					  WHEN 26 => lcd_bus <= "1000100000"; --esp
					  WHEN 27 => lcd_bus <= "1000100000"; --esp
					  WHEN 28 => lcd_bus <= "1000100000"; --esp
					  WHEN 29 => lcd_bus <= "1000100000"; --esp
					  WHEN 30 => lcd_bus <= "1000100000"; --esp
			          WHEN OTHERS => lcd_enable <= '0';
			        END CASE;
					IF(char = 30) THEN
			          char := 0;
					end IF;
			      ELSE 
			        lcd_enable <= '0';
			      END IF;
    		END IF;
			
			if(SW1='0' AND SW2='1' AND SW3='0' AND SEND='0') then --SERIAL
			      IF(lcd_busy = '0' AND lcd_enable = '0') THEN
			        lcd_enable <= '1';
			        IF(char < 32) THEN
			          char := char + 1;
			        END IF;
			        CASE char IS
					  WHEN 1 => lcd_bus <= "1001000011"; --C
			          WHEN 2 => lcd_bus <= "1001001111"; --O
			          WHEN 3 => lcd_bus <= "1001001101"; --M
			          WHEN 4 => lcd_bus <= "1001010101"; --U
			          WHEN 5 => lcd_bus <= "1001001110"; --N
			          WHEN 6 => lcd_bus <= "1001001001"; --I
			          WHEN 7 => lcd_bus <= "1001000011"; --C
			          WHEN 8 => lcd_bus <= "1001000001"; --A
			          WHEN 9 => lcd_bus <= "1001001110"; --N
					  WHEN 10 => lcd_bus <= "1001000100"; --D
			          WHEN 11 => lcd_bus <= "1001001111"; --O
					  WHEN 12 => lcd_bus <= "1000100000"; --esp
					  WHEN 13 => lcd_bus <= "1000100000"; --esp
					  WHEN 14 => lcd_bus <= "1000100000"; --esp
					  WHEN 15 => lcd_bus <= "1000100000"; --esp
					  WHEN 16 => lcd_bus <= "1001010011"; --S
			          WHEN 17 => lcd_bus <= "1001000101"; --E
			          WHEN 18 => lcd_bus <= "1001010010"; --R
			          WHEN 19 => lcd_bus <= "1001001001"; --I
			          WHEN 20 => lcd_bus <= "1001000001"; --A
			          WHEN 21 => lcd_bus <= "1001001100"; --L
			          WHEN 22 => lcd_bus <= "1000100000"; --esp
			          WHEN 23 => lcd_bus <= "1000100000"; --esp
			          WHEN 24 => lcd_bus <= "1000100000"; --esp
					  WHEN 25 => lcd_bus <= "1000100000"; --esp
					  WHEN 26 => lcd_bus <= "1000100000"; --esp
					  WHEN 27 => lcd_bus <= "1000100000"; --esp
					  WHEN 28 => lcd_bus <= "1000100000"; --esp
					  WHEN 29 => lcd_bus <= "1000100000"; --esp
					  WHEN 30 => lcd_bus <= "1000100000"; --esp
			          WHEN OTHERS => lcd_enable <= '0';
			        END CASE;
					IF(char = 30) THEN
			          char := 0;
					end IF;
			      ELSE 
			        lcd_enable <= '0';
			      END IF;
    		END IF;
			
			if(SW1='0' AND SW2='0' AND SW3='1' AND SEND='0') then --MGXMV
			      IF(lcd_busy = '0' AND lcd_enable = '0') THEN
			        lcd_enable <= '1';
			        IF(char < 32) THEN
			          char := char + 1;
			        END IF;
			        CASE char IS
					  WHEN 1 => lcd_bus <= "1001000011"; --C
			          WHEN 2 => lcd_bus <= "1001001111"; --O
			          WHEN 3 => lcd_bus <= "1001001101"; --M
			          WHEN 4 => lcd_bus <= "1001010101"; --U
			          WHEN 5 => lcd_bus <= "1001001110"; --N
			          WHEN 6 => lcd_bus <= "1001001001"; --I
			          WHEN 7 => lcd_bus <= "1001000011"; --C
			          WHEN 8 => lcd_bus <= "1001000001"; --A
			          WHEN 9 => lcd_bus <= "1001001110"; --N
					  WHEN 10 => lcd_bus <= "1001000100"; --D
			          WHEN 11 => lcd_bus <= "1001001111"; --O
					  WHEN 12 => lcd_bus <= "1000100000"; --esp
					  WHEN 13 => lcd_bus <= "1000100000"; --esp
					  WHEN 14 => lcd_bus <= "1000100000"; --esp
					  WHEN 15 => lcd_bus <= "1000100000"; --esp
					  WHEN 16 => lcd_bus <= "1001001101"; --M
			          WHEN 17 => lcd_bus <= "1001000111"; --G
			          WHEN 18 => lcd_bus <= "1001011000"; --X
			          WHEN 19 => lcd_bus <= "1001001101"; --M
			          WHEN 20 => lcd_bus <= "1001010110"; --V
			          WHEN 21 => lcd_bus <= "1000100000"; --esp
			          WHEN 22 => lcd_bus <= "1000100000"; --esp
			          WHEN 23 => lcd_bus <= "1000100000"; --esp
			          WHEN 24 => lcd_bus <= "1000100000"; --esp
					  WHEN 25 => lcd_bus <= "1000100000"; --esp
					  WHEN 26 => lcd_bus <= "1000100000"; --esp
					  WHEN 27 => lcd_bus <= "1000100000"; --esp
					  WHEN 28 => lcd_bus <= "1000100000"; --esp
					  WHEN 29 => lcd_bus <= "1000100000"; --esp
					  WHEN 30 => lcd_bus <= "1000100000"; --esp
			          WHEN OTHERS => lcd_enable <= '0';
			        END CASE;
					IF(char = 30) THEN
			          char := 0;
					end IF;
			      ELSE 
			        lcd_enable <= '0';
			      END IF;
    		END IF;
			
			if(SW2='0' AND SW3='0' AND SW1= '0' AND SW4='1' AND SEND='0') then
				  MOTOR <= '1';
			      IF(lcd_busy = '0' AND lcd_enable = '0') THEN
			        lcd_enable <= '1';
			        IF(char < 17) THEN
			          char := char + 1;
			        END IF;
			        CASE char IS
					  WHEN 1 => lcd_bus <= "1001001111"; --O
			          WHEN 2 => lcd_bus <= "1001010000"; --P
			          WHEN 3 => lcd_bus <= "1001000101"; --E
			          WHEN 4 => lcd_bus <= "1001010010"; --R
			          WHEN 5 => lcd_bus <= "1001000001"; --A
			          WHEN 6 => lcd_bus <= "1001001110"; --N
			          WHEN 7 => lcd_bus <= "1001000100"; --D
			          WHEN 8 => lcd_bus <= "1001001111"; --O
			          WHEN 9 => lcd_bus <= "1000100000"; --esp
					  WHEN 10 => lcd_bus <= "1000100000"; --esp
			          WHEN 11 => lcd_bus <= "1000100000"; --esp
					  WHEN 12 => lcd_bus <= "1000100000"; --esp
					  WHEN 13 => lcd_bus <= "1000100000"; --esp
					  WHEN 14 => lcd_bus <= "1000100000"; --esp
					  WHEN 15 => lcd_bus <= "1000100000"; --esp
			          WHEN OTHERS => lcd_enable <= '0';
			        END CASE;
					IF(char = 15) THEN
			          char := 0;
					end IF;
			      ELSE 
			        lcd_enable <= '0';
			      END IF;
    		END IF;
			
		END IF;
  END PROCESS;
  
END behavior;
