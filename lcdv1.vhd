LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY lcd_example IS 
  PORT(
  	  SW1 		: IN STD_logic;
  	  SW2 		: IN STD_logic;
  	  SEND 		: IN STD_logic;
      clk       : IN  STD_LOGIC;  --system clock
      rw, rs, e : OUT STD_LOGIC;  --read/write, setup/data, and enable for lcd
      lcd_data  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); --data signals for lcd
END lcd_example;

ARCHITECTURE behavior OF lcd_example IS
  SIGNAL   lcd_enable : STD_LOGIC;
  SIGNAL   lcd_bus    : STD_LOGIC_VECTOR(13 DOWNTO 0);
  SIGNAL   lcd_busy   : STD_LOGIC;
  COMPONENT lcd_controller IS
    PORT( 
       clk        : IN  STD_LOGIC; --system clock
       reset_n    : IN  STD_LOGIC; --active low reinitializes lcd
       lcd_enable : IN  STD_LOGIC; --latches data into lcd controller
       lcd_bus    : IN  STD_LOGIC_VECTOR(13 DOWNTO 0); --data and control signals
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
    VARIABLE char  :  INTEGER RANGE 0 TO 10 := 0;
  BEGIN
    IF(clk'EVENT AND clk = '1') THEN
      IF(lcd_busy = '0' AND lcd_enable = '0') THEN
        lcd_enable <= '1';

		if(SW1 = '1' AND SEND = '0') then --enviar A
		  lcd_bus <= "10001101000001";
		elsif(SW2 = '1' AND SEND = '0') then  --enviar B
		  lcd_bus <= "10001101000010";
		elsif(SW2 = '1' AND SEND = '0') then  --enviar C
		  lcd_bus <= "10001101000011";
		elsif(SW2='0' AND SW1='0' AND SEND='1') then
		  lcd_bus <= "10001101000101"; --E de esperando
		end if;	  
          --WHEN 2 => lcd_bus <= "10001101000010";
--          WHEN 3 => lcd_bus <= "10001101000011";
--          WHEN 4 => lcd_bus <= "1000110100";
--          WHEN 5 => lcd_bus <= "1000110101";
--          WHEN 6 => lcd_bus <= "1000110110";
--          WHEN 7 => lcd_bus <= "1000110111";
--          WHEN 8 => lcd_bus <= "1000111000";
--          WHEN 9 => lcd_bus <= "1000111001";
      ELSE
        lcd_enable <= '0';
      END IF;
    END IF;
  END PROCESS;
  
END behavior;
