----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2022 05:40:29 PM
-- Design Name: 
-- Module Name: PC_tb - Behavioral
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

entity PC_tb is
--  Port ( );
end PC_tb;

architecture Behavioral of PC_tb is

signal Clk : STD_LOGIC := '0';
signal Rst : STD_LOGIC := '0';
signal En : STD_LOGIC := '0';
signal Mc : STD_LOGIC_VECTOR (0 to 3) := "0000";
signal Bus2 : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
signal NextAddress : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');


constant CLK_PERIOD : TIME := 10 ns;

begin

DUT: entity WORK.PC port map (Clk, Rst, En, Mc, Bus2, NextAddress);

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
        
        Rst <= '1'; 
        En <= '0';
        wait for CLK_PERIOD;
        
        Rst <= '0'; 
        En <= '1';
        
        Mc <= "1101"; 
        Bus2 <= conv_std_logic_vector(5,16);
        wait for CLK_PERIOD;
        
        Mc <= "0011"; 
        Bus2 <= conv_std_logic_vector(3,16);
        wait for CLK_PERIOD;
        
        Mc <= "1011"; 
        Bus2 <= conv_std_logic_vector(4,16);
        wait for CLK_PERIOD;
        
        Rst<='1'; 
        En<='0';
        
        wait;
end process;

end Behavioral;

