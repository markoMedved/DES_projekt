

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity gen3 is
 port (
   clk : in std_logic;
   data : out signed(7 downto 0);
   korak : in unsigned(15 downto 0);
   en : in std_logic );
end gen3;

architecture RTL of gen3 is
 signal st : unsigned(15 downto 0) := to_unsigned(0,16);
 signal adr : unsigned(3 downto 0);
 type tab_type is array (0 to 15) of signed(7 downto 0);
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
   15=> "01111111");
begin

process(st)
begin
  if st(14) = '1' then
     adr <= not st(13 downto 10);
  else
     adr <= st(13 downto 10);
  end if;
  data <= tab(to_integer(adr));
  if st(15) /= '0' then
     data <= - tab(to_integer(adr));
  end if;
end process;

process(clk)
begin
 if rising_edge(clk) then
  if en = '1' then
     st <= st + korak;
  end if;
 end if;
end process;

end RTL;



