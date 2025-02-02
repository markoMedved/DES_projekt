

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity gen4 is
 port (
   clk : in std_logic;
   data : out signed(7 downto 0);
   korak : in unsigned(15 downto 0);
   en : in std_logic );
end gen4;

architecture RTL of gen4 is
 signal st : unsigned(15 downto 0) := to_unsigned(0,16);
begin

process(st)
begin
  data <= to_signed(127, 8);
  if st(15) /= '0' then
     data <= to_signed(-127, 8);
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



