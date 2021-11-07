---------------------------------------------------------------------------------
-- wm8731_dac by Dar (darfpga@aol.fr)
-- http://darfpga.blogspot.fr
--
-- WM8731 driver for dac only operation
--
---------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all,IEEE.NUMERIC_STD.ALL;

entity wm8731_dac is
port(
  Clk18MHz     : in  std_logic; -- horloge de travail du W8731 (voir programmation du registre 8)
  SampleData   : in  std_logic_vector(31 downto 0); -- audio data : 16bits left channel + 16bits right channel
  I2C_SCLK     : out std_logic;
  I2C_SDAT     : out std_logic;
  AUD_BCLK     : out std_logic;
  AUD_DACLRCK  : out std_logic;
  AUD_DACDAT   : out std_logic;
  AUD_XCK      : out std_logic
);
end wm8731_dac ;

architecture struct of wm8731_dac is

subtype I2C_NbWord is integer range 0 to 7;
type    DataArray  is array (I2C_NbWord) of std_logic_vector(15 downto 0);

constant I2C_Adr  :  std_logic_vector(7 downto 0) := "00110100";  -- I2C Adresse

-- I2C Data 7bits de No de registre, 9bits de donnee
constant I2C_Data : DataArray := (
  "0001111000000000", -- R15 Reset Chip
  "0000100000010000", -- R4  dacsel
  "0000101000000000", -- R5  dacmu off
  "0000110001100111", -- R6  dac on, out on
  "0000111000000011", -- R7  slave, dsp mode, 16bits, msb 1bclk,
--  "0001000000001110", -- R8  normal mode, 384fs, SR=3 (MCLK@18.432Mhz, fs=8kHz)),
  "0001000000000010", -- R8  normal mode, 384fs, SR=0 (MCLK@18.432Mhz, fs=48kHz)),
  "0001001000000000", -- R9  deactivate digital audio interface
  "0001001000000001"  -- R9  reactivate digital audio interface
);

signal I2C_ClkDiv      : std_logic_vector(5 downto 0);
signal I2C_Clk         : std_logic;
signal I2C_BitPhase    : integer range 0 to  2 := 0;
signal I2C_BitCnt      : integer range 0 to 31 := 0; 
signal I2C_WordCnt     : I2C_NbWord := 0;
signal SamplePeriodCnt : integer range 0 to 2303 := 0;
signal SampleDataReg   : std_logic_vector(31 downto 0);

signal TestDiv18MhzTo1Khz : std_logic_vector(15 downto 0);

begin

-- WM8731 interface I2C 

process(Clk18MHz)
begin
  if rising_edge(Clk18MHz) then

    if I2C_ClkDiv = "100011" then -- 18MHz/36 = 500kHz
      I2C_ClkDiv <= "000000";
    else
      I2C_ClkDiv <= std_logic_vector(unsigned(I2C_ClkDiv)+1);
    end if;
    
    if I2C_ClkDiv = "000000" then
      I2C_Clk <= '0';
    elsif I2C_ClkDiv = "010010" then
      I2C_Clk <= '1';
    end if;

    if TestDiv18MhzTo1Khz = "0100011001010000" then -- 18MHz/180000 = 1kHz
      TestDiv18MhzTo1Khz <= "0000000000000000";
    else
      TestDiv18MhzTo1Khz <= std_logic_vector(unsigned(TestDiv18MhzTo1Khz)+1);
    end if;
    
    
  end if;
end process;

process(I2C_Clk)
begin
  if rising_edge(I2C_Clk) then
  
    -- Comptage de Nb mots, 32 bits par mot, 3 phases par bit
    if I2C_BitPhase = 2 then
      I2C_BitPhase <= 0;
  
      if I2C_BitCnt = 31 then
        if I2C_WordCnt = I2C_NbWord'high then
        -- Fin d ecriture 
        else
          I2C_BitCnt <= 0;
          I2C_WordCnt <= I2C_WordCnt + 1;
        end if;
      else
        I2C_BitCnt <= I2C_BitCnt + 1;
      end if;
    else
      I2C_BitPhase <= I2C_BitPhase + 1;
    end if;
 
    -- Generation de l'horloge I2C 
    if    I2C_BitCnt   =  0 then  I2C_SCLK <= '1';
    elsif I2C_BitCnt   =  1 then
      if  I2C_BitPhase =  0 then  I2C_SCLK <= '1';
      else                        I2C_SCLK <= '0';
      end if;
    elsif I2C_BitCnt   = 29 then 
      if  I2C_BitPhase =  0 then  I2C_SCLK <= '0';
      else                        I2C_SCLK <= '1';
      end if;
    elsif I2C_BitCnt   = 30 then  I2C_SCLK <= '1';
    elsif I2C_BitCnt   = 31 then  I2C_SCLK <= '1';
    elsif I2C_BitPhase =  1 then  I2C_SCLK <= '1';
    else                          I2C_SCLK <= '0';
    end if;

    -- Generation des donnees I2C : 
    case I2C_BitCnt is
      when  1 => I2C_SDAT <= '0';                   -- start condition
      when  2 => I2C_SDAT <= I2C_Adr(7);            -- 8 bits I2C adresse
      when  3 => I2C_SDAT <= I2C_Adr(6);
      when  4 => I2C_SDAT <= I2C_Adr(5);
      when  5 => I2C_SDAT <= I2C_Adr(4);
      when  6 => I2C_SDAT <= I2C_Adr(3);
      when  7 => I2C_SDAT <= I2C_Adr(2);
      when  8 => I2C_SDAT <= I2C_Adr(1);
      when  9 => I2C_SDAT <= I2C_Adr(0);
      -- 1 bit acknowledge
      when 11 => I2C_SDAT <= I2C_Data(I2C_WordCnt)(15); -- 8 bits I2C data 
      when 12 => I2C_SDAT <= I2C_Data(I2C_WordCnt)(14); 
      when 13 => I2C_SDAT <= I2C_Data(I2C_WordCnt)(13); 
      when 14 => I2C_SDAT <= I2C_Data(I2C_WordCnt)(12); 
      when 15 => I2C_SDAT <= I2C_Data(I2C_WordCnt)(11); 
      when 16 => I2C_SDAT <= I2C_Data(I2C_WordCnt)(10); 
      when 17 => I2C_SDAT <= I2C_Data(I2C_WordCnt)( 9); 
      when 18 => I2C_SDAT <= I2C_Data(I2C_WordCnt)( 8); 
      -- 1 bit acknowledge
      when 20 => I2C_SDAT <= I2C_Data(I2C_WordCnt)( 7); -- 8bits I2C data 
      when 21 => I2C_SDAT <= I2C_Data(I2C_WordCnt)( 6); 
      when 22 => I2C_SDAT <= I2C_Data(I2C_WordCnt)( 5); 
      when 23 => I2C_SDAT <= I2C_Data(I2C_WordCnt)( 4); 
      when 24 => I2C_SDAT <= I2C_Data(I2C_WordCnt)( 3); 
      when 25 => I2C_SDAT <= I2C_Data(I2C_WordCnt)( 2); 
      when 26 => I2C_SDAT <= I2C_Data(I2C_WordCnt)( 1); 
      when 27 => I2C_SDAT <= I2C_Data(I2C_WordCnt)( 0); 
      -- 1 bit acknowledge
      when 29 => I2C_SDAT <= '0';                   -- stop condition
      when others  => I2C_SDAT <= '1'; 
    end case;	

  end if;
end process;

-- WM8731 interface audio

AUD_XCK  <= Clk18MHz;
AUD_BCLK <= not(Clk18MHz);
AUD_DACDAT <= SampleDataReg(31);

process(Clk18MHz)
begin
  if rising_edge(Clk18MHz) then
    
--    if SamplePeriodCnt = 2303 then -- 18.432MHz/2304 = 8.000kHz (voir datasheet page 40 : 2304 = 384*6)
    if SamplePeriodCnt = 383 then -- 18.432MHz/384 = 48.---kHz (voir datasheet page 40)
      SamplePeriodCnt     <=  0;
      AUD_DACLRCK         <= '1'; -- synchro debut de donnees
      SampleDataReg       <= SampleData;
    else
      SamplePeriodCnt     <=  SamplePeriodCnt+1;
      AUD_DACLRCK         <=  '0';
      SampleDataReg <= SampleDataReg(30 downto 0) & "0";
    end if;

  end if;
end process;

end architecture;