library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity gen is
 port (
   clk : in std_logic;
   data : out signed(7 downto 0);
   set : in unsigned(3 downto 0);
   korak : in unsigned(15 downto 0);
   en : in std_logic );
end gen;

architecture RTL of gen is
 signal st : unsigned(15 downto 0) := to_unsigned(0,16);
 signal stZaga : unsigned(15 downto 0) := to_unsigned(0,16);
 signal adr : unsigned(3 downto 0);
 type sin_type is array (0 to 15) of signed(7 downto 0);
 constant sin : sin_type := (
   0=> "00000110",
   1=> "00010110",
   2=> "00100101",
   3=> "00110000",
   4=> "00111100",
   5=> "01000111",
   6=> "01010001",
   7=> "01011010",
   8=> "01100010",
   9=> "01101001",
   10=> "01110000",
   11=> "01110101",
   12=> "01111010",
   13=> "01111100",
   14=> "01111110",
   15=> "01111111");
 type trikotnik_type is array (0 to 15) of signed(7 downto 0);
 constant trikotnik : trikotnik_type := (
   0=> "00000100",
   1=> "00001101",
   2=> "00010110",
   3=> "00011110",
   4=> "00100110",
   5=> "00101110",
   6=> "00110110",
   7=> "00111110",
   8=> "01000110",
   9=> "01001110",
   10=> "01010110",
   11=> "01100000",
   12=> "01100110",
   13=> "01101110",
   14=> "01110111",
   15=> "01111111");
begin

process(set,st,stZaga)
begin
  adr <= to_unsigned(0, 4);
  if set = 0 then
     if st(14) = '1' then
        adr <= not st(13 downto 10);
     else
        adr <= st(13 downto 10);
     end if;
     data <= sin(to_integer(adr));
     if st(15) /= '0' then
        data <= - sin(to_integer(adr));
     end if;
  elsif set = 1 then
     data <= resize(signed((shift_right(stZaga,8))),8);
  elsif set = 2 then
     if st(14) = '1' then
        adr <= not st(13 downto 10);
     else
        adr <= st(13 downto 10);
     end if;
     data <= trikotnik(to_integer(adr));
     if st(15) /= '0' then
        data <= - trikotnik(to_integer(adr));
     end if;
  else
     data <= to_signed(127, 8);
     if st(15) /= '0' then
        data <= to_signed(-127, 8);
     end if;
  end if;
end process;

process(clk)
begin
 if rising_edge(clk) then
  if en = '1' then
     st <= st + korak;
     stZaga <= stZaga + (shift_right(korak,1));
  end if;
 end if;
end process;

end RTL;






