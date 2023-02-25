----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2022 11:16:00 PM
-- Design Name: 
-- Module Name: Microcode_Unit_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Microcode_Unit_tb is
--  Port ( );
end Microcode_Unit_tb;

architecture Behavioral of Microcode_Unit_tb is

signal IR : STD_LOGIC_VECTOR (31 downto 0) := (others => '0') ;
signal Mc : STD_LOGIC_VECTOR (0 to 7) := (others => '0');
signal AdrMC : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal AdrD : STD_LOGIC_VECTOR (3 downto 0);
signal AdrSA : STD_LOGIC_VECTOR (3 downto 0); 
signal AdrSB : STD_LOGIC_VECTOR (3 downto 0); 
signal InBus1 : STD_LOGIC_VECTOR (15 downto 0); 
signal InBus2 : STD_LOGIC_VECTOR (15 downto 0); 
signal InMPC : STD_LOGIC_VECTOR (7 downto 0); 
signal Micro: STD_LOGIC_VECTOR (31 downto 0); 

begin

DUT: entity WORK.Microcode_Unit port map (IR, Mc, AdrMC, AdrD, AdrSA, AdrSB, InBus1, InBus2, InMPC, Micro);

gen_vect_test: 
process 
begin
        
        IR <= "00001001001100010010000000000000"; 
        Mc <= "01110000";
        AdrMc <= (others => '0');
        wait;
        
end process;


end Behavioral;
