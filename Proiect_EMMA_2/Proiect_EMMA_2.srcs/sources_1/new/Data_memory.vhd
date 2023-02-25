----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2022 07:57:31 PM
-- Design Name: 
-- Module Name: Data_memory - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Data_memory is
  Port (Clk: in STD_LOGIC;
        Mc: in STD_LOGIC_VECTOR(0 to 3); -- pe baza lui se formeaza bus-urile
        MAR_in: in STD_LOGIC_VECTOR(15 downto 0);
        MBR_in: in STD_LOGIC_VECTOR(15 downto 0);
        MBR_out: out STD_LOGIC_VECTOR(15 downto 0)
   );
end Data_memory;

architecture Behavioral of Data_memory is

signal MAR_input: STD_LOGIC := '0'; -- flaguri 
signal MBR_input: STD_LOGIC := '0'; -- pentru
signal MBR_output: STD_LOGIC := '0'; -- fazele ceasului
signal Read_Write: STD_LOGIC := '0'; -- flag read & write
signal MBR_int: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal aux: STD_LOGIC_VECTOR(5 downto 0) := "000001";

type RAM_type is array (0 to 31) of STD_LOGIC_VECTOR(15 downto 0);
signal RAM: RAM_type := (
     X"0000", X"0001", X"0002", X"0003", 
     X"0004", X"0005", X"0006", X"0007", 
     X"0008", X"0009", X"000A", X"000B", 
     X"000C", X"000D", X"000E", X"000F",
     X"0010", X"0011", X"0012", X"0013", 
     X"0014", X"0015", X"0016", X"0017", 
     X"0018", X"0019", X"001A", X"001B", 
     X"001C", X"001D", X"001E", X"001F",
     others => X"0000");

begin

MAR_input <= Mc(3);
MBR_input <= Mc(2);
Read_Write <= Mc(1);
MBR_output <= Mc(0);


--MBR_out <= RAM(conv_integer(MAR_in(5 downto 0)));
--MBR_OUT <= x"0000";

process(Clk)
begin

    if rising_edge(Clk) then
        if Read_Write = '1' and MAR_input = '1' and MBR_input = '1' then -- write
            RAM(conv_integer(MAR_in(5 downto 0))) <= MBR_in;
        elsif Read_Write = '0' and MAR_input = '1' then -- read phase 0
            --aux <= "000001";
            --MBR_out <= RAM(conv_integer(MAR_in(5 downto 0)));
            MBR_int <= RAM(conv_integer(MAR_in(5 downto 0)));
        end if;
    end if;
    
    if falling_edge(Clk) then -- read phase 1
        if Read_Write = '0' and MBR_output = '1' then
            MBR_out <= MBR_int;
        end if;
    end if;        
       
end process;


end Behavioral;
