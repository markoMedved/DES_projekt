

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity gen2 is
 port (
   clk : in std_logic;
   data : out signed(7 downto 0);
   korak : in unsigned(15 downto 0);
   en : in std_logic );
end gen2;

architecture RTL of gen2 is
 signal st : unsigned(15 downto 0) := to_unsigned(0,16);
 signal adr : unsigned(4 downto 0);
 type tab_type is array (0 to 31) of signed(7 downto 0);
 constant tab : tab_type := (
   0=> "00001000",
   1=> "00010000",
   2=> "00011000",
   3=> "00100000",
   4=> "00101000",
   5=> "00110000",
   6=> "00111000",
   7=> "01000000",
   8=> "01000111",
   9=> "01001111",
   10=> "01010111",
   11=> "01011111",
   12=> "01100111",
   13=> "01101111",
   14=> "01111000",
   15=> "01111111",
   16=> "10000111",
   17=> "10001111",
   18=> "10010111",
   19=> "10011111",
   20=> "10100111",
   21=> "10101111",
   22=> "10110111",
   23=> "10111111",
   24=> "11000111",
   25=> "11001111",
   26=> "11010111",
   27=> "11011111",
   28=> "11100111",
   29=> "11101111",
   30=> "11110111",
   31=> "11111111");
begin
adr <= st(13 downto 9);
data <= tab(to_integer(adr));

process(clk)
begin
 if rising_edge(clk) then
  if en = '1' then
     st <= st + korak;
  end if;
 end if;
end process;

end RTL;

