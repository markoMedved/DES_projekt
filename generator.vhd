library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity generator is
 port (
   clk : in std_logic;
   set : in unsigned(3 downto 0); 
   dat1, dat2, dat3, dat4,dat5, dat6,dat7,dat8,dat9,dat10,dat11,dat12: out signed(7 downto 0)
 );
end generator;

architecture RTL of generator is
 signal en : std_logic;
 signal st : unsigned(8 downto 0) := to_unsigned(0,9);
 
 component gen is
 port (
   clk : in std_logic;
   en  : in std_logic;
   korak : in unsigned(15 downto 0);
set : in unsigned(3 downto 0);
   data : out signed(7 downto 0) );

 end component;
 


begin

 
process(clk)
begin
 if rising_edge(clk) then
  if st = 499 then
     st <= to_unsigned(0, 9);
     en <= '1';
  else
     st <= st + 1;
     en <= '0';
  end if;
 end if;
end process;

 
 g1: gen port map(
  clk  => clk,
  en   => en,
  korak=> to_unsigned(172, 16),
  set => set,
  data => dat1
 );

 g2: gen port map(
  clk  => clk,
  en   => en,
  korak=> to_unsigned(180, 16),
   set => set,
  data => dat2
 );
 
 g3: gen port map(
  clk  => clk,
  en   => en,
  korak=> to_unsigned(193, 16),
  set => set,
  data => dat3
 );

 g4: gen port map(
  clk  => clk,
  en   => en,
  korak=> to_unsigned(205, 16),
   set => set,
  data => dat4
 );
 
  g5: gen port map(
  clk  => clk,
  en   => en,
  korak=> to_unsigned(216, 16),
   set => set,
  data => dat5
 );
  g6: gen port map(
  clk  => clk,
  en   => en,
  korak=> to_unsigned(229, 16),
   set => set,
  data => dat6
 );
  g7: gen port map(
  clk  => clk,
  en   => en,
  korak=> to_unsigned(243, 16),
   set => set,
  data => dat7
 );
  g8: gen port map(
  clk  => clk,
  en   => en,
  korak=> to_unsigned(257, 16),
   set => set,
  data => dat8
 );
  g9: gen port map(
  clk  => clk,
  en   => en,
  korak=> to_unsigned(275, 16),
   set => set,
  data => dat9
 );
 g10: gen port map(
  clk  => clk,
  en   => en,
  korak=> to_unsigned(288, 16),
   set => set,
  data => dat10
 );
 g11: gen port map(
  clk  => clk,
  en   => en,
  korak=> to_unsigned(305, 16),
   set => set,
  data => dat11
 );
 g12: gen port map(
  clk  => clk,
  en   => en,
  korak=> to_unsigned(324, 16),
   set => set,
  data => dat12
 );
end RTL;