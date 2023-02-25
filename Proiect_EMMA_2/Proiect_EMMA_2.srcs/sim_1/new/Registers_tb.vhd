----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2022 11:00:01 PM
-- Design Name: 
-- Module Name: Registers_tb - Behavioral
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
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Registers_tb is
--  Port ( );
end Registers_tb;

architecture Behavioral of Registers_tb is

signal Clk : STD_LOGIC := '0';
signal Mc : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal ReadAddress1 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal ReadAddress2 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal WriteAddress : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal WriteData : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
signal InBus1 : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
signal InBus2: STD_LOGIC_VECTOR (15 downto 0) := (others => '0');

constant CLK_PERIOD : TIME := 10 ns;

begin

DUT: entity WORK.Registers port map (Clk, Mc, ReadAddress1, ReadAddress2, WriteAddress, WriteData, InBus1, InBus2);
    
gen_clk: process
         begin
           Clk <= '0';
           wait for (CLK_PERIOD/2);
           Clk <= '1';
           wait for (CLK_PERIOD/2);
         end process gen_clk; 
    
gen_vect_test: 
process 
begin
       
        Mc <= "0100";

        for i in 0 to 15 loop
            WriteAddress <= STD_LOGIC_VECTOR(to_unsigned(i, WriteAddress'length));
            WriteData <= STD_LOGIC_VECTOR(to_unsigned(i, WriteData'length));
            wait for CLK_PERIOD;
        end loop;
        
        Mc <= "0011";
        
        for i in 0 to 7 loop
             ReadAddress1 <= std_logic_vector(to_unsigned(i, ReadAddress1'length)); 
             ReadAddress2 <= std_logic_vector(to_unsigned(i+8, ReadAddress2'length));
             wait for CLK_PERIOD;
        end loop;
       wait;     
end process;



end Behavioral;
