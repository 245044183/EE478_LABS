----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/23/2019 09:20:36 AM
-- Design Name: 
-- Module Name: lab2 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lab2 is
    Port ( A : in STD_LOGIC_VECTOR (1 downto 0);
           B : in STD_LOGIC_VECTOR (1 downto 0);
           S : in STD_LOGIC_VECTOR (3 downto 0);
           Y : out STD_LOGIC_VECTOR (3 downto 0));
end lab2;

architecture Behavioral of lab2 is

signal A_signed : signed(1 downto 0);
signal B_signed : signed(1 downto 0);
signal Y_signed : signed(3 downto 0);
signal A_unsigned : unsigned(1 downto 0);
signal B_unsigned : unsigned(1 downto 0);
signal Y_unsigned : unsigned(3 downto 0);
signal compare : std_logic;
signal asr: std_logic_vector(1 downto 0);



begin

A_signed <= signed(A);
B_signed <= signed(B);

A_unsigned <= unsigned(A);
B_unsigned <= unsigned(B);

asr <= A when B = "00" else
A(1) & A(1); 


compare <= '1' when A > B else '0';

Y <= "00" & std_logic_vector(A_signed + B_signed) when S(0) = '1' else
"00" & asr when S(1) ='1' else
std_logic_vector(A_unsigned * B_unsigned) when S(2) ='1' else
"00" & (A xor B) when S(3) ='1' else
"000" & compare;


end Behavioral;
