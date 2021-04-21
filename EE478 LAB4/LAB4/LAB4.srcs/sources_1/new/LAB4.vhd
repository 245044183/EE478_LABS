----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/13/2019 03:19:36 PM
-- Design Name: 
-- Module Name: LAB4 - Behavioral
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

entity LAB4 is
    Port ( clk : in STD_LOGIC;
           start : in STD_LOGIC;
           mclk : out STD_LOGIC;
           bclk : out STD_LOGIC;
           mute : out STD_LOGIC;
           pblrc : out STD_LOGIC;
           pbdat : out STD_LOGIC);
end LAB4;

architecture Behavioral of LAB4 is
component ssm2603_i2s is
    Port ( clk : in STD_LOGIC;
           r_data : in STD_LOGIC_VECTOR (23 downto 0);
           l_data : in STD_LOGIC_VECTOR (23 downto 0);
           bclk : out STD_LOGIC;
           pbdat : out STD_LOGIC;
           pblrc : out STD_LOGIC;
           mclk : out STD_LOGIC;
           mute : out STD_LOGIC;
           ready : out STD_LOGIC);
end component;

signal mclk_sig             :std_logic;
signal l_data, r_data       :std_logic_vector(23 downto 0):=(others=>'0');
signal ready                :std_logic;
--signals for slow clk
signal count                :unsigned (23 downto 0):=(others=>'0');
signal oneHz_slow_clk       :std_logic:='0';
--signals for generating the audio square wave
signal tone_terminal_count  :unsigned (6 downto 0):=(others=>'0');
signal tone_counter         :unsigned (6 downto 0):=(others=>'0');
--clock cycle counts for 200 Hz, 400 Hz, 800 Hz, 1600 Hz
constant COUNT_C5           :unsigned(6 downto 0) := to_unsigned(91,7);--48kHz audio rate, 523Hz signal
constant COUNT_D5h          :unsigned(6 downto 0) := to_unsigned(77,7);--48kHz audio rate, 622Hz signal
constant COUNT_D5           :unsigned(6 downto 0) := to_unsigned(82,7);--48kHz audio rate, 587Hz signal
constant COUNT_B4           :unsigned(6 downto 0) := to_unsigned(98,7);--48kHz audio rate, 494Hz signal
constant COUNT_D4           :unsigned(6 downto 0) := to_unsigned(164,7);--48kHz audio rate, 294Hz signal
constant COUNT_A3           :unsigned(6 downto 0) := to_unsigned(219,7);--48kHz audio rate, 220Hz signal
constant COUNT_A5           :unsigned(6 downto 0) := to_unsigned(55,7);--48kHz audio rate, 880Hz signal
constant COUNT_C4           :unsigned(6 downto 0) := to_unsigned(184,7);--48kHz audio rate, 261Hz signal
constant COUNT_E5           :unsigned(6 downto 0) := to_unsigned(73,7);
constant COUNT_G5           :unsigned(6 downto 0) := to_unsigned(61,7);
constant COUNT_C6           :unsigned(6 downto 0) := to_unsigned(46,7);
constant COUNT_A4           :unsigned(6 downto 0) := to_unsigned(109,7);
--finite state machine
type state_type is (IDLE,NOTE1,NOTE2,NOTE3,NOTE4,NOTE5,NOTE6,NOTE7,NOTE8,NOTE9);
signal state: state_type:=IDLE;



begin

codec: ssm2603_i2s port map(
clk     =>  clk,
mclk    =>  mclk_sig,
bclk    =>  bclk,
mute    =>  mute,
pblrc   =>  pblrc,
pbdat   =>  pbdat,
l_data  =>  l_data,
r_data  =>  r_data,
ready   =>  ready
);
mclk    <=  mclk_sig;

slow_clk:process(mclk_sig)
    begin
        if rising_edge(mclk_sig) then
            if count=2 then --12288000  2
            count<=(others=>'0');
            oneHz_slow_clk<='1';
            else
            count<= count+1;
            oneHz_slow_clk<='0';
            end if;
         end if;
    end process;

tone_counter_proc: process(mclk_sig)
    begin
        if rising_edge(mclk_sig)then
            if ready='1' then
                if tone_counter=tone_terminal_count then
                tone_counter<=(others=>'0');
                else
                tone_counter<=tone_counter+1;
                end if;
            end if;
        end if;
    end process;

l_data <=(others=>'0')   when tone_counter<(tone_terminal_count/2) else  X"0FFFFF";
r_data <=(others=>'0')   when tone_counter<(tone_terminal_count/2) else  X"0FFFFF";

state_proc: process(mclk_sig)
    begin
        if rising_edge(mclk_sig) then
            case state is
                when IDLE =>
                    if start ='1' then
                        if oneHz_slow_clk='1' then
                        state<=NOTE1;
                        end if;
                    else
                        state<=IDLE;
                    end if;
                 when NOTE1 =>
                        if oneHz_slow_clk='1' then
                        state<=NOTE2;
                        end if;
                 when NOTE2 =>                 
                        if oneHz_slow_clk='1' then    
                        state<=NOTE3;
                        end if;    
                 when NOTE3 =>
                        if oneHz_slow_clk='1' then
                        state<=NOTE4;
                        end if;
                 when NOTE4 =>
                        if oneHz_slow_clk='1' then
                        state<=NOTE5;
                        end if;
                 when NOTE5 =>
                        if oneHz_slow_clk='1' then
                        state<=NOTE6;
                        end if;
                 when NOTE6 =>
                        if oneHz_slow_clk='1' then
                        state<=NOTE7;
                        end if;
                 when NOTE7 =>
                        if oneHz_slow_clk='1' then
                        state<=NOTE8;
                        end if;
                 when NOTE8 =>
                        if oneHz_slow_clk='1' then
                        state<=NOTE9;
                        end if;
                 when NOTE9 =>
                        if oneHz_slow_clk='1' then
                        state<=IDLE;
                        end if;
                end case;
            end if;
    end process;
    tone_terminal_count<=(others=>'0')  when state=IDLE else
    COUNT_E5                            when state=NOTE1 else
    COUNT_D5H                            when state=NOTE2 else
    COUNT_E5                            when state=NOTE3 else
    COUNT_D5H                            when state=NOTE4 else
    COUNT_E5                            when state=NOTE5 else
    COUNT_B4                            when state=NOTE6 else
    COUNT_D5                            when state=NOTE7 else
    COUNT_C5                            when state=NOTE8 else
    COUNT_A4                            when state=NOTE9;

    
    
end Behavioral;
