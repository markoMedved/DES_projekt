library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vmesnik is
 port (
   clk  : in std_logic;
   sdata: in std_logic;
   clk1 : out std_logic;
	shld : out std_logic;
   tipke: out unsigned(11 downto 0);
	rot  : in unsigned(1 downto 0);
	set  : out unsigned(3 downto 0);
	pwm  : in std_logic;
	data : inout unsigned(7 downto 0);
	addr : out unsigned(1 downto 0)
 );
end vmesnik;

architecture RTL of vmesnik is
 signal del : unsigned(7 downto 0) := "00000000";
 signal adr : unsigned(1 downto 0);
 signal dout: unsigned(7 downto 0);
 signal en : std_logic := '0';
 
  -- komponenta vmesnika za 12 tipk
 component vmes is
  port ( clk : in std_logic;
         sdata : in std_logic;
         clk1 : out std_logic;
         shld : out std_logic;			
         tipka : out unsigned(11 downto 0) ); 
 end component;
 
 
 signal btn : unsigned(3 downto 0);
 signal tip : unsigned(11 downto 0);
 
 signal s : integer range 0 to 7 := 0;
 signal n : unsigned(3 downto 0) := "0000";
 
begin

process(clk)
begin
 if rising_edge(clk) then
  del <= del + 1;
  if del = 0 then
     en <= '1';
  else
     en <= '0';
  end if;
 end if;
end process;

-- vmesnik za tipkovnico, zamenjaj...
u0: vmes port map (
   clk=>clk, 
	sdata=>sdata,
   clk1=>clk1,
	shld=>shld,
	tipka=>tip);
	
-- vmesnik za razsiritveno plosco
u1:entity work.IOvmes port map(
   clk=>clk, 
	num=>btn, 
	din=>data(3 downto 0), 
	addr=>adr,	
	dout=>dout,
	btn=>btn );
	
 data <= dout when adr="10" else 
         "ZZ" & pwm & "ZZZZZ" when adr="11" else
			"ZZZZZZZZ";	
 addr <= adr;

 tipke <= resize(btn, 12) when tip=x"FFF" else tip or resize(btn, 12);
 
 
 process(clk)
 begin
 if rising_edge(clk) and en='1' then
  if s=0 then
     if rot="01" then s<=1;
     elsif rot="10" then s<=3;
     end if;
  elsif s=1 then
     if rot="01" then s<=1;
     elsif rot="11" then s<=2;
	  else s<=0; end if;
  elsif s=2 then 
     n <= n + 1; s<=5;
  elsif s=3 then
     if rot="10" then s<=3;
     elsif rot="11" then s<=4;
	  else s<=0; end if;	
  elsif s=4 then 
     n <= n - 1; s<=5;	  
  elsif s = 5 then
     if rot="00" then s<=0; end if;     
  else
     s <= 0;
  end if;
 end if;
 end process;
 
 set<=n;
 
end RTL;