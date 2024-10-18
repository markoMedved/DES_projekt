library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pulzmod is
 port (
   clk : in std_logic;
   data : in signed(7 downto 0);
   pwm : out std_logic );
end pulzmod;

architecture RTL of pulzmod is
 signal c : unsigned(7 downto 0) := to_unsigned(0,8);
begin

 -- delilnik ure za signal en (f=100 kHz)
 deli: process(clk)
 begin
 if rising_edge(clk) then
      c <= c + 1;
 end if;
 end process;

 pwm <= '1' when c(7 downto 0) < unsigned(data xor "10000000") else '0';

end RTL;