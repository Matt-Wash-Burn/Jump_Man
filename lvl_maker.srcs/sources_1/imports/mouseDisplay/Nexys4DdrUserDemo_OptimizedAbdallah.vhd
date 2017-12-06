----------------------------------------------------------------------------------
----------------------------------------------------------------------------
-- Author:  Albert Fazakas adapted from Sam Bobrowicz and Mihaita Nagy
--          Copyright 2014 Digilent, Inc.
----------------------------------------------------------------------------

-- Design Name:    Nexys4 DDR User Demo
-- Module Name:    Nexys4DdrUserDemo - Behavioral 
-- Project Name: 
-- Target Devices: Nexys4 DDR Development Board, containing a XC7a100t-1 csg324 device
-- Tool versions: 
-- Description: 
-- This module represents the top - level design of the Nexys4 DDR User Demo.
-- The project connects to the VGA display in a 1280*1024 resolution and displays various
-- items on the screen:
--    - a Digilent / Analog Devices logo
--
--    - a mouse cursor, if an Usb mouse is connected to the board when the project is started
--
--    - the audio signal from the onboard ADMP421 Omnidirectional Microphone

--    - a small square representing the X and Y acceleration data from the ADXL362 onboard Accelerometer.
--      The square moves according the Nexys4 board position. Note that the X and Y axes 
--      on the board are exchanged due to the accelerometer layout on the Nexys4 board.
--      The accelerometer display also displays the acceleration magnitude, calculated as
--      SQRT( X^2 + Y^2 +Z^2), where X, Y and Z represent the acceleration value on the respective axes
--
--    - The FPGA temperature, the onboard ADT7420 temperature sensor temperature value and the accelerometer
--      temperature value
--
--    - The value of the R, G and B components sent to the RGB Leds LD16 and LD17
--
-- Other features:
--    - The 16 Switches (SW0..SW15) are connected to LD0..LD15 except when audio recording is done
--
--    - Pressing BTNL, BTNC and BTNR will toggle between Red, Green and Blue colors on LD16 and LD17
--      Color sweeping returns when BTND is pressed. BTND also togles between LD16, LD17, none or both
--
--    - Pressing BTNU will start audio recording for about 5S, then the audio data will be played back
--      on the Audio output. While recording, LD15..LD0 will show a progressbar moving to left, while
--      playing back, LD15..LD0 will show a progressbar moving to right
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------





library ieee;
use ieee.std_logic_1164.all;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Nexys4DdrUserDemo_optimizedAbdallah is
   port(
      clk_i          : in  std_logic;
      rstn_i         : in  std_logic;
      -- push-buttons
--      btnl_i         : in  std_logic;
--      btnc_i         : in  std_logic;
--      btnr_i         : in  std_logic;
--      btnd_i         : in  std_logic;
--      btnu_i         : in  std_logic;
--      -- switches
--      sw_i           : in  std_logic_vector(15 downto 0);
--      -- 7-segment display
--      disp_seg_o     : out std_logic_vector(7 downto 0);
--      disp_an_o      : out std_logic_vector(7 downto 0);
--      -- leds
--      led_o          : out std_logic_vector(15 downto 0);
--      -- RGB leds
--      rgb1_red_o     : out std_logic;
--      rgb1_green_o   : out std_logic;
--      rgb1_blue_o    : out std_logic;
--      rgb2_red_o     : out std_logic;
--      rgb2_green_o   : out std_logic;
--      rgb2_blue_o    : out std_logic;
      -- VGA display
      vga_hs_o       : out std_logic;
      vga_vs_o       : out std_logic;
      vga_red_o      : out std_logic_vector(3 downto 0);
      vga_blue_o     : out std_logic_vector(3 downto 0);
      vga_green_o    : out std_logic_vector(3 downto 0);
--      -- PDM microphone
--      pdm_clk_o      : out std_logic;
--      pdm_data_i     : in  std_logic;
--      pdm_lrsel_o    : out std_logic;
--      -- PWM audio
--      pwm_audio_o    : inout std_logic;
--      pwm_sdaudio_o  : out std_logic;
--		-- Temperature sensor
--		tmp_scl        : inout std_logic;
--		tmp_sda        : inout std_logic;
--		tmp_int        : in std_logic; -- Not used in this project
--		tmp_ct         : in std_logic; -- Not used in this project
--       SPI Interface signals for the ADXL362 accelerometer
      sclk           : out STD_LOGIC;
      mosi           : out STD_LOGIC;
      miso           : in STD_LOGIC;
      ss             : out STD_LOGIC;
      -- PS2 interface signals
--      ps2_clk        : inout std_logic;
--      ps2_data       : inout std_logic;
      
      -- Debug output signals
--      SCLK_DBG       : out STD_LOGIC;
--      MOSI_DBG       : out STD_LOGIC;
--      MISO_DBG       : out STD_LOGIC;
--      SS_DBG         : out STD_LOGIC;
      
--      PS2C_DBG       : out std_logic;
--      PS2D_DBG       : out std_logic;
      
      -- DDR2 interface signals
      -- ddr2_addr      : out   std_logic_vector(12 downto 0);
      -- ddr2_ba        : out   std_logic_vector(2 downto 0);
      -- ddr2_ras_n     : out   std_logic;
      -- ddr2_cas_n     : out   std_logic;
      -- ddr2_we_n      : out   std_logic;
      -- ddr2_ck_p      : out   std_logic_vector(0 downto 0);
      -- ddr2_ck_n      : out   std_logic_vector(0 downto 0);
      -- ddr2_cke       : out   std_logic_vector(0 downto 0);
      -- ddr2_cs_n      : out   std_logic_vector(0 downto 0);
      -- ddr2_dm        : out   std_logic_vector(1 downto 0);
      -- ddr2_odt       : out   std_logic_vector(0 downto 0);
      -- ddr2_dq        : inout std_logic_vector(15 downto 0);
      -- ddr2_dqs_p     : inout std_logic_vector(1 downto 0);
      -- ddr2_dqs_n     : inout std_logic_vector(1 downto 0)

-- added for 7 segement decoder
XChannels : out std_logic_vector(7 downto 0);
XSegs : out std_logic_vector(6 downto 0); 
XMOUSE_Y_POS : out std_logic_vector(11 downto 0);

start : in std_logic;
MoveLeft : in std_logic;
MoveRight : in std_logic;

--output counter
counter : out std_logic_vector(3 downto 0);
YMY_POS: out std_logic_vector(15 downto 0)

   );
end Nexys4DdrUserDemo_optimizedAbdallah;

architecture Behavioral of Nexys4DdrUserDemo_optimizedAbdallah is
----------------------------------------------------------------------------------
-- Signal Declarations
----------------------------------------------------------------------------------
signal  range_led    : STD_LOGIC_VECTOR (3 downto 0);
signal  led_output    : STD_LOGIC_VECTOR (15 downto 0);
signal  accelerometer_in    : STD_LOGIC_VECTOR (8 downto 0);
signal accelerometer_integer : integer range -256 to 255;
signal temp_acc : signed(8 downto 0)  ;
signal Tilt_Left : std_logic; 
signal Tilt_Right: std_logic; 
signal i : integer;
signal sgn : signed(7 downto 0);
--signal  temp_acc    : signed ;
----------------------------------------------------------------------------------
-- Component Declarations
----------------------------------------------------------------------------------  

-- 200 MHz Clock Generator
component ClkGen
port
 (-- Clock in ports
  clk_100MHz_i           : in     std_logic;
  -- Clock out ports
  clk_100MHz_o          : out    std_logic;
  clk_200MHz_o          : out    std_logic;
  -- Status and control signals
  reset_i             : in     std_logic;
  locked_o            : out    std_logic
  

 );
end component;


component count_display is
    Port ( 
		
		value : in std_logic_vector(7 downto 0);
		CLK100MHZ : in std_logic;
--	    RESETME : in std_logic;   
		channels : out std_logic_vector(7 downto 0);
	    segs : out std_logic_vector(6 downto 0));
end component;


component AccelerometerCtl is
 generic 
     (
        SYSCLK_FREQUENCY_HZ : integer := 100000000;
        SCLK_FREQUENCY_HZ   : integer := 1000000;
        NUM_READS_AVG       : integer := 16;
        UPDATE_FREQUENCY_HZ : integer := 1000
     );
     port
     (
      SYSCLK     : in STD_LOGIC; -- System Clock
      RESET      : in STD_LOGIC; -- Reset button on the Nexys4 board is active low
    
      -- SPI interface Signals
      SCLK       : out STD_LOGIC;
      MOSI       : out STD_LOGIC;
      MISO       : in STD_LOGIC;
      SS         : out STD_LOGIC;
     
     -- Accelerometer data signals
      ACCEL_X_OUT    : out STD_LOGIC_VECTOR (8 downto 0);
      ACCEL_Y_OUT    : out STD_LOGIC_VECTOR (8 downto 0);
      ACCEL_MAG_OUT  : out STD_LOGIC_VECTOR (11 downto 0);
      ACCEL_TMP_OUT  : out STD_LOGIC_VECTOR (11 downto 0)
 );
 end component;

-- component RgbLed is
-- port(
   -- clk_i          : in  std_logic;
   -- rstn_i         : in  std_logic;
   -- btnl_i         : in  std_logic;
   -- btnc_i         : in  std_logic;
   -- btnr_i         : in  std_logic;
   -- btnd_i         : in  std_logic;
   -- pwm1_red_o     : out std_logic;
   -- pwm1_green_o   : out std_logic;
   -- pwm1_blue_o    : out std_logic;
   -- pwm2_red_o     : out std_logic;
   -- pwm2_green_o   : out std_logic;
   -- pwm2_blue_o    : out std_logic;
   -- red_out        : out std_logic_vector (7 downto 0);
   -- green_out      : out std_logic_vector (7 downto 0);
   -- blue_out       : out std_logic_vector (7 downto 0)
   -- );
-- end component;

-- component sSegDemo is
-- port(
   -- clk_i          : in std_logic;
   -- rstn_i         : in std_logic;
   -- seg_o          : out std_logic_vector(7 downto 0);
   -- an_o           : out std_logic_vector(7 downto 0));
-- end component;


-- component AudioDemo is
   -- port (
      -- -- Common
      -- clk_i                : in    std_logic;
      -- clk_200_i            : in    std_logic;
      -- device_temp_i        : in    std_logic_vector(11 downto 0);
      -- rst_i                : in    std_logic;

      -- -- Peripherals      
      -- btn_u                : in    std_logic;
      -- leds_o               : out   std_logic_vector(15 downto 0);
      
      -- -- Microphone PDM signals
      -- pdm_m_clk_o    : out   std_logic; -- Output M_CLK signal to the microphone
      -- pdm_m_data_i   : in    std_logic; -- Input PDM data from the microphone
      -- pdm_lrsel_o    : out   std_logic; -- Set to '0', therefore data is read on the positive edge
      
      -- -- Audio output signals
      -- pwm_audio_o    : inout   std_logic; -- Output Audio data to the lowpass filters
      -- pwm_sdaudio_o  : out   std_logic; -- Output Audio enable

      -- -- DDR2 interface
      -- ddr2_addr            : out   std_logic_vector(12 downto 0);
      -- ddr2_ba              : out   std_logic_vector(2 downto 0);
      -- ddr2_ras_n           : out   std_logic;
      -- ddr2_cas_n           : out   std_logic;
      -- ddr2_we_n            : out   std_logic;
      -- ddr2_ck_p            : out   std_logic_vector(0 downto 0);
      -- ddr2_ck_n            : out   std_logic_vector(0 downto 0);
      -- ddr2_cke             : out   std_logic_vector(0 downto 0);
      -- ddr2_cs_n            : out   std_logic_vector(0 downto 0);
      -- ddr2_dm              : out   std_logic_vector(1 downto 0);
      -- ddr2_odt             : out   std_logic_vector(0 downto 0);
      -- ddr2_dq              : inout std_logic_vector(15 downto 0);
      -- ddr2_dqs_p           : inout std_logic_vector(1 downto 0);
      -- ddr2_dqs_n           : inout std_logic_vector(1 downto 0);

      -- pdm_clk_rising_o : out std_logic -- Signaling the rising edge of M_CLK, used by the MicDisplay
                                       -- -- component in the VGA controller
-- );
-- end component;


-- component TempSensorCtl is
	-- Generic (CLOCKFREQ : natural := 100); -- input CLK frequency in MHz
	-- Port (
		-- TMP_SCL : inout STD_LOGIC;
		-- TMP_SDA : inout STD_LOGIC;
      -- -- The Interrupt and Critical Temperature Signals
      -- -- from the ADT7420 Temperature Sensor are not used in this design
-- --		TMP_INT : in STD_LOGIC;
-- --		TMP_CT : in STD_LOGIC;		
		-- TEMP_O : out STD_LOGIC_VECTOR(12 downto 0); --12-bit two's complement temperature with sign bit
		-- RDY_O : out STD_LOGIC;	--'1' when there is a valid temperature reading on TEMP_O
		-- ERR_O : out STD_LOGIC; --'1' if communication error
		-- CLK_I : in STD_LOGIC;
		-- SRST_I : in STD_LOGIC
	-- );
-- end component;

-- component AccelerometerCtl is
-- generic 
-- (
   -- SYSCLK_FREQUENCY_HZ : integer := 100000000;
   -- SCLK_FREQUENCY_HZ   : integer := 1000000;
   -- NUM_READS_AVG       : integer := 16;
   -- UPDATE_FREQUENCY_HZ : integer := 1000
-- );
-- port
-- (
 -- SYSCLK     : in STD_LOGIC; -- System Clock
 -- RESET      : in STD_LOGIC; -- Reset button on the Nexys4 board is active low

 -- -- SPI interface Signals
 -- SCLK       : out STD_LOGIC;
 -- MOSI       : out STD_LOGIC;
 -- MISO       : in STD_LOGIC;
 -- SS         : out STD_LOGIC;
 
-- -- Accelerometer data signals
 -- ACCEL_X_OUT    : out STD_LOGIC_VECTOR (8 downto 0);
 -- ACCEL_Y_OUT    : out STD_LOGIC_VECTOR (8 downto 0);
 -- ACCEL_MAG_OUT  : out STD_LOGIC_VECTOR (11 downto 0);
 -- ACCEL_TMP_OUT  : out STD_LOGIC_VECTOR (11 downto 0)
-- );
-- end component;


COMPONENT MouseCtl is
PORT(
   clk            : in std_logic;
   rst            : in std_logic;
   xpos           : out std_logic_vector(11 downto 0);
   ypos           : out std_logic_vector(11 downto 0);
   zpos           : out std_logic_vector(3 downto 0);
   left           : out std_logic;
   middle         : out std_logic;
   right          : out std_logic;
   new_event      : out std_logic;
   value          : in std_logic_vector(11 downto 0);
   setx           : in std_logic;
   sety           : in std_logic;
   setmax_x       : in std_logic;
   setmax_y       : in std_logic;
 --  ps2_clk        : inout std_logic;
 --  ps2_data       : inout std_logic;
   start         : in std_logic;
   MoveLeft         : in std_logic;
   MoveRight         : in std_logic;
   collision    : in std_logic;
   ready : out std_logic
);
END COMPONENT;
signal ready_top : std_logic;
signal collision_top : std_logic;

component collision is
    Port (  xpos : in std_logic_vector(11 downto 0);
            ypos : in std_logic_vector(11 downto 0);
            clk  : in std_logic;
            hit : out std_logic;
            count: out std_logic_vector(3 downto 0);
            ready : in std_logic
             );
end component;

COMPONENT Vgaformouseonly is
PORT( 
   clk_i          : in  std_logic;
   vga_hs_o       : out std_logic;
   vga_vs_o       : out std_logic;
   vga_red_o      : out std_logic_vector(3 downto 0);
   vga_blue_o     : out std_logic_vector(3 downto 0);
   vga_green_o    : out std_logic_vector(3 downto 0);
   -- RGB_LED_RED    : in STD_LOGIC_VECTOR (7 downto 0);
   -- RGB_LED_GREEN  : in STD_LOGIC_VECTOR (7 downto 0);
   -- RGB_LED_BLUE   : in STD_LOGIC_VECTOR (7 downto 0);
   -- ACCEL_RADIUS   : in  STD_LOGIC_VECTOR (11 downto 0);
   -- LEVEL_THRESH   : in  STD_LOGIC_VECTOR (11 downto 0);
	-- ACL_X_IN       : in  STD_LOGIC_VECTOR (8 downto 0);
   -- ACL_Y_IN       : in  STD_LOGIC_VECTOR (8 downto 0);
   -- ACL_MAG_IN     : in  STD_LOGIC_VECTOR (11 downto 0);
   -- MIC_M_DATA_I   : IN STD_LOGIC;
   -- MIC_M_CLK_RISING  : IN STD_LOGIC;
   MOUSE_X_POS    :  in std_logic_vector (11 downto 0);
   MOUSE_Y_POS    :  in std_logic_vector (11 downto 0)
   -- XADC_TEMP_VALUE_I : in std_logic_vector (11 downto 0);
   -- ADT7420_TEMP_VALUE_I : in std_logic_vector (12 downto 0);
   -- ADXL362_TEMP_VALUE_I : in std_logic_vector (11 downto 0)
   );
END COMPONENT;

----------------------------------------------------------------------------------
-- Signal Declarations
----------------------------------------------------------------------------------  
-- Inverted input reset signal
signal rst        : std_logic;
-- Reset signal conditioned by the PLL lock
signal reset      : std_logic;
signal resetn     : std_logic;
signal locked     : std_logic;

-- 100 MHz buffered clock signal
signal clk_100MHz_buf : std_logic;
-- 200 MHz buffered clock signal
signal clk_200MHz_buf : std_logic;

-- -- ADXL362 Accelerometer data signals
 signal ACCEL_X    : STD_LOGIC_VECTOR (8 downto 0);
 signal ACCEL_Y    : STD_LOGIC_VECTOR (8 downto 0);
 signal ACCEL_MAG  : STD_LOGIC_VECTOR (11 downto 0);
 signal ACCEL_TMP  : STD_LOGIC_VECTOR (11 downto 0);


-- Mouse data signals
signal MOUSE_X_POS: std_logic_vector (11 downto 0);
signal MOUSE_Y_POS: std_logic_vector (11 downto 0);


signal Mouse_X_BUF : std_logic_vector (7 downto 0);
 

signal pdm_clk : std_logic;
signal pdm_clk_rising : std_logic;




begin
   
   Mouse_X_BUF <= MOUSE_X_POS (7 downto 0);
   
   XMOUSE_Y_POS <= NOT MOUSE_Y_POS;
   -- Assign LEDs
--   led_o <= sw_i when (led_audio = X"0000") else led_audio;

   -- The Reset Button on the Nexys4 board is active-low,
   -- however many components need an active-high reset
   rst <= not rstn_i;

   -- Assign reset signals conditioned by the PLL lock
   reset <= rst or (not locked);
   -- active-low version of the reset signal
   resetn <= not reset;


   -- Assign pdm_clk output
--   pdm_clk_o <= pdm_clk;

temp_acc <= signed(accelerometer_in);
accelerometer_integer<= to_integer(temp_acc); 

  range_led <=   "0001" when (accelerometer_integer < 1) else 
                 "0010" ; 
  
  
--                "1110" when (accelerometer_integer < 17)else-- 34)  else 
--                "1101" when (accelerometer_integer <34)else-- 68)  else
--                "1100" when (accelerometer_integer <51)else-- 102) else
--                "1011" when (accelerometer_integer <68)else-- 136) else
--                "1010" when (accelerometer_integer <85)else-- 170) else
--                "1001" when (accelerometer_integer <102)else-- 204) else
--                "1000" when (accelerometer_integer <119)else-- 238) else
--                "0111" when (accelerometer_integer <136)else-- 272) else
--                "0110" when (accelerometer_integer <153)else-- 306) else
--                "0101" when (accelerometer_integer <170)else-- 340) else
--                "0100" when (accelerometer_integer <187)else-- 374) else
--                "0011" when (accelerometer_integer <204)else-- 408) else
--                "0010" when (accelerometer_integer <221)else-- 442) else
--                "0001" when (accelerometer_integer <238)else-- 476) else
--                "0000" when (accelerometer_integer <255)else-- 510) else
--                "1100"; 
                
led_output <=   "0000000001111111" when range_led ="0001"   else 
                "1111111000000000" ; 

--                "0000000000000011" when range_led ="0000"   else 
--                "0000000000000110" when range_led ="0001"   else
--                "0000000000001100" when range_led ="0010"   else
--                "0000000000011000" when range_led ="0011"   else
--                "0000000000110000" when range_led ="0100"   else
--                "0000000001100000" when range_led ="0101"   else
--                "0000000011000000" when  range_led ="0110"  else
--                "0000000110000000" when range_led ="0111"   else
--                "0000001100000000" when range_led ="1000"   else
--                "0000011000000000" when range_led ="1001"   else
--                "0000110000000000" when  range_led ="1010"  else
--                "0001100000000000" when range_led ="1011"   else
--                "0011000000000000" when range_led ="1100"   else
--                "0110000000000000" when range_led ="1101"   else
--                "1100000000000000" when range_led ="1110"   else
--                "0000000000000000" ;
 tilt_left <= range_led(1);
 tilt_right<= range_led(0);                 
 YMY_POS <= led_output;    -- "0000000"& accelerometer_in;           

----------------------------------------------------------------------------------
-- 200MHz Clock Generator
----------------------------------------------------------------------------------
   Inst_ClkGen: ClkGen
   port map (
      clk_100MHz_i   => clk_i,
      clk_100MHz_o   => clk_100MHz_buf,
      clk_200MHz_o   => clk_200MHz_buf,
      reset_i        => rst,
      locked_o       => locked
      );


--- Connect modified 7 segment decoder ------

Inst_count_display : count_display
port map (
	value  => Mouse_X_BUF ,
    CLK100MHZ => clk_i,
	channels => XChannels,
	 segs => XSegs
);


----------------------------------------------------------------------------------
-- Mouse Controller
----------------------------------------------------------------------------------
   Inst_MouseCtl: MouseCtl
   PORT MAP
   (
      clk            => clk_100MHz_buf,
      rst            => reset,
      xpos           => MOUSE_X_POS,
      ypos           => MOUSE_Y_POS,
      zpos           => open,
      left           => open,
      middle         => open,
      right          => open,
      new_event      => open,
      value          => x"000",
      setx           => '0',
      sety           => '0',
      setmax_x       => '0',
      setmax_y       => '0',
 --     ps2_clk        => ps2_clk,
 --     ps2_data       => ps2_data,
      start        => start,
      MoveLeft      => Tilt_Left,
      MoveRight      => Tilt_Right,
      collision     => collision_top,
      ready =>  ready_top
   );

----------------------------------------------------------------------------------
-- VGA Controller
----------------------------------------------------------------------------------
   Inst_VGA: Vgaformouseonly
   port map(
      clk_i          => clk_100MHz_buf,
      vga_hs_o       => vga_hs_o,
      vga_vs_o       => vga_vs_o,
      vga_red_o      => vga_red_o,
      vga_blue_o     => vga_blue_o,
      vga_green_o    => vga_green_o,

      MOUSE_X_POS    => MOUSE_X_POS,
      MOUSE_Y_POS    => MOUSE_Y_POS

      );  
      
      col: collision
      port map (
            xpos => MOUSE_X_POS,
            ypos => MOUSE_Y_POS,
            clk  => clk_i,
            hit  => collision_top,
            count => counter,
            ready => ready_top
            );
            
-- ----------------------------------------------------------------------------------
-- -- Accelerometer Controller
-- ----------------------------------------------------------------------------------
Inst_AccelerometerCtl: AccelerometerCtl
generic map
    (
     SYSCLK_FREQUENCY_HZ   => 100000000,
     SCLK_FREQUENCY_HZ     => 100000,
     NUM_READS_AVG         => 16,
     UPDATE_FREQUENCY_HZ   => 1000
    )
    port map
    (
    SYSCLK     => clk_100MHz_buf,
    RESET      => reset, 
    -- Spi interface Signals
    SCLK       => sclk,
    MOSI       => mosi,
    MISO       => miso,
    SS         => ss,
    
    -- Accelerometer data signals
    ACCEL_X_OUT   => ACCEL_X,
    ACCEL_Y_OUT   => accelerometer_in, --ACCEL_Y,
    ACCEL_MAG_OUT => ACCEL_MAG,
    ACCEL_TMP_OUT => ACCEL_TMP
);
end Behavioral;

