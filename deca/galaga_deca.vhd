---------------------------------------------------------------------------------
-- DECA Top level for GALAGA by Somhic (17/08/21) adapted 
-- from De10 port by by Dar (https://sourceforge.net/projects/darfpga/files/Software%20VHDL/galaga/)
-- v1 enabled hsync, vsync in galaga.vhd, added video_clk output in galaga.vhd, 
-- modified pll c0 from 18 to 36.2 MHz to derive from it 18 for core and 12 for vga clock 
--
---------------------------------------------------------------------------------
-- DE10_lite Top level for Galaga Midway by Dar (darfpga@aol.fr) (06/11/2017)
-- http://darfpga.blogspot.fr
---------------------------------------------------------------------------------
-- Educational use only
-- Do not redistribute synthetized file with roms
-- Do not redistribute roms whatever the form
-- Use at your own risk
---------------------------------------------------------------------------------
-- Main features :
--  PS2 keyboard input
--  PWM audio output
--
-- Uses 1 pll for 18MHz and 11MHz generation from 50MHz
--
-- Board key :
--      0 : reset
--
-- Keyboard inputs :
--   F3 : Add coin
--   F2 : Start 2 players
--   F1 : Start 1 player
--   SPACE       : Fire player 1 & 2
--   RIGHT arrow : Move right player 1 & 2
--   LEFT arrow  : Move left player 1 & 2
--
-- Dip switch and other details : see galaga.vhd

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--   DE10_lite Top version support digital audio out sgtl5000 support with 
--     teensy audio shield on top of arduino usb host shield
--
--   BEWARE : arduino shield has to be modified (see instruction on my blog)
--   For more detail see xevious_de10_lite
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

library work;

entity galaga_deca is
port(
 max10_clk1_50  : in std_logic;

 ledr      : out std_logic;
 key0      : in std_logic;

 vga_r     : out std_logic_vector(3 downto 0);
 vga_g     : out std_logic_vector(3 downto 0);
 vga_b     : out std_logic_vector(3 downto 0);
 vga_hs    : out std_logic;
 vga_vs    : out std_logic;
 
 ps2_clk         : in std_logic;
 ps2_dat         : in std_logic;
 pwm_audio_out_l : out std_logic;
 pwm_audio_out_r : out std_logic;

-- JOYSTICK
JOY1_B2_P9		: IN    STD_LOGIC;
JOY1_B1_P6		: IN    STD_LOGIC;
JOY1_UP		    : IN    STD_LOGIC;
JOY1_DOWN		  : IN    STD_LOGIC;
JOY1_LEFT	  	: IN    STD_LOGIC;
JOY1_RIGHT		: IN    STD_LOGIC;
JOYX_SEL_O		: OUT   STD_LOGIC := '1';

-- HDMI-TX  DECA 
HDMI_I2C_SCL  : inout std_logic; 		          		
HDMI_I2C_SDA  : inout std_logic; 		          		
HDMI_I2S      : inout std_logic_vector(3 downto 0);		     	
HDMI_LRCLK    : inout std_logic; 		          		
HDMI_MCLK     : inout std_logic;		          		
HDMI_SCLK     : inout std_logic; 		          		
HDMI_TX_CLK   : out	std_logic;	          		
HDMI_TX_D     : out	std_logic_vector(23 downto 0);	    		
HDMI_TX_DE    : out std_logic;		          		 
HDMI_TX_HS    : out	std_logic;	          		
HDMI_TX_INT   : in  std_logic;		          		
HDMI_TX_VS    : out std_logic;         

-- AUDIO CODEC  DECA 
AUDIO_GPIO_MFP5 : inout std_logic;
AUDIO_MISO_MFP4 : in std_logic;
AUDIO_RESET_n :  inout std_logic;
AUDIO_SCLK_MFP3 : out std_logic;
AUDIO_SCL_SS_n : out std_logic;
AUDIO_SDA_MOSI : inout std_logic;
AUDIO_SPI_SELECT : out std_logic;
i2sMck : out std_logic;
i2sSck : out std_logic;
i2sLr : out std_logic;
i2sD : out std_logic

);
end galaga_deca;

architecture struct of galaga_deca is

 signal clock_36  : std_logic;  --mod by somhic
 signal clock_6   : std_logic;  --mod by somhic
 signal clock_12   : std_logic;  --mod by somhic

 signal clock_18  : std_logic;
 signal clock_18n : std_logic;
 signal clock_11  : std_logic;
 signal clock_9   : std_logic;
 signal reset     : std_logic;
  
 signal r         : std_logic_vector(2 downto 0);
 signal g         : std_logic_vector(2 downto 0);
 signal b         : std_logic_vector(1 downto 0);
 signal csync     : std_logic;
 signal blankn    : std_logic;
 signal hsync     : std_logic;   -- mod by somhic
 signal vsync     : std_logic;   -- mod by somhic
 signal audio           : std_logic_vector( 9 downto 0);
 signal pwm_accumulator : std_logic_vector(12 downto 0);
 signal tv15Khz_mode : std_logic := '0';

 alias reset_n         : std_logic is key0;
 
 signal kbd_intr      : std_logic;
 signal kbd_scancode  : std_logic_vector(7 downto 0);
 signal joyPCFRLDU    : std_logic_vector(8 downto 0);
 signal fn_pulse       : std_logic_vector(7 downto 0);
 signal fn_toggle      : std_logic_vector(7 downto 0);

-- video signals   -- mod by somhic
 --signal clock_vga       : std_logic;   
 signal video_clk       : std_logic;   
 signal vga_g_i         : std_logic_vector(5 downto 0);   
 signal vga_r_i         : std_logic_vector(5 downto 0);   
 signal vga_b_i         : std_logic_vector(5 downto 0);   
 signal vga_r_o         : std_logic_vector(5 downto 0);   
 signal vga_g_o         : std_logic_vector(5 downto 0);   
 signal vga_b_o         : std_logic_vector(5 downto 0);   
 signal hsync_o         : std_logic;   
 signal vsync_o         : std_logic;   
 signal blankn_o        : std_logic;

 signal vga_r_c         : std_logic_vector(3 downto 0);
 signal vga_g_c         : std_logic_vector(3 downto 0);
 signal vga_b_c         : std_logic_vector(3 downto 0);
 signal vga_hs_c        : std_logic;
 signal vga_vs_c        : std_logic;

-- joy signals
 signal left_i          : std_logic; 
 signal right_i         : std_logic; 
 signal up_i            : std_logic;
 signal down_i          : std_logic;
 signal fire_i          : std_logic;

  -- signals for I2S output    
  signal I2S_SCLK         : std_logic;   
  signal I2S_LRCLK        : std_logic;   
  signal sample_data      : std_logic_vector(31 downto 0); -- audio data : 16bits left channel + 16bits right channel    
  signal tx_data          : std_logic;   
  signal sample_data_reg  : std_logic_vector(31 downto 0);
  signal audio_out        : std_logic := '0';
  signal audio_bit_cnt    : integer range 0 to 31 := 0;


component scandoubler        -- mod by somhic
    port (
    clk_sys : in std_logic;
    scanlines : in std_logic_vector (1 downto 0);
    ce_x1 : in std_logic;
    ce_x2 : in std_logic;
    hs_in : in std_logic;
    vs_in : in std_logic;
    r_in : in std_logic_vector (5 downto 0);
    g_in : in std_logic_vector (5 downto 0);
    b_in : in std_logic_vector (5 downto 0);
    hs_out : out std_logic;
    vs_out : out std_logic;
    r_out : out std_logic_vector (5 downto 0);
    g_out : out std_logic_vector (5 downto 0);
    b_out : out std_logic_vector (5 downto 0)
  );
end component;

  component I2C_HDMI_Config
      port (
      iCLK : in std_logic;
      iRST_N : in std_logic;
      I2C_SCLK : out std_logic;
      I2C_SDAT : inout std_logic;
      HDMI_TX_INT : in std_logic
    );
  end component;

  component AUDIO_SPI_CTL_RD
      port (
      iRESET_n : in std_logic;
      iCLK_50 : in std_logic;
      oCS_n : out std_logic;
      oSCLK : out std_logic;
      oDIN : out std_logic;
      iDOUT : in std_logic
    );
  end component;

  signal RESET_DELAY_n     : std_logic;   

  signal slot       : std_logic_vector(2 downto 0) := (others => '0');

begin

reset <= not reset_n;
clock_18n <= not clock_18;

--start <= not key(1);
-- tv15Khz_mode <= sw();

-- Clock 36 from which derive later 18MHz for galaga core, 
clk_11_18 : entity work.max10_pll_18M_11M
port map(
 inclk0 => max10_clk1_50,
 c0 => clock_36,
 --c1 => clock_11,        --11MHz for keyboard not used
 locked => open --pll_locked
);

process (clock_36)
begin
 if rising_edge(clock_36) then
  clock_12      <= '0';
	
	clock_18  <= not clock_18;

  if slot = "101" then
   slot <= (others => '0');
  else
		slot <= std_logic_vector(unsigned(slot) + 1);
  end if;   
	
	if slot = "100" or slot = "001" then clock_6 <= not clock_6;	end if;
	if slot = "100" or slot = "001" then clock_12  <= '1';	end if;	

 end if;
end process;


-- Galaga
galaga : entity work.galaga
port map(
 clock_18     => clock_18,
 reset        => reset,

-- tv15Khz_mode => tv15Khz_mode,
 video_r      => r,
 video_g      => g,
 video_b      => b,
 video_csync  => csync,
 video_blankn => blankn,
 video_hs     => hsync,
 video_vs     => vsync,
 video_clk    => video_clk,    -- mod by somhic
 audio        => audio,
 
 b_test       => '1',
 b_svce       => '1', 
 coin         => fn_pulse(2), -- F3
 start1       => fn_pulse(3), -- F1
 start2       => fn_pulse(4), -- F2

 left1        => not left_i,   --joyPCFRLDU(2),
 right1       => not right_i,  --joyPCFRLDU(3),
 fire1        => not fire_i,   --joyPCFRLDU(4),

 left2        => joyPCFRLDU(2),
 right2       => joyPCFRLDU(3),
 fire2        => joyPCFRLDU(4) 
);

-- adapt video to 6 bits/color only
vga_r_i <= r & r  when blankn = '1' else "000000";
vga_g_i <= g & g  when blankn = '1' else "000000";
vga_b_i <= b & b & b  when blankn = '1' else "000000";

-- vga scandoubler
scandoubler_inst :  scandoubler
  port map (
    clk_sys => clock_12,     --clock_18, video_clk i clock_36 no funciona
    scanlines => "00",       --(00-none 01-25% 10-50% 11-75%)
    ce_x1 => clock_6,     
    ce_x2 => '1',
    hs_in => hsync,
    vs_in => vsync,
    r_in => vga_r_i,
    g_in => vga_g_i,
    b_in => vga_b_i,
    hs_out => hsync_o,
    vs_out => vsync_o,
    r_out => vga_r_o,
    g_out => vga_g_o,
    b_out => vga_b_o
  );


-- RGB
-- adapt video to 4bits/color only and blank
vga_r_c <= r & r(2)     when blankn = '1' else "0000";
vga_g_c <= g & g(2)     when blankn = '1' else "0000";
vga_b_c <= b & b        when blankn = '1' else "0000";
-- synchro composite/ synchro horizontale
vga_hs_c <= csync;
-- vga_hs <= csync when tv15Khz_mode = '1' else hsync;
-- commutation rapide / synchro verticale
vga_vs_c <= '1';
-- vga_vs <= '1'   when tv15Khz_mode = '1' else vsync;


--VIDEO OUTPUT VGA/RGB
tv15Khz_mode <= fn_toggle(7);          -- F8 key
process (clock_36)
begin
		if rising_edge(clock_36) then
			if tv15Khz_mode = '1' then
        --RGB
        vga_r  <= vga_r_c;
        vga_g  <= vga_g_c;
        vga_b  <= vga_b_c;
        vga_hs <= vga_hs_c;
        vga_vs <= vga_vs_c; 
			else
        --VGA
        -- adapt video to 4 bits/color only
        vga_r  <= vga_r_o (5 downto 2);
        vga_g  <= vga_g_o (5 downto 2);
        vga_b  <= vga_b_o (5 downto 2);
        vga_hs <= hsync_o;       
        vga_vs <= vsync_o; 	    	
			end if;
		end if;
end process;


-- get scancode from keyboard
process (reset, clock_18)
begin
	if reset='1' then
		clock_9  <= '0';
	else 
		if rising_edge(clock_18) then
				clock_9  <= not clock_9;
		end if;
	end if;
end process;


keyboard : entity work.io_ps2_keyboard
port map (
  clk       => clock_9,  
  kbd_clk   => ps2_clk,
  kbd_dat   => ps2_dat,
  interrupt => kbd_intr,
  scancode  => kbd_scancode
);

-- translate scancode to joystick
joystick : entity work.kbd_joystick
port map (
  clk         => clock_9, 
  kbdint      => kbd_intr,
  kbdscancode => std_logic_vector(kbd_scancode), 
  joy_BBBBFRLDU  => joyPCFRLDU,
  fn_pulse      => fn_pulse,
  fn_toggle     => fn_toggle
);

--Sega megadrive gamepad
JOYX_SEL_O <= '1';  --not needed. core uses 1 button only

left_i   <= not joyPCFRLDU(2) and JOY1_LEFT;  -- left
right_i  <= not joyPCFRLDU(3) and JOY1_RIGHT; -- right
fire_i   <= not joyPCFRLDU(4) and JOY1_B1_P6; -- space

-- pwm sound output
process(clock_18)
begin
  if rising_edge(clock_18) then
    pwm_accumulator  <=  std_logic_vector(unsigned('0' & pwm_accumulator(11 downto 0)) + unsigned('0' & audio & '0'));
  end if;
end process;

pwm_audio_out_l <= pwm_accumulator(12);
pwm_audio_out_r <= pwm_accumulator(12); 


-- ###################################

-- Clock MHz for video & I2S        
clocks2 : entity work.pll2    -- check IP components in project navigator
port map(
 inclk0 => max10_clk1_50,
 --c0 => clock_vga,               
 c1 => I2S_SCLK,
 c2 => I2S_LRCLK,
 locked => open --pll_locked
);

-- HDMI CONFIG    
I2C_HDMI_Config_inst : I2C_HDMI_Config
  port map (
    iCLK => max10_clk1_50,
    iRST_N => reset_n,
    I2C_SCLK => HDMI_I2C_SCL,
    I2C_SDAT => HDMI_I2C_SDA,
    HDMI_TX_INT => HDMI_TX_INT
  );

-- Video generated at 6 MHz

-- HDMI VIDEO  direct video
HDMI_TX_CLK <= clock_12;    -- clock_18 res 864x224 only LG
HDMI_TX_DE <= blankn;  
HDMI_TX_HS <= hsync;  
HDMI_TX_VS <= vsync;  
HDMI_TX_D <= vga_r_i&vga_r_i(5 downto 4)&vga_g_i&vga_g_i(5 downto 4)&vga_b_i&vga_b_i(5 downto 4);


-- HDMI AUDIO   
HDMI_MCLK <= clock_18;
HDMI_SCLK <= I2S_SCLK;    --  894,7 kHz  = lr*2*16   -no- 448 kHz 
HDMI_LRCLK <= I2S_LRCLK;   -- 27,96 kHz              -no-  14 kHz  music with noise
HDMI_I2S(0) <= tx_data;


-- I2S interface audio
sample_data <= "000" & audio & "000" & "000" & audio & "000";  -- audio data : 16bits left channel + 16bits right channel 
tx_data <= sample_data_reg(audio_bit_cnt) when audio_out = '1' else '0';
 

-- Taken from Dar Xevious sgtl5000_dac.vhd
process(I2S_SCLK)
begin
	if rising_edge(I2S_SCLK) then
		if I2S_LRCLK  = '1' then			--0 = Left channel, 1 = Right channel
			audio_bit_cnt <= 31;
			sample_data_reg <= sample_data;
			audio_out <= '1';
		else
			if audio_bit_cnt = 0 then
				audio_out <= '0';				
			else
				audio_bit_cnt <= audio_bit_cnt -1;
			end if;
		end if;
  end if;
end process;


-- DECA AUDIO CODEC
RESET_DELAY_n <= not reset;

-- Audio DAC DECA Output assignments
AUDIO_GPIO_MFP5  <= '1';  -- GPIO
AUDIO_SPI_SELECT <= '1';  -- SPI mode
AUDIO_RESET_n    <= RESET_DELAY_n;    

-- DECA AUDIO CODEC SPI CONFIG
AUDIO_SPI_CTL_RD_inst : AUDIO_SPI_CTL_RD
  port map (
    iRESET_n => RESET_DELAY_n,
    iCLK_50 => max10_clk1_50,
    oCS_n => AUDIO_SCL_SS_n,
    oSCLK => AUDIO_SCLK_MFP3,
    oDIN => AUDIO_SDA_MOSI,
    iDOUT => AUDIO_MISO_MFP4
  );

-- DECA AUDIO CODEC I2S DATA
i2sMck <= clock_18;
i2sSck <= I2S_SCLK;    -- 894,7 kHz  = lr*2*16
i2sLr  <= I2S_LRCLK;   --  27,96 kHz
i2sD   <= tx_data;


end struct;
