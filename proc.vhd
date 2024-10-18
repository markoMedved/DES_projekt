library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity proc is
 port (
   clk  : in std_logic;
   ton : in unsigned(11 downto 0);	
   dat1, dat2, dat3, dat4, dat5, dat6, dat7, dat8, dat9, dat10, dat11, dat12 : in signed(7 downto 0);
   zvok : out signed(7 downto 0)
 );
end proc;

architecture RTL of proc is
 signal d1, d2, d3, d4,d5,d6,d7,d8,d9,d10,d11,d12: signed(7 downto 0);
 signal sum: signed(9 downto 0);
begin

 d1 <= dat1 when ton(0)='1' else "00000000";
 d2 <= dat2 when ton(1)='1' else "00000000";
 d3 <= dat3 when ton(2)='1' else "00000000";
 d4 <= dat4 when ton(3)='1' else "00000000";
 d5 <= dat5 when ton(4)='1' else "00000000";
 d6 <= dat6 when ton(5)='1' else "00000000";
 d7 <= dat7 when ton(6)='1' else "00000000";
 d8 <= dat8 when ton(7)='1' else "00000000";
 d9 <= dat9 when ton(8)='1' else "00000000";
 d10 <= dat10 when ton(9)='1' else "00000000";
 d11 <= dat11 when ton(10)='1' else "00000000";
 d12 <= dat12 when ton(11)='1' else "00000000";


  



 sum <= resize(d1, 10) + d2 + d3 + d4+ d5+ d6+ d7+ d8+ d9+ d10+ d11+ d12;
 zvok <= sum(9 downto 2);

 
end RTL;