----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/15/2017 11:36:51 AM
-- Design Name: 
-- Module Name: position - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity position is
  Port ( change : in std_logic;
         gridx : out std_logic_vector(11 downto 0);
         gridy : out std_logic_vector(11 downto 0)

 );
end position;

architecture Behavioral of position is

signal chgAmount : std_logic_vector(2 downto 0) := "000";
--signal hello : std_logic_vector(11 downto 0);


begin
process(change)
begin
case chgAmount is
    when "000"  => gridx <= "000000000000";
    when "001"  => gridx <= "000000000010";
    when "010"  => gridx <= "000000000000";
    when "011"  => gridx <= "000000000010";
    when "100"  => gridx <= "000000000000";
    when "101"  => gridx <= "000000000010";
    when "110"  => gridx <= "000000000000";
    when "111"  => gridx <= "000000000010";

end case;

case chgAmount is
    when "000"  => gridy <= "000000000000";
    when "001"  => gridy <= "000000000010";
    when "010"  => gridy <= "000000000000";
    when "011"  => gridy <= "000000000010"; 
    when "100"  => gridy <= "000000000000";
    when "101"  => gridy <= "000000000010";
    when "110"  => gridy <= "000000000000";
    when "111"  => gridy <= "000000000010";

end case;

chgAmount <= chgAmount + '1';



end process;

end Behavioral;
