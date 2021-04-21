----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/23/2019 09:33:43 AM
-- Design Name: 
-- Module Name: lab2_tbench - Behavioral
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

entity lab2_tbench is
--  Port ( );
end lab2_tbench;

architecture Behavioral of lab2_tbench is

component lab2 is
port (  A : in STD_LOGIC_VECTOR (1 downto 0);
        B : in STD_LOGIC_VECTOR (1 downto 0);
        S : in STD_LOGIC_VECTOR (3 downto 0);
        Y : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal A : STD_LOGIC_VECTOR (1 downto 0);
signal        B : STD_LOGIC_VECTOR (1 downto 0);
signal  S : STD_LOGIC_VECTOR (3 downto 0);
signal   Y :  STD_LOGIC_VECTOR (3 downto 0);




begin

uut : lab2 port map (
A => A,
B => B,
S => S,
Y => Y
);

sim_proc : process
begin
wait for 100 ns;
A <= "01";
B <= "01";
S <= "0001";
wait for 100 ns;
A <= "01";
B <= "01";
S <= "0010";
wait for 100 ns;
A <= "01";
B <= "01";
S <= "0100";
wait for 100 ns;
A <= "01";
B <= "01";
S <= "1000";
wait for 100 ns;
A <= "11";
B <= "10";
S <= "0000";
wait;
end process sim_proc;

end Behavioral;
