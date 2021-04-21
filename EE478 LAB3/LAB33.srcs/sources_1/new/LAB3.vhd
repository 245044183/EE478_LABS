----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/30/2019 09:44:09 AM
-- Design Name: 
-- Module Name: LAB3 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LAB3 is
    Port ( clk : in STD_LOGIC;
           switch : in STD_LOGIC;
           reset : in STD_LOGIC;
           Y : out std_logic_vector (3 downto 0));
end LAB3;

architecture Behavioral of LAB3 is
signal slow_clk: std_logic:='0';
signal leds_int: signed(3 downto 0):="0000";
signal count: unsigned(27 downto 0):=(others=>'0');
begin

slow_clock: process(clk)
begin
    if rising_edge(clk) then
        if count=10 then -- change 10 to 125 MHz on board
        slow_clk<='1';
        count<=  (others => '0');
        else
        count<=count+1;
        slow_clk<='0';
        end if;
    end if;
end process;

count_proc : process(clk)
begin
    if rising_edge(clk) then
        if slow_clk='1' then
            if reset='1' then
                leds_int<="0000";
            else
                if(switch='1') then
                   if (leds_int<7) then
                    leds_int<=leds_int+1;
--                   else
--                    leds_int<=leds_int;
                   end if;
                
                else
--                    (switch='0') then
                   if (leds_int>-8) then
                    leds_int<=leds_int-1;
--                   else
--                    leds_int<=leds_int;
                   end if;
                end if;
                 
            end if;
        
        end if;
    end if;
end process;

Y<=std_logic_vector(leds_int);

end Behavioral;
