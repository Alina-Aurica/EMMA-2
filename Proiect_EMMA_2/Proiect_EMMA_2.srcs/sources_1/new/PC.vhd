----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/15/2022 06:36:09 PM
-- Design Name: 
-- Module Name: PC - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC is
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           En : in STD_LOGIC;
           BQ: in STD_LOGIC;
           CC0 : in STD_LOGIC;
           CC1 : in STD_LOGIC;
           Mc : in STD_LOGIC_VECTOR (0 to 3);
           Bus2 : in STD_LOGIC_VECTOR (15 downto 0);
           NextAddress : out STD_LOGIC_VECTOR (15 downto 0));
end PC;

architecture Behavioral of PC is

signal NextAdr: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal PC1: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

begin

-- Output2
--NextAddress <= NextAdr when Mc(3) = '1';

-- Program counter -- bistabil D
process(Clk) -- scris diferit fata de GitHub
begin
    if rising_edge(Clk) then
        if En = '1' then
            PC1 <= NextAdr;
            if Mc(3) = '1' then
                NextAddress <= NextAdr;
            end if;
        end if;
    end if;
    
    if Rst = '1' then
        PC1 <= (others => '0');
    end if;

end process;


-- MUX
process(Clk)
begin
    case Mc(0 to 2) is
        when "110" => NextAdr <= PC1 + 1; -- instr urm
        when "101" => 
            if (BQ = '1' and CC0 = '1') then
                NextAdr <= PC1 + Bus2; -- branch
            elsif (BQ = '0' and CC1 = '1') then
                NextAdr <= PC1 + Bus2; -- branch
            else
                NextAdr <= PC1 + 1; -- instr urm
            end if;
        when "001" => NextAdr <= Bus2; -- jump
        when others => NextAdr <= PC1 + 1; -- instr urm
    end case;
end process;


end Behavioral;
