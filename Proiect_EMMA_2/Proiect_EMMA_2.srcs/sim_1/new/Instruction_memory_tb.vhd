----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2022 04:35:33 PM
-- Design Name: 
-- Module Name: Instruction_memory_tb - Behavioral
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

entity Instruction_memory_tb is
--  Port ( );
end Instruction_memory_tb;

architecture Behavioral of Instruction_memory_tb is

signal Address : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal Instruction : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');

begin

DUT: entity WORK.Instruction_memory port map (Address, Instruction);

gen_vect_test: 
process
begin
        --wait for 100 ns;
        
        Address <= CONV_STD_LOGIC_VECTOR(0, 16);            
        wait for 10 ns;
        
        
        Address <= CONV_STD_LOGIC_VECTOR(4, 16);
        wait for 10 ns;
          
        wait;
        
end process;

end Behavioral;
