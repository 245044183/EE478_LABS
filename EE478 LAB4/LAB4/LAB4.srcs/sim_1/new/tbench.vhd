----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/23/2019 07:23:28 PM
-- Design Name: 
-- Module Name: tbench - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tbench is
--  Port ( );
end tbench;

architecture Behavioral of tbench is
component LAB4 is
port (     clk  : in STD_LOGIC;
           start : in STD_LOGIC;
           mclk : out STD_LOGIC;
           bclk : out STD_LOGIC;
           mute : out STD_LOGIC;
           pblrc : out STD_LOGIC;
           pbdat : out STD_LOGIC);

end component;

signal           clk    :STD_LOGIC:='0';
signal           start :  STD_LOGIC:='0';
signal           mclk :  STD_LOGIC:='0';
signal           bclk :  STD_LOGIC:='0';
signal           mute :  STD_LOGIC:='0';
signal           pblrc :  STD_LOGIC:='0';
signal           pbdat :  STD_LOGIC:='0';


begin


uut: LAB4 port map(
clk=>clk,
start=>start,
mclk=>mclk,
bclk=>bclk,
mute=>mute,
pblrc=>pblrc,
pbdat=>pbdat
);

clk_proc: process
begin
    wait for 4 ns;
    clk<= not clk;
end process clk_proc;

--sim_proc: process
--begin
--wait for 10 ns;
--start<='1';

--end process;

end Behavioral;
