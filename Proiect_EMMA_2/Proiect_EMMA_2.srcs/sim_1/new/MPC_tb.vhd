----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2022 06:29:09 PM
-- Design Name: 
-- Module Name: MPC_tb - Behavioral
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

entity MPC_tb is
--  Port ( );
end MPC_tb;

architecture Behavioral of MPC_tb is

signal Clk : STD_LOGIC := '0';
signal Rst : STD_LOGIC := '0';
signal Mc : STD_LOGIC_VECTOR (0 to 3) := "0000";
signal MU : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal NextAddress : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

constant CLK_PERIOD : TIME := 10 ns;

begin

DUT: entity WORK.MPC port map (Clk, Rst, Mc, MU, NextAddress);

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
        wait for CLK_PERIOD;
        
        Rst <= '0'; 
        
        Mc <= "1101"; 
        wait for CLK_PERIOD;
        
        Mc <= "0011"; 
        MU <= conv_std_logic_vector(5, 8);
        wait for CLK_PERIOD;
        
        Mc <= "1011"; 
        MU <= conv_std_logic_vector(4, 8);
        wait for CLK_PERIOD;
        Rst <= '1'; 
        
        wait;
end process;

end Behavioral;
