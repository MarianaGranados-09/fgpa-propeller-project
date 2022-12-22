LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY lcd_example IS
  PORT(
  	  SW1 		: IN STD_logic;
  	  SW2 		: IN STD_logic;
	  SW3		: IN STD_logic;
  	  SEND 		: IN STD_logic;
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

  --instantiate the lcd controller
  dut: lcd_controller
    PORT MAP(clk => clk, reset_n => '1', lcd_enable => lcd_enable, lcd_bus => lcd_bus, 
             busy => lcd_busy, rw => rw, rs => rs, e => e, lcd_data => lcd_data);
  
 PROCESS(clk)
    VARIABLE char  :  INTEGER RANGE 0 TO 16 := 0;
  BEGIN
	
    IF(clk'EVENT AND clk = '1') THEN
		if(SW1='0' AND SW2='0' AND SW3='0' AND SEND='1') then
				
			IF(lcd_busy = '0' AND lcd_enable = '0') THEN
			        lcd_enable <= '1';
			        IF(char < 11) THEN
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
			          WHEN OTHERS => lcd_enable <= '0';
			        END CASE;
			      ELSE
			        lcd_enable <= '0';
			      END IF;
    		
			END IF;
			
			if(SW1='1' AND SW2='0' AND SW3='0' AND SEND='1') then
			      IF(lcd_busy = '0' AND lcd_enable = '0') THEN
			        lcd_enable <= '1';
			        IF(char < 12) THEN
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
			          WHEN OTHERS => lcd_enable <= '0';
			        END CASE;
			      ELSE 
			        lcd_enable <= '0';
			      END IF;
    		END IF;		
		END IF;
		
	IF(SEND = '0' ) THEN
		char := 0;
		lcd_bus <= "0000000001"; --Clear
		lcd_enable <= '1';
	end IF;
  END PROCESS;
  
  
END behavior;
