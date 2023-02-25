----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/15/2022 06:55:42 PM
-- Design Name: 
-- Module Name: MPC - Behavioral
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

entity MPC is
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           BQ : in STD_LOGIC;
           CC0 : in STD_LOGIC;
           CC1 : in STD_LOGIC;
           Mc : in STD_LOGIC_VECTOR (0 to 3);
           MU : in STD_LOGIC_VECTOR (7 downto 0);
           NextAddress : out STD_LOGIC_VECTOR (7 downto 0));
end MPC;

architecture Behavioral of MPC is

signal NextAdr: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal MPC1: STD_LOGIC_VECTOR(7 downto 0)  := (others => '0');

begin

-- Output2
--NextAddress <= NextAdr when Mc(3) = '1' else "00000000";

-- Program counter -- bistabil D

process(Clk) -- scris diferit fata de GitHub, la mine ii cu Rst asincron
begin
    if rising_edge(Clk) then
        MPC1 <= NextAdr;
        if Mc(3) = '1' then
            NextAddress <= NextAdr;
        else 
            NextAddress <= "00000000";
        end if;

    end if;
    
    if Rst = '1' then
        MPC1 <= (others => '0');
    end if;
end process;


-- MUX
process(Clk, Mc)
begin
    case Mc(0 to 2) is
        when "110" => NextAdr <= MPC1 + 1; -- instr urm
        when "101" => 
             if (BQ = '1' and CC0 = '1') then
                 NextAdr <= MPC1 + MU; -- branch
             elsif (BQ = '0' and CC1 = '1') then
                 NextAdr <= MPC1 + MU; -- branch
             else
                 NextAdr <= MPC1 + 1; -- instr urm
             end if;
        NextAdr <= MPC1 + MU; -- branch
        when "001" => NextAdr <= MU; -- jump
        when others => NextAdr <= MPC1 + 1; -- instr urm
    end case;
end process;

end Behavioral;
