-- Projekt: DES, sintetizator zvoka 2023

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sint is
 port (
	clk  : in std_logic;  -- sistemska ura	
	clk1 : out std_logic; -- tipkovnica	
	sdata: in std_logic;
	shld : out std_logic;			
	pwm1 : out std_logic; -- PWM in rotac. kodirnik
	rot  : in unsigned(1 downto 0);	
	data : inout unsigned(7 downto 0); -- IO modul
	addr : out unsigned(1 downto 0); 
	clkout: out std_logic;	
	led  : out unsigned(7 downto 0) -- LED
 );
end sint;

architecture RTL of sint is 
 signal tipke: unsigned(11 downto 0);-- stanje tipk
 signal set : unsigned(3 downto 0);  -- rotac enkoder
 
 signal dat1, dat2, dat3, dat4,dat5,dat6,dat7,dat8,dat9,dat10,dat11,dat12: signed(7 downto 0); 
 signal zvok: signed(7 downto 0); -- sestavljen zvok
 signal pwm: std_logic;
begin
 
----------------------------------------------------
-- TESTNI vmesnik (zamenja 1. skupina)
--  vmesnik tipkovnice: sdata, clk1, shld, tipka
--  razsiritveni modul: data, dout, adr
 u1: entity work.vmesnik port map (
	clk   => clk, 
	sdata => sdata,
	clk1  => clk1,
	shld  => shld,
	tipke => tipke,
	rot   => rot,
	set   => set,
	pwm   => pwm,
	data  => data,
	addr  => addr
	);

 
 clkout <= clk; -- ura za IO modul 
 led <= set & tipke(3 downto 0); -- LED = tipke

----------------------------------------------------
-- TESTNI generator (zamenja 2. skupina)
-- izhod: 4 toni (C,D,E,F)
 u2: entity work.generator port map(
	clk => clk,
	set => set,
	dat1 => dat1,
	dat2 => dat2,
	dat3 => dat3,
	dat4 => dat4,
	dat5 => dat5,
	dat6 => dat6,
	dat7 => dat7,
	dat8 => dat8,
	dat9 => dat9,
	dat10 => dat10,
	dat11 => dat11,
	dat12 => dat12
 );
----------------------------------------------------
-- TESTNA obdelava zvoka (zamenja 3. skupina)
 u3: entity work.proc port map(
	clk => clk,
	ton => tipke(11 downto 0),
	dat1 => dat1,
	dat2 => dat2,
	dat3 => dat3,
	dat4 => dat4,
	dat5 => dat5,
	dat6 => dat6,
	dat7 => dat7,
	dat8 => dat8,
	dat9 => dat9,
	dat10 => dat10,
	dat11 => dat11,
	dat12 => dat12,
	zvok => zvok
 );       
 
 
----------------------------------------------------
-- izhodni pulzno-sirinski modulator

 u4: entity work.pulzmod port map(
	clk => clk,
	data => zvok,
	pwm => pwm
 );	

 pwm1 <= pwm; -- dodaten izhod (zgornja plosca)
  
end RTL;