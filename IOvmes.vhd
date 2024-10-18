library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity IOvmes is
 port (
   clk : in std_logic;
   num : in unsigned(3 downto 0);
	din : in unsigned(3 downto 0);
	wr: out std_logic;
	addr : out unsigned(1 downto 0);
   dout : out unsigned(7 downto 0);
	btn  : out unsigned(3 downto 0)
   );
end IOvmes;

architecture RTL of IOvmes is
 signal a : unsigned(6 downto 0);
 signal b : unsigned(4 downto 0);
 signal c : unsigned(7 downto 0);
 signal adr : unsigned(1 downto 0) := "01";
 signal t : unsigned(3 downto 0);
 signal st : unsigned(2 downto 0) := "000";
 type rom_type is array (0 to 127) of unsigned(4 downto 0);
 constant rom : rom_type := (
        "01110", --   #  
        "10001", --  # #
        "10001", -- #   #
        "10001", -- #   #
        "10001", -- #   #
        "10001", --  # #
        "01110", --   #
		  "00000",
        "00100", --   #
        "01100", --  ##
        "10100", -- # #
        "00100", --   #
        "00100", --   #
        "00100", --   #
        "11111", -- #####
		  "00000",
        "01110", --  ###
        "10001", -- #   #
        "00010", --    #
        "00100", --   #
        "01000", --  #
        "10000", -- #
        "11111", -- #####
        "00000",
        "11111", -- #####
        "00010", --    #
        "00100", --   #
        "01110", --  ###
        "00001", --     #
        "10001", -- #   #
        "01110", --  ###
        "00000",
        "00010", --    #
        "00110", --   ##
        "01010", --  # #
        "10010", -- #  #
        "11111", -- #####
        "00010", --    #
        "00010", --    #
        "00000",
        "11111", -- #####
        "10000", -- #
        "11110", -- ####
        "00001", --     #
        "00001", --     #
        "10001", -- #   #
        "01110", --  ###
        "00000",
        "00111", --   ###
        "01000", --  #
        "10000", -- #
        "11110", -- ####
        "10001", -- #   #
        "10001", -- #   # 
        "01110", --  ###
        "00000",
        "11111", -- #####
        "10001", -- #   #
        "00010", --    #
        "00100", --   #
        "00100", --   #
        "00100", --   # 
        "00100", --   #
        "00000",
        "01110", --  ###
        "10001", -- #   #
        "10001", -- #   #
        "01110", --  ###
        "10001", -- #   #
        "10001", -- #   #
        "01110", --  ###
        "00000",
        "01110", --  ###
        "10001", -- #   #
        "10001", -- #   #
        "01111", --  ####
        "00001", --     #
        "10001", -- #   #
        "01110", --  ###
        "00000",
        "00100", --  #
        "01110", -- ###
        "10001", --#   #
        "10001", --#   #
        "11111", --#####
        "10001", --#   #
        "10001", --#   #
        "00000",
        "11110", --####
        "10001", --#   #
        "10001", --#   #
        "11110", --####
        "10001", --#   #
        "10001", --#   #
        "11110", --####
        "00000",
        "00110", --  ## 
        "01001", -- #  #
        "10000", --#
        "10000", --#
        "10000", --#
        "01001", -- #  #
        "00110", --  ##
		  "00000",
        "11100", --###
        "10010", --#  #
        "10001", --#   #  
        "10001", --#   #
        "10001", --#   #
        "10010", --#  #
        "11100", --###
        "00000",
        "11111", --#####
        "10000", --#
        "10000", --#
        "11111", --#####
        "10000", --#
        "10000", --#
        "11111", --#####
        "00000",
        "11111", --#####
        "10000", --#
        "10000", --#
        "11100", --###
        "10000", --#
        "10000", --#
        "10000",  --#
		  "00000");
 signal d : unsigned(1 downto 0) := "00";
begin

wr <= '1' when adr="10" else '0';
a <= (num or t) & st;
b <= rom(to_integer(a));

dout <= (st+1) & b(0) & b(1) & b(2) & b(3) & b(4);
addr <= adr;


process(clk)
begin
 if rising_edge(clk) then
  if adr="11" then 
   adr <= "01";
  else
   adr <= adr + 1;
  end if;
 
  if adr="01" then t <= din; end if;
 
  d <= d + 1;
  if d = 3 then
     if st = 6 then
        st <= to_unsigned(0, 3);
     else
        st <= st + 1;
     end if;
  end if;
 end if;
end process;

btn <= t;

end RTL;

