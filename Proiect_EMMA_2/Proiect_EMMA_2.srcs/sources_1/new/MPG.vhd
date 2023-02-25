----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2022 01:33:24 PM
-- Design Name: 
-- Module Name: MPG - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MPG is --cel de la AC
    Port ( Clk : in STD_LOGIC;
           input : in STD_LOGIC;
           En : out STD_LOGIC);
end MPG;

architecture Behavioral of MPG is

signal count_int : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
signal Q1 : STD_LOGIC := '0';
signal Q2 : STD_LOGIC := '0';
signal Q3 : STD_LOGIC := '0';

begin

    En <= Q2 AND (not Q3);

    process (Clk)
    begin
        if rising_edge(Clk) then
            count_int <= count_int + 1;
        end if;
    end process;


    process (Clk) --bistabil 1
    begin
        if rising_edge(Clk) then
            if count_int(15 downto 0) = "1111111111111111" then
                Q1 <= input;
            end if;
        end if;
    end process;

    process (Clk) --bistabil 2 si 3
    begin
        if rising_edge(Clk) then
            Q2 <= Q1;
            Q3 <= Q2;
        end if;
    end process;

end Behavioral;