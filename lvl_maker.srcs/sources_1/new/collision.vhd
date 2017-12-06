----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2017 01:34:02 PM
-- Design Name: 
-- Module Name: collision - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity collision is
    Port (  xpos : in std_logic_vector(11 downto 0);
            ypos : in std_logic_vector(11 downto 0);
            --counter : in std_logic_vector(3 downto 0);
            clk  : in std_logic;
            hit : out std_logic;
            count : out std_logic_vector(3 downto 0);
            ready : in std_logic

             );
end collision;

architecture Behavioral of collision is

signal counter : std_logic_vector(3 downto 0);
signal collide : std_logic := '0';
signal counter2 : std_logic_vector(3 downto 0) := "0001";
signal ready1 : std_logic;
signal moveCount : std_logic_vector(19 downto 0);



begin

ready1 <= not ready;

process (clk)

begin
counter <= counter2;
  --case counter is
    --when "0001" => 
	if (ypos <= "001110111111" and ypos >= "001110111011" and ready1 = '1') then
                        --if (xpos >="000110111000" and xpos <= "000111100000") then
                            collide <= '1';
                            counter2 <= counter2 + '1';
                        --end if;
                       -- else 
                       --     collide <= '0';
                   --end if;
    --when "0010" => 
	elsif (ypos <= "001110000100" and ypos >= "001110000000" and ready1 = '1') then
                       -- if (xpos >="000000000100" and xpos <= "000100101100") then
                            collide <= '1';
                            counter2 <= counter2 + '1';
                       -- end if;
                       -- else 
                       --     collide <= '0';
                    --end if;
   -- when "0011" => 
	elsif (ypos <= "001100110100" and ypos >= "001100110000" and ready1 = '1') then
                       -- if (xpos >="000110001100" and xpos <= "000110110100") then
                             collide <= '1';
                             counter2 <= counter2 + '1';
                        --end if;
                       -- else
                       --     collide <= '0';
                   --end if;
    --when "0100" => 
	elsif (ypos <= "001011111000" and ypos >= "001011110100" and ready1 = '1') then
                        -- if (xpos >="001001000000" and xpos <= "001001101000") then
                              collide <= '1';
                              counter2 <= counter2 + '1';
                        --end if;
                        -- else
                        --    collide <= '0';
                    --end if;
    --when "0101" => 
	elsif (ypos <= "001010111100" and ypos >= "001010111000" and ready1 = '1') then
                        -- if (xpos >="001011110100" and xpos <= "001100011100") then
                              collide <= '1';
                              counter2 <= counter2 + '1';
                        -- end if;
                       --  else
                       --     collide <= '0';
                   -- end if;
    --when "0110" => 
	elsif (ypos <= "001010000000" and ypos >= "001001111100" and ready1 = '1') then
                         --if (xpos >="001101001000" and xpos <= "001101110000") then
                              collide <= '1';
                              counter2 <= counter2 + '1';
                        -- end if;
                       --  else
                       --     collide <= '0';
                   -- end if;                                                                                                                                                      
    --when "0111" => 
	elsif (ypos <= "001001010000" and ypos >= "001001001100" and ready1 = '1') then
                        -- if (xpos >="001111111100" and xpos <= "010000010000") then
                              collide <= '1';
                              counter2 <= counter2 + '1';
                         --end if;
                       --  else
                       --   collide <= '0';
                   -- end if;
    --when "1000" => 
	elsif (ypos <= "001000010011" and ypos >= "001000001111" and ready1 = '1') then
                        -- if (xpos >="001100100000" and xpos <= "001101001000") then
                              collide <= '1';
                              counter2 <= counter2 + '1';
                        -- end if;
                       --  else
                        --    collide <= '0';
                   -- end if;
    --when "1001" => 
	elsif (ypos <= "000111010111" and ypos >= "000111010011" and ready1 = '1') then
                      -- if (xpos >="001001101100" and xpos <= "001010010100") then
                            collide <= '1';
                            counter2 <= counter2 + '1';
                      -- end if;
                     --  else
                      --  collide <= '0';
                  -- end if;
    --when "1010" => 
	elsif (ypos <= "000110011011" and ypos >= "000110010111" and ready1 = '1') then
                      -- if (xpos >="001000001000" and xpos <= "001000110000") then
                            collide <= '1';
                            counter2 <= counter2 + '1';
                      -- end if;
                    --   else
                     --   collide <= '0';
                   -- end if;
    --when "1011" => 
	elsif (ypos <= "000101101100" and ypos >= "000101101000" and ready1 = '1') then
                      --  if (xpos >="000101010100" and xpos <= "000101111100") then
                            collide <= '1';
                            counter2 <= counter2 + '1';
                     --   end if;
                    --    else
                    --        collide <= '0';
                  -- end if;
    --when "1100" => 
	elsif (ypos <= "000100110000" and ypos >= "000100101100" and ready1 = '1') then
                     --  if (xpos >="000111110100" and xpos <= "001000011100") then
                           collide <= '1';
                           counter2 <= counter2 + '1';
                     --  end if;
                    --   else
                     --   collide <= '0';
                     
     else
            collide <= '0';
                   end if;  
   -- when others => null;                
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
--end case;
hit <= collide;

end process;

process(clk)
begin
if clk'event and clk = '1' then
           moveCount <= moveCount + '1';
         if (moveCount >= "11111111111111111110") then
            count <= counter;
            moveCount <= moveCount - moveCount;
         end if;
end if;
end process;

end Behavioral;
