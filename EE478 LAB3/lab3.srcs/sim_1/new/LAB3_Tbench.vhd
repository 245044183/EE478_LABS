----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/07/2019 09:09:19 AM
-- Design Name: 
-- Module Name: LAB3_Tbench - Behavioral
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

entity LAB3_Tbench is
--  Port ( );
end LAB3_Tbench;

architecture Behavioral of LAB3_Tbench is
component lab3 is
    Port ( clk : in STD_LOGIC;
           switch : in STD_LOGIC;
           reset : in STD_LOGIC;
           Y : out std_logic_vector (3 downto 0));
end component;
           
signal clk: STD_LOGIC:='0';
signal switch:STD_LOGIC:='0';
signal reset: STD_LOGIC:='0';
signal Y: STD_LOGIC_VECTOR (3 downto 0):="0000";

begin

uut: lab3 port map(
clk => clk,
switch=> switch,
reset=> reset,
Y => Y
);

clk_proc: process
begin
    wait for 4 ns;
    clk<= not clk;
end process clk_proc;

sim_proc: process
begin
switch<='0';
reset<='0';
wait for 800 ns;
switch<='1';
reset<='0';
wait for 800 ns;
switch<='0';
reset<='0';
--wait for 100 ns;
--switch<='0';
--reset<='0';
--wait for 100 ns;
--switch<='1';
--reset<='1';
wait;
end process sim_proc;



end Behavioral;
